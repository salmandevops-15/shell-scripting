#!/bin/bash


#there are 3 type of if else statement
#1)simple if
#2) if else
#3) else if


#simple if

ACTION=$1

if [ "ACTION" == "start" ] ; then
    echo "starting the rabbitMQ"

fi

if [ "$ACTION" == "start" ] ; then 
        echo -e "\e[32m Starting RabbitMQ Service \e[0m"

fi