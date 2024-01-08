#!/bin/bash

##to print anything

echo -e "line1\n\tline2"

#to print colors font

echo -e "\e[32m print green color font \e[0m"
echo -e "\e[33m print yellow color font \e[0m"
echo -e "\e[34m print brown color font \e[0m"
echo -e "\e[35m print blue color font \e[0m"
echo -e "\e[36m print cyan color font \e[0m"

# to print color font with color background

echo -e "\e[43;32m print green color font with yellow background \e[0m"

#variables 

#decleration of variables

a=10
b=11
d=


#to print variables

echo the value of a is $a
echo the value of b is $b
echo the value of d is $d

#dynamic variables

Todays_date="$(date)"

no_of_sessions="$(who|wc -l)"

echo todays date is $Todays_date

echo no of sessions is $no_of_sessions

#to print in color font
echo -e "\e[32m good morning and todays date is $Todays_date \e[0m"

echo -e "\e[34m no of sessions is $no_of_sessions \e [0m"


#special variables

# $0: this will display script name
# $1-$9: we can give input for variable while we execute the script
# $* : this will display variables in the script
# $@ : this will display variables in the script
# $$ : this will give Pid of current process
# $# : this will give number of variables used in the script
# $? : this will give exit code of last command

echo script name is $0
echo trainer name is $1
echo batch number is $2
echo current topic is $3
echo variables used is $*
echo variables used is $@
echo pid of current process is $$
echo no of variables used is $#

#functions 

#decleration of function

sample1 (){
    echo welcome to devops learning
    echo this is batch num 54
    echo  this is end of sample function
    echo calling function2
    sample2
}

#calling function

sample1

#function #2

status(){
    echo -e "\e[36m good morning and todays date is $(date +%F) \e[0m"
    echo -e "\e[35m no of session is $(who | wc -l) \e[0m"
}

#calling function 2

status




