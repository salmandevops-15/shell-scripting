#!/bin/bash

Action=$1

case $Action in 

    start)
    echo "starting rabbit MQ"
    ;;
    stop)
    echo "stopping rabbit MQ"
    ;;
    restart)
    echo "restarting rabbit MQ"
    ;;
    enable)
    echo "enabling rabbit MQ"
    ;;
    *)
    echo "the possible inputs are start -- stop -- restart -- enable "
    ;;

esac