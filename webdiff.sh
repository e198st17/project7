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
	exit
    fi
    
    #Assigns variables
    NICKNAME="$2"
    WEB_ADDRESS="$3"

    #Checks if the given web address exists, if not prints error message
    if ! curl --output /dev/null --silent --head --fail "$WEB_ADDRESS"
    then
	printf "Error: The web address '$WEB_ADDRESS' does not exist.\n"
	exit
    fi

    #Checks if the nickname given already exists
    if grep -q "^$NICKNAME" "$WEB_FILE"
    then
	printf "Error: The nickname '$NICKNAME' already exists.\n"
	exit
    fi

    #Gets the cleaned output of curl for the given web address
    curl_output=$(curl -s "$WEB_ADDRESS" | tr -d " " | tr -d "\n" | tr -d "|" | tr -d "%")


    #Adds the nickname, address, and curl output to the .webd file
    echo "$NICKNAME|$WEB_ADDRESS|$curl_output" >> "$WEB_FILE"
    printf "The website '$WEB_ADDRESS' has been added with the nickname '$NICKNAME'.\n"
    

#Checks if the first argument is 'check'
elif [[ "$1" = "check" ]]
then
    if [[ $# -ne 2 ]] #Checks that there are 2 arguments
    then
	printf "Error: Must be two arguments when 'check' is the first argument\n"
	exit
    fi

    #Sets the nickname variable
    NICKNAME=$2

    #Checks if the nickname exists in the file
    if ! grep -q "^$NICKNAME" "$WEB_FILE"
    then
	printf "Error: The nickname '$NICKNAME' does not exist.\n"
	exit
    fi

    #gets the stored curl output from when the address was added to file
    previous_curl=$(grep "^$NICKNAME|" "$WEB_FILE" | awk -F '|' '{print $3}')

    
    #Gets the current curl output from the website
    current_address=$(grep "^$NICKNAME|" "$WEB_FILE" | awk -F '|' '{print $2}')
    current_curl=$(curl -s $current_address | tr -d " " | tr -d "\n" | tr -d "|" | tr -d "%")
    


    #check if there are differnces
    if [ "$current_curl" = "$previous_curl" ]
    then
	printf "There were no changes in the website '$current_address' (Nickname: '$NICKNAME').\n"
    else
	printf "There were changes for website '$current_address'. Changes detected:\n"

	#Prints the differences, uses process substitution because diff takes files as input
	diff <(echo "$previous_curl") <(echo "$current_curl")

	#Updates the previous curl output with the current curl output
	sed -i "s/^$NICKNAME|.*/$NICKNAME|$current_address|$current_curl/" "$WEB_FILE"
	printf "File has been updated with the current website.\n"
    fi

#Checks if the first arugment is 'list'
elif [[ "$1" = "list" ]]
then
    if [[ $# -ne 1 ]] #Checks that there is only one arugment
    then
	printf "Error: Must be only one argument when 'list' argument is used\n"
	exit
    fi

    #prints the nicknames that are currently in the file
    printf "Nicknames currently added:\n"
    awk -F '|' '{print $1}' "$WEB_FILE" 
   


#Error message for incorrect first argument
else
    printf "Error: first arugment must be 'add', 'check', or 'list'\n"
fi
       
    
