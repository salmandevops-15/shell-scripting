#!/bin/bash

COMPONENT=frontend

source components/common.sh


echo -n "installing nginx:"
yum install nginx -y         &>> $LOGFILE
stat $?

echo -n "Starting the nginx :"
systemctl enable nginx       &>> $LOGFILE
systemctl start nginx        &>> $LOGFILE
stat $?


echo -n "Downloading the ${COMPONENT} content :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $?

echo -n "Extracting ${COMPONENT} component :"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/${COMPONENT}.zip        &>> $LOGFILE
mv ${COMPONENT}-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?


echo -n "Updating Reverse proxy with internal DNS_NAME : "
for component in catalogue user cart shipping payment; do
sed -i -e "/$component/s/localhost/$component.roboshop.internal/"   /etc/nginx/default.d/roboshop.conf
done



echo -n "Starting the ${COMPONENT} :"
systemctl daemon-reload      &>> $LOGFILE
systemctl enable nginx       &>> $LOGFILE
systemctl restart nginx        &>> $LOGFILE
stat $?


echo -e "************ \e[36m Installation of ${COMPONENT} has Completed \e[0m ***************"



