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
