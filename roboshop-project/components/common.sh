LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

## BUG about reaching one endpoint , To fix this we are using this command
rm -f /etc/yum.repos.d/endpoint.repo

STAT() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS\e[0m"
  else
    echo -e "\e[1;31m FAILED\e[0m"
    exit
  fi
}

NODEJS() {
  COMPONENT=$1
  echo "Setup NodeJs repo"
  curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>$LOG_FILE
  STAT $?

  echo "Install NodeJs"
  yum install nodejs gcc-c++ -y &>>$LOG_FILE
  STAT $?

  echo "create App user"
  id roboshop &>>$LOG_FILE
  if [ $? -ne 0 ]; then
  useradd roboshop &>>$LOG_FILE
  fi
  STAT $?

  echo "Download ${COMPONENT} code"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG_FILE
  STAT $?

  echo "Extract ${COMPONENT} code"
  cd /tmp/ &>>$LOG_FILE
  unzip -o ${COMPONENT}.zip &>>$LOG_FILE
  STAT $?

  echo "Clean old user"
  rm -rf /home/roboshop/${COMPONENT} &>>$LOG_FILE
  STAT $?

  echo "copy ${COMPONENT} content"
  cp -r ${COMPONENT}-main /home/roboshop/${COMPONENT} &>>$LOG_FILE
  STAT $?

  echo "Install NodeJs Dependencies"
  cd /home/roboshop/${COMPONENT} &>>$LOG_FILE
  npm install &>>$LOG_FILE
  STAT $?

  chown roboshop:roboshop /home/roboshop/ -R &>>$LOG_FILE

  echo "update ${COMPONENT} systemD file"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service &>>$LOG_FILE
  STAT $?

  echo "setup ${COMPONENT} systemD file"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>$LOG_FILE
  STAT $?

  echo "start ${COMPONENT} service"
  systemctl daemon-reload &>>$LOG_FILE
  systemctl enable ${COMPONENT} &>>$LOG_FILE
  systemctl start ${COMPONENT} &>>$LOG_FILE
  STAT $?

}
