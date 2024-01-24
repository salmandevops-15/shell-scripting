#!/bin/bash

COMPONENT=$1
ENV=$2
HOSTEDZONEID=Z079795913TEES271E21K


if [ -z "$1" ] || [ -z "$2" ] ; then

    echo -e "\e[31m Component Name is Needed \e[0m"
    echo -e "\e[36m the possible input is: \n\t\t sudo bash create_ec2.sh ComponentName  EvnName \e[0m"
    exit 1

fi


AMI_ID=$(aws ec2 describe-images --region us-east-1 --image-ids ami-0f75a13ad2e340a58 | jq '.Images[].ImageId' | sed 's/"//g')

SG_ID=$(aws ec2 describe-security-groups --group-ids sg-04b697d4f9bf8c941 | jq '.SecurityGroups[].GroupId' | sed 's/"//g')

IPADDRESS=$(aws ec2 run-instances  --image-id ${AMI_ID}  --instance-type t3.micro   --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT-$ENV}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')




CREATE_EC2 () {

        echo -e "\e[36m The value of AMI-ID is $AMI_ID  \e[0m"
        echo -e "\e[36m The value of SG-ID is $SG_ID  \e[0m"
        echo -e "Private Ip address of $COMPONENT-$ENV server is \e[36m $IPADDRESS \e[0m"



        echo -e "*********** \e[32m LAUNCHING Ec2 instance \e[0m ****************"
        aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro  --count 1 --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" | jq .
        echo -e "*********** \e[32m LAUNCHING Ec2 instance is Completed \e[0m ****************" 
        


        echo -e "\e[36m ***** Creating DNS record for the $COMPONENT-$ENV  ****** \e[0m"
        sed -e "s/COMPONENT/${COMPONENT}-${ENV}/"  -e "s/IPADDRESS/${IPADDRESS}/" route53.json > /tmp/record.json
        aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/record.json
        echo -e "\e[36m **** Creating DNS Record for the $COMPONENT has completed **** \e[0m"

}


if [ "$1" = "all" ] ; then

    for component in frontend mongodb catalogue redis user cart mysql shipping rabbitmq payment ; do
            COMPONENT=$component
            CREATE_EC2
    done
else 
    CREATE_EC2
fi

# #!/bin/bash 

# # AMI_ID="ami-0c1d144c8fdd8d690"

# COMPONENT=$1
# ENV=$2
# HOSTEDZONEID="Z00285561194P4T83R9MO"

# if [ -z "$1" ] || [ -z "$2" ] ; then
#     echo -e "\e[31m COMPONENT NAME IS NEEDED \e[0m"
#     echo -e "\e[35m Ex Usage : \n \t \t bash create-ec2 componentName envName \e[0m "
#     exit 1
# fi 

# AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'|sed -e 's/"//g')
# SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=b54-allow-all | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')

# create_ec2() {

#         echo -e "AMI ID used to launch the EC2 is \e[35m $AMI_ID \e[0m"
#         echo -e "Security Group ID used to launch the EC2 is \e[35m $SG_ID \e[0m"
#         echo -e "\e[36m **** Launching Server **** \e[0m"

#         IPADDRESS=$(aws ec2 run-instances  --image-id ${AMI_ID}  --instance-type t3.micro   --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT-$ENV}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

#         echo -e "\e[36m **** Launching $COMPONENT-$ENV Server is completed **** \e[0m"
#         echo -e "Private IP Address of $COMPONENT-$ENV is \e[35m $IPADDRESS \e[0m"
#         echo -e "\e[36m **** Creating DNS Record for the $COMPONENT : **** \e[0m"

#         sed -e "s/COMPONENT/${COMPONENT}-${ENV}/"  -e "s/IPADDRESS/${IPADDRESS}/" route53.json > /tmp/record.json
#         aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/record.json

#         echo -e "\e[36m **** Creating DNS Record for the $COMPONENT has completed **** \e[0m \n\n"

# }


# if [ "$1" = "all" ]; then    

#     for component in frontend mongodb catalogue redis user cart shipping mysql rabbitmq payment ; do 
#         COMPONENT=$component
#         create_ec2
#     done 

# else 

#     create_ec2

# fi 
        
