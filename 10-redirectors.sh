#!/bin/bash

<<COMMENT
### Redirectors :


>   : Standard Output to a file : ( This will override the existing content on the file : > = 1> )
>>  : Standard Output to a file : ( But, this will not override, just appends on the top of the file )

2>  : Standard Error to a file  

&>  : Redirects both standard output and standard error
&>> : Redirects both standard output and standard error, but appends on the top of the exiting content.

<   : This is to read something from a file and do an action



Exit Status : Every command that you execute will return some status code and based on that code we can decide whether the command is success / failure /partially completed and the command to see the exit code of the previous command is `$?`


In Linux, exit codes range from 0 to 255.

0      : Exit Code means, command completed successfully
1-255  : Either partially completed or failed 

COMMENT


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