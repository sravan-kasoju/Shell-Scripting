#!/bin/bash

AMI_ID=$(aws ec2 describe-images --filters "Name-name,values=centos-7-Devops-Practice" --query 'Images[*],[ImageID]' --output text)
if [ -z "${AMI_ID}" ]; then
  echo -e "\e[1;31mUnable to find Image AMI_ID\e[0m"
else
  echo -e "\e[32mAMI ID = ${AMI_ID}\e[0m"
fi