
#!/usr/bin/env bash

#GLOBAL USER INPUT PARAMS
params_count=$#
ticket_type=$1
ticket_filename=$2
ticket_content=$3

ticket_help () {
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
        echo ""
        exit
}
param_count_error () {

	echo "	       --ERROR--        "
	echo "	Tickets take 3 parametes:"
	echo "	\"ticket [type] [filename] [content]\""
	echo "	Hint:"
	echo "	write contents in \"\""
	echo "	       ---------        "
	echo ""
	if [[ 3 > $params_count ]]; then
		echo "	================"
		echo "	=Error code 101="
		echo "	================"
	fi	
	if [[ 3 < $params_count ]]; then
		echo "	================"
		echo "	=Error code 102="
		echo "	================"
	fi	
	exit
}

invalid_type_error () {
	echo "	       --ERROR--        "
	echo "	Must input valid ticket type:"
	echo "	    [auto] [idea] [issue]"
	echo "	       ---------        "
	echo ""
	echo "	================"
	echo "	=Error code 103="
	echo "	================"
	exit
}
write_to_file () {
	dir=$1$2
	echo "$3">$dir
}
ticket_create_success () {
	#print message on success
	echo "	       --SUCCESS--        "
	echo "	Ticket created successfully at:"
	echo ""
	echo "	"$dir
	echo ""
	echo "	       -----------        "
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
		echo "	\"$1\" doesn't exist!!!"
		echo "	================"
		echo "	=Error code 201="
		echo "	================"
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
		echo "	\"$1\" doesn't exis or is completed!!!"
		echo "	================"
		echo "	=Error code 202="
		echo "	================"
	fi
}

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
	#if number of parameters is !3,
	#echo the error and exit
	if [[ 3 != $1 ]]; then
		param_count_error
		exit
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
		invalid_type_error
		;;
	esac

	write_to_file $dir $ticket_filename "$ticket_content"
	ticket_create_success
}

#MAIN ========================================
validate_input $params_count
ticket_create $ticket_type $ticket_filename "$ticket_content"
