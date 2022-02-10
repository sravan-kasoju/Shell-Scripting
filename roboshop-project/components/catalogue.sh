source components/common.sh

echo "Setup NodeJs repo"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>$LOG_FILE
STAT $?

echo "Install NodeJs"
yum install nodejs gcc-c++ -y &>>$LOG_FILE
STAT $?

echo "create App user"
useradd roboshop &>>$LOG_FILE
STAT $?

echo "Download catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE
STAT $?

echo "Extract catalogue code"
cd /tmp/ &>>$LOG_FILE
unzip -o catalogue.zip &>>$LOG_FILE
STAT $?

echo "Clean catalogue"
rm -rf /home/roboshop/catalogue
STAT $?

echo "copy catalogue content"
cp -r catalogue-main /home/roboshop/catalogue &>>$LOG_FILE
STAT $?

echo "Install NodeJs Dependencies"
cd /home/roboshop/catalogue &>>$LOG_FILE
npm install &>>$LOG_FILE
STAT $?

chown roboshop:roboshop /home/roboshop/ -R &>>$LOG_FILE

echo "update systemD file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' &>>$LOG_FILE
STAT $?

echo "setup catalogue systemD file"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$LOG_FILE
STAT $?

echo "start catalogue"
systemctl daemon-reload &>>$LOG_FILE
systemctl enable catalogue &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE
STAT $?



