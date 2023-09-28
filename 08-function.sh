#!/bin/bash

sample(){
    echo "this to show sample function"
    echo "iam executing sample function"
    echo "sample function is compeleted"
}

sample

status (){
    echo -e "Good morning and todays date is \e[32m $(date +%F) \e[0m"
    echo -e "no of opened sessions is \e[32m $(who | wc -l) \e[0m"
    