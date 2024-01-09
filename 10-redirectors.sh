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


#quotes 
#there are 2 types of quotes
#1) double quote "" (this will consider the variable and display the variable value ex: echo "the value of a is ${a}"  the o/p will be the value of a is 53 or whatever variable is declared)
#2) single quote '' (this will not consider the variable and displays as a string ex: echo 'the value of a is ${a}'  the o/p will be the value of a is ${a})