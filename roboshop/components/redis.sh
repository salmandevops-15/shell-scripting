#!/bin/bash

COMPONENT=redis
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


echo -n "Configuring the ${COMPONENT} Repo :"
curl -s -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install -y ${COMPONENT}-org          &>> $LOGFILE
stat $?

echo -n "Updating the ${COMPONENT}.conf for DB visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/${COMPONENT}.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/${COMPONENT}/${COMPONENT}.conf
stat $?

echo -n "Starting the ${COMPONENT} :"
systemctl daemon-reload ${COMPONENT}           &>> $LOGFILE
systemctl restart ${COMPONENT}                 &>> $LOGFILE
systemctl enable ${COMPONENT}                  &>> $LOGFILE
stat $?


echo -e "************ \e[36m Installation of ${COMPONENT} is Completed \e[0m ***************"
