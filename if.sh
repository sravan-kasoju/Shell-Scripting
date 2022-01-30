#!/bin/bash

### string expression
a=abc1
if [ $a = "abc" ]
then
   echo OK
fi

if [ $a != "abc" ]
then
  echo NOT OK

fi

if [ -z "$b" ]; then
  echo B is empty / not declared variable
fi