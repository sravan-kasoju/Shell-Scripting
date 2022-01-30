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

echo -e "\e[31RED\e[32GREEN\e[33YELLOW\e[34BLUE\e[35MAGENTA\e[CYAN\e[0m"
