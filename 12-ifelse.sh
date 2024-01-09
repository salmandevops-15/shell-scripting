#!/bin/bash

<<COMMENT
### Conditions 

    1. Simple If
    2. If Else 
    3. Else If

* Simple If 

    if [ expression ]; then
        command1
        command2
        command3
    fi 
    
If expression is true then it executes the commands
NOTE: If the expression is false, then it will not perform any thing
 

 * If Else   


    if [ expression ]; then
        command1
        command2
        command3
    else 
        commandx
        commandy
    fi 

If expression is true then it executes the commands
NOTE: If the expression is false, then it will perform the conditions in else


* Else If


    if [ expression1 ]; then
        command1
    
    elif [expression2 ]; then
        command2

    elif  [expression3 ]; then
        command3

    else
        command-x
    fi 

COMMENT



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
    exit 0

elif [ "$Action" == "stop" ] ; then
    echo -e "\e[31m stopping Rabbit MQ \e[0m"
    exit 1

elif [ "$Action" == "restart" ] ; then
    echo -e "\e[34m restarting Rabbit MQ \e[0m"
    exit 2

elif [ "$Action" == "enable" ] ; then
    echo -e "\e[35m enabling Rabbit MQ \e[0m"
    exit 3

else 
    echo -e "\e[36m the possible input are start -- stop -- restart -- enable \e[0m"
    exit 4

fi