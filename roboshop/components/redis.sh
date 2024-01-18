#!/bin/bash

COMPONENT="redis"

source components/common.sh


echo -n "Configuring the ${COMPONENT} Repo :"
curl -s -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install redis-6.2.13 -y        &>> $LOGFILE
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
