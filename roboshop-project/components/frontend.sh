
source components/common.sh

echo "Installing Nginx"
yum install nginx -y &>>$LOG_FILE
STAT $?

echo "Download Frontend Content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
STAT $?
echo "Clean old content"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
STAT $?

echo "Extract frontend content"
cd /tmp
unzip -o frontend.zip &>>$LOG_FILE
STAT $?

echo "Copy Extracted content to NGINX path"
cp -r frontend-main/static/* /usr/share/nginx/html/ &>>$LOG_FILE
STAT $?

echo "Copy Nginx Roboshop config"
cp frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE
STAT $?

echo "Start Nginx service"
systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE
STAT $?

