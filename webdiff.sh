#!/bin/bash

#Lucas Ferns, Project7
#EVE198
#webdiff.sh

#creates a variable for the file that is created
WEB_FILE=~/.webd

if ! [[ -f "$HOME/.webd" ]] #Checks if the file does not exist in the home directory
then
    touch $HOME/.webd #Creates the file if it does not already exist
fi

#Checks if the first argument is 'add'
if [[ "$1" = "add" ]]
then
    if [[ $# -ne 2 ]] #Checks that there are 2 arguments
    then
	printf "Error: Must be two arguments when 'add' is the first argument\n"
    fi


#Chekcs if the first argument is 'check'
elif [[ "$1" = "check" ]]
then
    if [[ $# -ne 2 ]] #Checks that there are 2 arguments
    then
	printf "Error: Must be two arguments when 'check' is the first argument\n"
    fi


#Checks if the first arugment is 'list'
elif [[ "$1" = "list" ]]
then
    if [[ $# -ne 1 ]] #Checks that there is only one arugment
    then
	printf "Error: Must be only one argument when 'list' argument is used\n"
    fi
    awk '{ print $1 }' "$WEB_FILE" #prints the first column of webd file (the nicknames)
   


#Error message for incorrect first argument
else
    printf "Error: first arugment must be 'add', 'check', or 'list'\n"
fi
       
    
