#!/bin/bash


#there are 3 type of if else statement
#1)simple if
#2) if else
#3) else if


#simple if

Action=$1

if [ "$Action" == "start" ] ; then
    echo -e "\e[32m starting the rabbitMQ \e[0m"

fi

#if-else statement

if [ "$Action" == "start" ] ; then
    echo -e "\e[32m starting Rabbit MQ \e[0m"

else
    echo -e "\e[36m the possible input is start \e[0m"

fi

#else-if

if [ "$Action" == "start" ] ; then
    echo -e "\e[32m strating RabbitMQ \e[0m"

elif [ "$Action" == "stop" ] ; then
    echo -e "\e[31m stopping Rabbit MQ \e[0m"

elif [ "$Action" == "restart" ] ; then
    echo -e "\e[34m restarting Rabbit MQ \e[0m"

elif [ "$Action" == "enable" ] ; then
    echo -e "\e[35m enabling Rabbit MQ \e[0m"

else 
    echo -e "\e[36m the possible input are start -- stop -- restart -- enable \e[0m"

fi