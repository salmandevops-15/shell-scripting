#!/bin/bash


TODAYS_DATE=$(date +%F)

NO_OF_SESSION=$(who|wc -l)

echo "this to show todays date is $TODAYS_DATE"
echo -e "this is to show date in color \e[32m $TODAYS_DATE \e[0m"

echo -e "this to show number of session in color \e[33m $NO_OF_SESSIONS \e[0m"