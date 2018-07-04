#!/bin/bash
# A simple script to automate keygen/sshc

if [ -z "$2" ];
then
  #ROSPORT=$ROSDEFAULTMACHINE
  echo "ERROR: Not enough arguments"
  echo ""
  echo "Usage: $0 [port] [user]"
  echo "eg: $0 19998 fred"
else
  ROSPORT=$1
  echo "Using port: " $ROSPORT
  echo "Setting up keys for reverse tunnel on ssh port: $ROSPORT"
  ssh-copy-id $2@localhost -p $ROSPORT
fi
