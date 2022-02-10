source components/common.sh

echo "Download MongoDB repo file"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE
STAT $?

echo "Install MongoDB"
yum install -y mongodb-org &>>$LOG_FILE
STAT $?

echo "update MongoDB config file"
sed -i -e '/127.0.0.1/0.0.0.0' /etc/mongod.conf &>>$LOG_FILE
STAT $?

echo "start Database"
systemctl enable mongod &>>$LOG_FILE
systemctl start mongod &>>$LOG_FILE
STAT $?

echo "Download Schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG_FILE
STAT $?

echo "Extract Schema"
cd /tmp
unzip -o mongodb.zip &>>$LOG_FILE
STAT $?

echo "Load Schema"
cd mongodb-main
mongo < catalogue.js &>>$LOG_FILE
mongo < users.js &>>$LOG_FILE
STAT $?




