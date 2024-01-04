#!/bin/bash

sample(){
    echo "this to show sample function"
    echo "iam executing sample function"
    echo "sample function is compeleted"

    status
}


status (){
    echo -e "Good morning and todays date is \e[32m $(date +%F) \e[0m"
    echo -e "no of opened sessions is \e[32m $(who | wc -l) \e[0m"
    echo -e "load avg of the system in last one min is \e[32m $(uptime | awk -F , '{print $3}' | awk -F : '{print $2}') \e[0m"
}

sample

#can you see me jhon cena

