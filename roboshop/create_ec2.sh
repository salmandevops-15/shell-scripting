#!/bin/bash

AMI_ID=$(aws ec2 describe-images --region us-east-1 --image-ids ami-0f75a13ad2e340a58 | jq '.Images[].ImageId' | sed 's/"//g')

echo -e "\e[35m The value of AMI-ID is $AMI_ID  \e[0m"

# aws ec2 describe-images --region us-east-1 --image-ids ami-0f75a13ad2e340a58

# aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t2.micro  --security-group-ids sg-903004f8