#!/bin/bash


COMPONENT="cart"

source components/common.sh

echo -n "Downloading the dependencies for rabbitmq :"
    curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash                      &>> $LOGFILE
    curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash             &>> $LOGFILE
stat $?

echo -n "Installing rabbitmq :"
    yum install rabbitmq-server -y              &>> $LOGFILE
stat $?

echo -n "starting the ${COMPONENT} :"
    systemctl enable rabbitmq-server            &>> $LOGFILE
    systemctl start rabbitmq-server             &>> $LOGFILE
stat $?

rabbitmqctl list_users | grep  roboshop         &>> $LOGFILE
if [ $? -ne 0 ] ; then
echo -n "Creating a user ${COMPONENT} ${APPUSER} :"
rabbitmqctl add_user roboshop roboshop123        &>> $LOGFILE
stat $?
fi

echo -n "Configuring the ${COMPONENT} ${APPUSER} privilages :"
rabbitmqctl set_user_tags roboshop administrator                    &>> $LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"            &>> $LOGFILE
stat $?

echo -e "************ \e[36m Installation of ${COMPONENT} has Completed \e[0m ***************"
