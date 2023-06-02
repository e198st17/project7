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
    if [[ $# -ne 3 ]] #Checks that there are 3 arguments
    then
	printf "Error: Must be 3 arguments when 'add' is the first argument\n"
    fi
    
    #Assigns variables
    NICKNAME="$2"
    WEB_ADDRESS="$3"

    #Checks if the given web address exists, if not prints error message
    if ! curl --output /dev/null --silent --head --fail "$WEB_ADDRESS"
    then
	printf "Error: The web addres '$WEB_ADDRESS' does not exist.\n"
	exit
    fi

    #Checks if the nickname given already exists
    if grep -q "^$NICKNAME" "$WEB_FILE"
    then
	printf "Error: The nickname '$NICKNAME' already exists.\n"
	exit
    fi

    #Gets the output of curl for the given web address
    curl_output=$(curl --silent "$WEB_ADDRESS")


    #Adds the nickname, address, and curl output to the .webd file
    echo "$NICKNAME $WEB_ADDRESS $curl_output" >> "$WEB_FILE"
    

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
       
    
