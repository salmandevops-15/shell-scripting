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
id $APPUSER                     &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "Creating a servive account user :"
    useradd $APPUSER                &>> $LOGFILE
fi
stat $?

echo -n "Dowloading the ${COMPONENT} :"
    curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "Copying the ${COMPONENT} to $APPUSER home directory:"
    cd /home/$APPUSER
    rm -r ${COMPONENT}                 &>> $LOGFILE
    unzip -o /tmp/catalogue.zip        &>> $LOGFILE
stat $?

echo -n "Modifying the ownership :"
    mv -f catalogue-main/ catalogue/      &>> $LOGFILE
    chown -R $APPUSER:$APPUSER /home/$APPUSER/${COMPONENT}/
stat $?

echo -n "Installing the dependencies :"
    cd /home/$APPUSER/catalogue
    npm install                         &>> $LOGFILE
stat $?

echo -n "Updating Dns_name in systemd file :"
sed -i -e "s/MONGO_DNSNAME/mongodb.roboshop.internal/"   /home/${APPUSER}/${COMPONENT}/systemd.service
mv /home/${APPUSER}/${COMPONENT}/systemd.service  /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n "Starting the ${COMPONENT} :"
systemctl daemon-reload         &>> $LOGFILE
systemctl start catalogue       &>> $LOGFILE
systemctl enable catalogue      &>> $LOGFILE
stat $?


echo -e "************ \e[36m Installation of ${COMPONENT} has Completed \e[0m ***************"
