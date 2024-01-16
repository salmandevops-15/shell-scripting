#!/bin/bash

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

CREATING_USER () {
    
    echo -n "Creating a service account :"
id $APPUSER                     &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "Creating a servive account user :"
    useradd $APPUSER                &>> $LOGFILE
fi
stat $?

}

NODEJS () {
    echo -n "Configuring the ${COMPONENT} repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -        &>> $LOGFILE
stat $?

echo -n "Installing the ${COMPONENT} :"
    yum install nodejs -y           &>> $LOGFILE
stat $?

}

echo -e "************ \e[36m Installation of ${COMPONENT} has Started \e[0m ***************"