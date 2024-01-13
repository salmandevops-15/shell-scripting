#!/bin/bash

COMPONENT=mongodb
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
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo  &>> LOGFILE
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install -y ${COMPONENT}-org         &>> LOGFILE
stat $?

echo -n "Updating the ${COMPONENT}.conf for DB visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Starting the ${COMPONENT} :"
systemctl daemon-reload mongod          &>> LOGFILE
systemctl restart mongod                &>> LOGFILE
systemctl enable mongod                 &>> LOGFILE
stat $?

echo -n "Downloading the schema :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?


echo -n "Extraction  the schema :"
cd /tmp
unzip -o ${COMPONENT}.zip                  &>> LOGFILE
stat $?

echo -n "Injection of schema :"
cd ${COMPONENT}-main
mongo < catalogue.js                    &>> LOGFILE
mongo < users.js                        &>> LOGFILE
stat $?


echo -e "************ \e[36m Installation of ${COMPONENT} is Completed \e[0m ***************"




# 1. Setup MongoDB repos.

# ```bash
# # curl -s -o /etc/yum.repos.d/${COMPONENT}odb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
# ```

# 1. Install Mongo & Start Service.

# ```bash
# # yum install -y mongodb-org
# # systemctl enable mongod
# # systemctl start mongod

# ```

# 1. Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.

# Config file:   `# vim /etc/mongod.conf`