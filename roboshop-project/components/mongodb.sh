source components/common.sh

echo "Download MongoDB repo file"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG_FILE

echo "Install MongoDB"
yum instal -y mongodb-org &>>$LOG_FILE

echo "update MongoDB config file"
sed -i -e '/127.0.0.1/0.0.0.0' /etc/mongod.conf &>>$LOG_FILE

echo "start MongoDB service"
systemctl enable mongod
systemctl start mongod

echo "Load Schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG_FILE
cd /tmp
unzip -o mongodb.zip &>>$LOG_FILE
cd mongodb-main &>>$LOG_FILE
mongo < catalogue.js &>>$LOG_FILE
mongo < users.js &>>$LOG_FILE



