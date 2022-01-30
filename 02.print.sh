#!/bin/bash

echo Hello universe

## When we print some times we print errors and to grab attention of user it is better to print inn color

# Syntax : echo -e "\e[COLmMESS\[0m"
  # -e option to enable esc seq \e
  # \e - to enable color
  # [COLm - COL is color number
  # \e[0m -Disable the color

# COL Name     Col Code
# Red           31
# Green         32
# Yellow        33
# Blue          34
# Magenta       35
# Cyan          36

echo -e "\e[31mRED\e[32mGREEN\e[33mYELLOW\e[34mBLUE\e[35mMAGENTA\e[36mCYAN\e[0m"

echo -e "\e[1;31mRED\e[1;32mGREEN\e[1;33mYELLOW\e[1;34mBLUE\e[1;35mMAGENTA\e[1;36mCYAN\e[0m"


echo -e "line1\nline2"
echo -e "word1\tword2"
