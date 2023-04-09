
#!/usr/bin/env bash
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
	exit
}

invalid_type_error () {
	echo "	       --ERROR--        "
	echo "	Must input valid ticket type:"
	echo "	    [auto] [idea] [issue]"
	echo "	       ---------        "
	echo ""
	exit
}
write_to_file () {
	dir=$1$2
	echo $3>$dir
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
validate_input () {
		#if no parameters are input, show help and exit
	if [[ 0 == $1 ]]; then
		ticket_help
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

	write_to_file $dir $ticket_filename $ticket_content

	ticket_create_success
}

#MAIN ========================================
validate_input $params_count
ticket_create $ticket_type $ticket_filename $ticket_content

