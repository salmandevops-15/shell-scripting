#!/bin/bash


COMPONENT="mysql"

source components/common.sh

echo -n "Configuring the ${COMPONENT} Repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install mysql-community-server -y
stat $?


echo -n "Starting the ${COMPONENT} :"
systemctl enable mysqld 
systemctl start mysqld
stat $?

echo -n "fetching the root user default password :"
DEFAULT_ROOT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
stat $?

echo "show databases;" | mysql -uroot -pRoboShop@1
if [ $? -ne 0 ]; then
echo -n "Updating the Root user password with std password:"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY RoboShop@1;" | mysql --connect -expired -password -uroot -p${DEFAULT_ROOT_PASSWORD}
stat $?
fi

# echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password
# if [ $? -eq 0 ]; then
# echo -n "Uninstalling Validate_password plugin :"
# echo " " | mysql --connect -expired -password -uroot -p${DEFAULT_ROOT_PASSWORD}
# stat $?
# fi
