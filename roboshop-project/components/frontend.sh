echo "Installing frontend"
yum install nginx -y >>/tmp/roboshop.log

echo "Download Frontend Content"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>/tmp/roboshop.log

