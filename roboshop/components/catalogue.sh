#!/bin/bash


COMPONENT=catalogue

source components/common.sh

NODEJS

CREATING_USER

DOWNLOAD_AND_EXTRACT


echo -n "Installing the dependencies :"
    cd /home/$APPUSER/${COMPONENT}
    npm install                         &>> $LOGFILE
stat $?

echo -n "Updating Dns_name in systemd file :"
sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/"   /home/${APPUSER}/${COMPONENT}/systemd.service
mv /home/${APPUSER}/${COMPONENT}/systemd.service  /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the ${COMPONENT} :"
systemctl daemon-reload              &>> $LOGFILE
systemctl enable ${COMPONENT}        &>> $LOGFILE
systemctl restart ${COMPONENT}       &>> $LOGFILE

stat $?


echo -e "************ \e[36m Installation of ${COMPONENT} has Completed \e[0m ***************"
