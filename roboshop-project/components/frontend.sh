
LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

echo "Installing frontend"
yum install nginx -y &>>$LOG_FILE

echo "Download Frontend Content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
echo "Clean old content"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE

echo "Extract frontend content"
cd /usr/share/nginx/html/ &>>$LOG_FILE
unzip /tmp/frontent.zip &>>$LOG_FILE

