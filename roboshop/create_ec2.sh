#!/bin/bash

COMPONENT=$1
ENV=$2
HOSTEDZONE_ID=Z079795913TEES271E21K


if [ -z $1 ] ; then

    echo -e "\e[31m Component Name is Needed \e[0m"
    echo -e "\e[36m the possible input is: \n\t\t sudo bash create_ec2.sh ComponentName \e[0m"
   
    exit 1
fi


AMI_ID=$(aws ec2 describe-images --region us-east-1 --image-ids ami-0f75a13ad2e340a58 | jq '.Images[].ImageId' | sed 's/"//g')

SG_ID=$(aws ec2 describe-security-groups --group-ids sg-04b697d4f9bf8c941 | jq '.SecurityGroups[].GroupId' | sed 's/"//g')

IPADDRESS=$(aws ec2 run-instances  --image-id ${AMI_ID}  --instance-type t3.micro   --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT-$ENV}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')




CREATE_EC2 () {

        echo -e "\e[36m The value of AMI-ID is $AMI_ID  \e[0m"
        echo -e "\e[36m The value of SG-ID is $SG_ID  \e[0m"



        echo -e "*********** \e[32m LAUNCHING Ec2 instance \e[0m ****************"
        aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro  --count 1 --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq .
        echo -e "*********** \e[32m LAUNCHING Ec2 instance is Completed \e[0m ****************" 
        

        echo -e "Private Ip address of $COMPONENT-$ENV server is \e[36m $IPADDRESS \e[0m"


        echo -e "\e[36m ***** Creating DNS record for the $COMPONENT-$ENV  ****** \e[0m"
        sed -e "s/COMPONENT/${COMPONENT}-${ENV}/"  -e "s/IPADDRESS/${IPADDRESS}/" route53.json > /tmp/record.json
        aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/record.json
        echo -e "\e[36m **** Creating DNS Record for the $COMPONENT has completed **** \e[0m"

}


if [ "$1" = "all" ] ; then

    for component in frontend mongodb catalogue redis user cart mysql shipping  rabbitmq payment ; do

            COMPONENT=$component
            
            CREATE_EC2
    done

else 

    CREATE_EC2

fi


# aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type t2.micro  --security-group-ids $SG_ID | jq .   


# aws ec2 describe-security-groups --group-ids sg-04b697d4f9bf8c941 | jq '.SecurityGroups[].GroupId' | sed 's/"//g'

# aws ec2 describe-security-groups --group-ids sg-04b697d4f9bf8c941




# aws ec2 describe-images --region us-east-1 --image-ids ami-0f75a13ad2e340a58            ## command to fetch ami details

# aws ec2 run-instances --image-id ami-xxxxxxxx --count 1 --instance-type t2.micro  --security-group-ids sg-903004f8         ## command to create ec2 instance
