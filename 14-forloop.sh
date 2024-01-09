#!/bin/bash

<<COMMENT
### For loop syntax is :

    for item in a b c d e f; do 
        echo value is $item
    done
COMMENT

for var in a b c d e f; do   
    echo the value is $var
done 

for time in 1pm 2pm 3pm 4pm 5pm 6pm; do
    echo "the time is $time"
done