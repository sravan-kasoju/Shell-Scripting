source components/common.sh

echo "Configure yum repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG_FILE
STAT $?

echo "Install RabbitMQ and Erlang"
 yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>>$LOG_FILE
STAT $?

echo "Start RabbitMQ server"
systemctl enable rabbitmq-server &>>$LOG_FILE
systemctl restart rabbitmq-server &>>$LOG_FILE
STAT $?

echo "Create App User"
rabbitmqctl list_users | grep roboshop &>>$LOG_FILE
if [ $? -ne 0 ]; then
  rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
fi
STAT $?

echo "setup Permissions for app user"
rabbitmqctl set_user_tags roboshop administrator &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE



