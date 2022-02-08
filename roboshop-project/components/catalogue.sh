source components/common.sh

echo "Setup NodeJs repo"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>$LOG_FILE

echo "Install NodeJs"
yum install nodejs gcc-c++ -y &>>$LOG_FILE

echo "create App user"
useradd roboshop &>>$LOG_FILE

echo "Download catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG_FILE

echo "Extract catalogue code"
cd /tmp/ &>>$LOG_FILE
unzip -o catalogue.zip &>>$LOG_FILE

echo "copy catalogue content"
cp -r catalogue-main /home/roboshop/catalogue &>>$LOG_FILE

echo "Install NodeJs Dependencies"
cd /home/roboshop/catalogue &>>$LOG_FILE
npm install &>>$LOG_FILE

