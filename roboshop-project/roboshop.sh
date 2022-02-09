#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo -e "\e[1;31m You Should be root user to execute this script...\e[0m"
  exit
fi

if [ -f components/$1.sh ]; then
  bash components/$1.sh
else
  echo -e "\e[1;31mWrong Input\e[0m"
  echo -e "\e[1;33mAvailable Inputs - frontent|mongodb|catalogue||redis|user|cart|mysql|rabbitmq|payment|dispatch|shippingh\e[0m"
fi
