#!/bin/bash

AMI_ID=$(aws ec2 describe-images --region us-east-1 --image-ids ami-0f75a13ad2e340a58 | jq '.Images[].ImageId' | sed 's/"//g')

SG_ID=$(aws ec2 describe-security-groups --group-ids sg-04b697d4f9bf8c941 | jq '.SecurityGroups[].GroupId' | sed 's/"//g')

echo -e "\e[36m The value of AMI-ID is $AMI_ID  \e[0m"
echo -e "\e[36m The value of SG-ID is $SG_ID  \e[0m"


# aws ec2 describe-security-groups --group-ids sg-04b697d4f9bf8c941 | jq '.SecurityGroups[].GroupId' | sed 's/"//g'

# aws ec2 describe-security-groups --group-ids sg-04b697d4f9bf8c941




# aws ec2 describe-images --region us-east-1 --image-ids ami-0f75a13ad2e340a58            ## command to fetch ami details

# aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t2.micro  --security-group-ids sg-903004f8         ## command to create ec2 instance
