#!/bin/bash

#Lucas Ferns, Project7
#EVE198
#webdiff.sh script

#Checks if the first argument is 'add'
if [[ "$1" = "add" ]]
then
    if [[ $# -ne 2 ]]
    then
	printf "Error: Must be two arguments when 'add' is the first argument\n"
    fi


#Chekcs if the first argument is 'check'
elif [[ "$1" = "check" ]]
then
    if [[ $# -ne 2 ]]
    then
	printf "Error: Must be two arguments when 'check' is the first argument\n"
    fi


#Checks if the first arugment is 'list'
elif [[ "$1" = "list" ]]
then
    if [[ $# -ne 1 ]]
    then
	printf "Error: Must be only one argument when 'list' argument is used\n"
    fi 


#Error message for incorrect first argument
else
    printf "Error: first arugment must be 'add', 'check', or 'list'\n"
fi
       
    
