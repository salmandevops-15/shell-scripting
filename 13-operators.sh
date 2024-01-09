#!/bin/bash


<<COMMENT
### Expressions are categorized in to three

    1. Numbers
    2. Strings
    3. Files


Operators on numbers:

    -eq , -ne , -gt, -ge, -lt, -le

    [ 1 -eq 1 ] 
    [ 1 -ne 1 ]


Operators on Strings:
    = , == , !=

    [ abc = abc ] (we are assigning rightside value to left side )
    [ abc == abc ] ( we are comparing left side with right side )
    [ abc != efg ] ( we saying that left side is not equal to right side )
    -z , -n 

    [ -z "$var" ] -> This is true if var is not having any data
    [ -n "$var" ] _> This is true if var is having any data

    -z and -n are inverse proportional options


Operators on files:
    Lot of operators are available and you can check them using man pages of bash 

    [ -f file ] -> True of file exists and file is a regular file 

    [ -d xyz ]  -> True if file exists and it is a directory

### Explore the file types, There are 7 types on files in Linux.

COMMENT