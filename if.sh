#!/bin/bash

### string expression
a=abc1
if [ $a = "abc" ]
then
   echo OK
fi

if [ $a != "abc"]
then
  echo NOT OK

fi
