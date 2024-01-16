#!/bin/bash


COMPONENT=catalogue

source components/common.sh

NODEJS

CREATING_USER

echo -n "Dowloading the ${COMPONENT} :"
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Copying the ${COMPONENT} to $APPUSER home directory:"
    cd /home/$APPUSER
    rm -r ${COMPONENT}                 &>> $LOGFILE
    unzip -o /tmp/${COMPONENT}.zip        &>> $LOGFILE
stat $?

echo -n "Modifying the ownership :"
    mv -f ${COMPONENT}-main/ ${COMPONENT}/      &>> $LOGFILE
    chown -R $APPUSER:$APPUSER /home/$APPUSER/${COMPONENT}/
stat $?

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
