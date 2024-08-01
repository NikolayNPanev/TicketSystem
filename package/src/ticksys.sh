#!/bin/bash

###################################
# CopyRight: Nikolay Panev        #
# 2024 - Malko Turnovo, Bulgaria  #
###################################

#GLOBAL USER INPUT PARAMS
params_count=$#
ticket_type=$1
ticket_filename=$2
ticket_content=$3

###############
# OUTPUT ONLY #
###############
ticket_help () {
	echo
	echo "	       --TICKETS--        "
    echo "	Tickets take 3 parametes:"
    echo "	\"ticket [type] [filename] [content]\""
	echo ""
	echo "	Ticket types are:"
	echo "	auto - FutureAutomations [saved in ~/Tickets/FutureAutomation]"
	echo "	issue - Issues [saved in ~/Tickets/Issues]"
	echo "	idea - Ideas [saved in ~/Tickets/Ideas]"
	echo ""
    echo "	Hint:"
    echo "	write contents in \"\""
	echo ""
	echo "	Use alias ideas/issues/f-autos to see the directories and contents"
	echo ""
	echo "	!!! WARNING !!!"
	echo "	If a ticket with the same filename already exists, it will be overwritten!"
        echo "	       ----------        "
        echo 
        exit
}
##################
# ERROR HANDLING #
##################
param_count_error () {
	
	echo
	if [[ 3 > $params_count ]]; then
		echo "	================"
		echo "	=Error code 101="
		echo "	================"
		echo 
		echo "	Too few arguments"
	fi	
	if [[ 3 < $params_count ]]; then
		echo "	================"
		echo "	=Error code 102="
		echo "	================"
		echo 
		echo "	Too many arguments"
	fi	
	echo
	echo "	Tickets take 3 parametes:"
	echo "	\"ticket [type] [filename] [content]\""
	echo "	Hint:"
	echo "	write contents in \"\""
	echo "	       ---------        "
	echo 
	exit
}

invalid_type_error () {
	echo 
	echo "	================"
	echo "	=Error code 103="
	echo "	================"
	echo
	echo "	Invalid ticket type"
	echo
	echo "	Must input valid ticket type:"
	echo "	    [auto] [idea] [issue]"
	echo "	       ---------        "
	echo
	exit
}
###################
# File Operations #
###################
write_to_file () {
	dir=$1$2
	echo "$3">$dir
}

#####################
# Ticket Operations #
#####################
ticket_create_success () {
	#print message on success
	echo
	echo "	       --SUCCESS--        "
	echo "	Ticket created successfully at:"
	echo ""
	echo "	"$dir
	echo ""
	echo "	       -----------        "
	echo
	exit
}

ticket_remove () {
	directory_path=~/Tickets
	file_name=$1
	file_count=$(find $directory_path -name $file_name | wc -l)
	if [[ $file_count -gt 0 ]]; then
		file_path=$(find $directory_path -print | grep $1)
		echo "	Removing ticket: $file_path"
		rm $file_path
	else
		echo
		echo "	================"
		echo "	=Error code 201="
		echo "	================"
		echo
		echo "	\"$1\" doesn't exist!!!"
		echo
	fi
	exit

}

ticket_complete () {
	directory_path=~/Tickets
	file_name=$1
	file_count=$(find $directory_path -name $file_name -type f -not -path "*Complete*"| wc -l)
	if [[ ! -d ~/Tickets/Complete ]];then
		echo "Complete doesn't exist"
		mkdir ~/Tickets/Complete
		echo "Creating folder Complete"
	fi
	if [[ $file_count -gt 0 ]]; then
		file_path=$(find $directory_path -type f -not -path "*Complete*" -print | grep $1)
		echo "	Moving ticket: $file_path"
		cp $file_path $directory_path/Complete
		rm $file_path
	else
		echo
		echo "	===================="
		echo "	=Error code 202/204="
		echo "	===================="
		echo 
		echo "	\"$1\" doesn't exis or is completed!!!"
		echo
	fi
}

ticket_create () {
	#check which directory the ticket goes in,
	#depending on the ticket type
	#on invalid type, print error and exit
	ticket_filename=$2
	ticket_content=$3
	dir=""
	case $1 in
		auto)
		dir=~/Tickets/FutureAutomation/
		;;
		idea)
		dir=~/Tickets/Ideas/
		;;
		issue)
		dir=~/Tickets/Issues/
		;;
		*)
		echo
		echo "	================"
		echo "	=Error code 203="
		echo "	================"
		echo
		echo "	Failed to create ticket"
		echo
		echo "	Reason:"
		invalid_type_error
		;;
	esac

	write_to_file $dir $ticket_filename "$ticket_content"
	ticket_create_success
}

ticket_read () {
	directory_path=~/Tickets
	file_name=$1
	file_count=$(find $directory_path -name $file_name | wc -l)
	if [[ $file_count -gt 0 ]]; then
		file_path=$(find $directory_path -print | grep $1)
		echo "	Reading ticket: $file_path"
		cat $file_path
	else
		echo
		echo "	================"
		echo "	=Error code 202="
		echo "	================"
		echo 
		echo "	\"$1\" doesn't exist!!!"
		echo
	fi
	exit
}

ticket_read_all () {
	directory_path=~/Tickets
	file_count=$(find $directory_path -type f | wc -l)
	if [[ $file_count -gt 0 ]]; then
		tail $directory_path/*/*
	else
		echo
		echo "	================"
		echo "	=Error code 202="
		echo "	================"
		echo
		echo "	No tickets found!!!"
		echo
	fi
	exit
}

####################
# Input Validation #
####################
validate_input () {
		#if no parameters are input, show help and exit
	if [[ 0 == $1 ]]; then
		ticket_help
		exit
	fi
	if [[ --help == $ticket_type ]]; then
		ticket_help
		exit
	fi
	if [[ "remove" == $ticket_type && $params_count == 2 ]]; then
		ticket_remove $ticket_filename
		exit
	fi
	if [[ "complete" == $ticket_type && $params_count == 2 ]]; then
		ticket_complete $ticket_filename
		exit
	fi
	if [[ "read" == $ticket_type && $params_count == 2 ]]; then
		ticket_read $ticket_filename
		exit
	fi
	if [[ "all" == $ticket_type && $params_count == 1 ]]; then
		ticket_read_all
		exit
	fi
	#if number of parameters is !3,
	#echo the error and exit
	if [[ 3 != $1 ]]; then
		param_count_error
		exit
	fi	
}
#MAIN ========================================
validate_input $params_count
ticket_create $ticket_type $ticket_filename "$ticket_content"
