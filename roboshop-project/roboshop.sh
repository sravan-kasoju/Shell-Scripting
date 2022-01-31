#!/bin/bash

if [ -f components/$1.sh ]; then
  bash components/$1.sh
else
  echo "wrong Input"
  echo "Available Inputs - frontent|mongodb|catalogue||redis|user|cart|mysql|rabbitmq|payment|dispatch|shippingh"
fi
