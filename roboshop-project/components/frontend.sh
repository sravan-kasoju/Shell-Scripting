
source components/common.sh

echo "Installing Nginx"
yum install nginx -y &>>$LOG_FILE
if [ $? -eq 0 ]; then
 echo -e "\e[1;32m SUCCESS\e[0m"
else
  echo -e "\e[1;32m FAILED\e[0m"
 exit
fi

echo "Download Frontend Content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
echo "Clean old content"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE

echo "Extract frontend content"
cd /tmp
unzip -o frontent.zip &>>$LOG_FILE

echo "Copy Extracted content to NGINX path"
cp -r frontend-main/static/* /usr/share/nginx/html/ &>>$LOG_FILE

echo "Copy Nginx Roboshop config"
cp frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE

echo "Start Nginx service"
systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE


