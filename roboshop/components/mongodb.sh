#!/bin/bash

COMPONENT=mongodb

source components/common.sh


echo -n "Configuring the ${COMPONENT} Repo :"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo  &>> LOGFILE
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install -y ${COMPONENT}-org          &>> $LOGFILE
stat $?

echo -n "Updating the ${COMPONENT}.conf for DB visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting the ${COMPONENT} :"
systemctl daemon-reload mongod           &>> $LOGFILE
systemctl restart mongod                 &>> $LOGFILE
systemctl enable mongod                  &>> $LOGFILE
stat $?

echo -n "Downloading the schema :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?


echo -n "Extraction  the schema :"
cd /tmp
unzip -o ${COMPONENT}.zip                   &>> $LOGFILE
stat $?

echo -n "Injection of schema :"
cd ${COMPONENT}-main
mongo < catalogue.js                     &>> $LOGFILE
mongo < users.js                         &>> $LOGFILE
stat $?


echo -e "************ \e[36m Installation of ${COMPONENT} is Completed \e[0m ***************"



