#!/bin/bash

if [ -f components/$1.sh ]; then
  bash components/$1.sh
else
  echo -e "\e[1;31mWrong Input\e[0m"
  echo -e "\e[1;33mAvailable Inputs - frontent|mongodb|catalogue||redis|user|cart|mysql|rabbitmq|payment|dispatch|shippingh\e[0m"
fi
