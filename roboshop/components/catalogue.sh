#!/bin/bash

#!/bin/bash

COMPONENT=catalogue
LOGFILE="/tmp/${COMPONENT}.logs"
APPUSER=roboshop

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

echo -n "Configuring the ${COMPONENT} repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -        &>> $LOGFILE
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install nodejs -y           &>> $LOGFILE
stat $?


echo -n "Creating a service account :"
id roboshop                     &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "Creating a servive account user :"
    useradd roboshop                &>> $LOGFILE
fi
stat $?

echo -n "Dowloading the ${COMPONENT} :"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?





# This service is written in NodeJS, Hence need to install NodeJS in the system.
# # yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
# # yum install nodejs -y  

# ​
# Let's now set up the catalogue application.
# As part of operating system standards, we run all applications as an application user only. Hence, we create and configure everything as an app user. Let’s create “roboshop” user.
# # useradd roboshop