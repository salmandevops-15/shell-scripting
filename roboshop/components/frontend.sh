#!/bin/bash

COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.logs"

ID=$(id -u)

if [ $ID -ne 0 ] ; then
    echo -e "\e[31m This script needs to run by a root user or user with sudo privilage \e[0m"
    exit 1
fi

stat () {
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m SUCCESSFUL \e[0m"
else
    echo -e "\e[31m FAILURE \e[0m"
fi

}

echo -e "************ \e[36m Installation of ${COMPONENT} has Started \e[0m ***************"


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


echo -n "Updating Reverse proxy with internal DNS_NAME :"
for component in catalogue user cart shipping payment; do
sed -i -e '/$component/s/localhost/$component.roboshop.internal/'   /etc/nginx/default.d/roboshop.conf
done

echo -n "Starting the ${COMPONENT} :"
systemctl enable nginx       &>> $LOGFILE
systemctl start nginx        &>> $LOGFILE
stat $?


echo -e "************ \e[36m Installation of ${COMPONENT} has Completed \e[0m ***************"




# ```
# # yum install nginx -y
# # systemctl enable nginx
# # systemctl start nginx

# ```

# Let's download the HTDOCS content and deploy it under the Nginx path.

# ```
# # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

# ```

# Deploy in Nginx Default Location.

# ```
# # cd /usr/share/nginx/html
# # rm -rf *
# # unzip /tmp/frontend.zip
# # mv frontend-main/* .
# # mv static/* .
# # rm -rf frontend-main README.md
# # mv localhost.conf /etc/nginx/default.d/roboshop.conf

# ```