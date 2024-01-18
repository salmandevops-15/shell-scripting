#!/bin/bash


COMPONENT="mysql"

source components/common.sh

echo -n "Configuring the ${COMPONENT} Repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install mysql-community-server -y       &>> $LOGFILE
stat $?


echo -n "Starting the ${COMPONENT} :"
systemctl enable mysqld                     &>> $LOGFILE
systemctl start mysqld                      &>> $LOGFILE
stat $?


echo -n "fetching the root user default password :"
DEFAULT_ROOT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk  '{print $NF}' )      &>> $LOGFILE
stat $?


echo "show databases;" | mysql -uroot -pRoboShop@1      &>> $LOGFILE
if [ $? -ne 0 ]; then
echo -n "Updating the Root user password with std password:"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PASSWORD}   &>> $LOGFILE
stat $?
fi

echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password  &>> $LOGFILE
if [ $? -eq 0 ]; then
echo -n "Uninstalling validate_password plugin :"
echo "UNINSTALL PLUGIN validate_password;" | mysql -uroot -pRoboShop@1   &>> $LOGFILE
stat $?
fi


echo -n "Downloading the ${COMPONENT} schema :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
stat $?


echo -n "Extracting the ${COMPONENT} schema :"
cd /tmp
unzip ${COMPONENT}.zip
stat $?

echo -n "Injecting the ${COMPONENT} schema :"
cd ${COMPONENT}-main
mysql -u root -pRoboShop@1 <shipping.sql
stat $?

echo -e "************ \e[36m Installation of ${COMPONENT} has Completed \e[0m ***************"

