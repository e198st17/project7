#!/bin/bash

#Lucas Ferns, Project7
#EVE198
#webdiff.sh script

#Checks if the first argument is 'add'
if [[ "$1" = "add" ]]
then
    printf "Your first argument was add!"


#Chekcs if the first argument is 'check'
elif [[ "$1" = "check" ]]
then
   printf "Your first argument was check!"


#Checks if the first arugment is 'list'
elif [[ "$1" = "list" ]]
then
   printf "Your first argument was list!"


#Error message for incorrect first argument
else
    printf "Error, first arugment must be 'add', 'check', or 'list'\n"
fi
       
    
