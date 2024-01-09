#!/bin/bash


#redirectors

#two type of redirectors 
#1) input redirector < or 1< (ex: sudo mysql < tmp/studentapp.sql)
#2) output redirector > (overwrite the output of file) and >> (appends the result with old result)

# if we want to save both std output and std error we use &> (ex: ls -ltr &> output.txt)

<<COMMENT
 hi this IS a multi line comment
 we can see this part of the script is not executed 
ppqtwwiyuassb

COMMENT

echo this is practice2


Action=$1

case $Action in 

    start)
    echo -e "\e[32m starting the rabbit MQ \e[0m"
    ;;
    stop)
    echo -e "\e[31m stopping the rabbitMQ \e[0m"
    ;;
    restart)
    echo -e "\e[34m restarting the rabbit MQ \e[0m"
    ;;
    enable)
    echo -e "\e[36m enabling the rabbit MQ \e[om"
    ;;
    *)
    echo -e "\e[35m the possible inputs are start -- stop -- restrat -- enable \e[0m"
    ;;
esac