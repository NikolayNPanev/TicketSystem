##!/usr/bin/env bash

create_ticket_dirs () {
	if [ -d ~/Tickets ]; then
		echo "	Tickets Directory already exists"
	else
		mkdir ~/Tickets
		echo "	Created ~/Tickets"
	fi
	if [ -d ~/Tickets/Issues ]; then
		echo "	Tickets/Issues Directory already exists"
	else
		mkdir ~/Tickets
		echo "	Created ~/Tickets/Issues"
	fi
	if [ -d ~/Tickets/Ideas ]; then
		echo "	Tickets/Ideas Directory already exists"
	else
		mkdir ~/Tickets
		echo "	Created ~/Tickets/Ideas"
	fi
	if [ -d ~/Tickets/FutureAutomations ]; then
		echo "	Tickets/FutureAutomations Directory already exists"
	else
		mkdir ~/Tickets
		echo "	Created ~/Tickets/FutureAutomations"
	fi
	if [ -d ~/TicketSystem ]; then
		echo "	TicketSystem Directory already exists"
	else
		mkdir ~/TicketSystem
		echo "	Created ~/TicketSystem"
		cp ./ticksys.sh ~/TicketSystem/
		cp ./install.bash ~/TicketSystem/
		cp ./ticksys_documentation ~/TicketSystem/
	fi

}

create_ticket_aliases () {
	#if alias DOES NOT exist, create it, else, do not
	if $(grep -q 'alias ticket=' ~/.bash_aliases) ; then
		echo "	Alias ticket already exists"
	else
		cat ticket_alias.alias >> ~/.bash_aliases
	fi
	if $(grep -q 'alias issues=' ~/.bash_aliases) ; then
		echo "	Alias issues already exists"
	else
		cat issues.alias >> ~/.bash_aliases
	fi
	if $(grep -q 'alias f-autos=' ~/.bash_aliases) ; then
		echo "	Alias f-autos already exists"
	else
		cat f-autos.alias >> ~/.bash_aliases
	fi
	if $(grep -q 'alias ideas=' ~/.bash_aliases) ; then
		echo "	Alias ideas already exists"
	else
		cat ideas.alias >> ~/.bash_aliases
	fi
	if $(grep -q 'alias all-tickets=' ~/.bash_aliases) ; then
		echo "	Alias all-tickets already exists"
	else
		cat all-tickets.alias >> ~/.bash_aliases
	fi
}

#MAIN
create_ticket_dirs
create_ticket_aliases

exit