#!/bin/bash

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
    echo -e "\e[36m enabling the rabbit MQ \e[0m"
    ;;
    *)
    echo -e "\e[35m the possible inputs are start -- stop -- restrat -- enable \e[0m"
    ;;
esac