#!/bin/bash

#!/bin/bash

COMPONENT=catalogue
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










# This service is written in NodeJS, Hence need to install NodeJS in the system.
# # yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
# # yum install nodejs -y  

# ​
# Let's now set up the catalogue application.
# As part of operating system standards, we run all applications as an application user only. Hence, we create and configure everything as an app user. Let’s create “roboshop” user.
# # useradd roboshop