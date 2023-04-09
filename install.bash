##!/usr/bin/env bash

create_ticket_dirs () {
	if [ -d ~/Tickets ]; then
		echo "	Tickets Directory already exists"
	else
		mkdir ~/Tickets
		echo "	Created ~/Tickets"
	fi
}

create_ticket_dirs
exit