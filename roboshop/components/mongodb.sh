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

echo -n "Configuring the ${COMPONENT} Repo :"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo  &>> LOGFILE
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install -y ${COMPONENT}-org         &>> LOGFILE
systemctl enable mongod                 &>> LOGFILE
systemctl start mongod                  &>> LOGFILE
stat $?

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