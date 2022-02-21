source components/common.sh


echo "Setting up MySQL repo"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>$LOG_FILE
STAT $?

echo "Install Mysql server"
yum install mysql-community-server -y &>>$LOG_FILE
STAT $?

echo "Start mysql service"
systemctl enable mysqld &>>$LOG_FILE
systemctl start mysqld &>>$LOG_FILE
STAT $?



