###################################
# CopyRight: Nikolay Panev        #
# 2024 - Malko Turnovo, Bulgaria  #
###################################

APP_NAME=ticket
BUILDER=shc -f
main=./src/ticksys.sh
proj_bin=./bin
MAIN_BUILD_VAR=$(BUILDER) $(main) -o $(proj_bin)/$(APP_NAME)
install_bin=/usr/local/bin/ticket

all: ticket

ticket: src/ticksys.sh
	$(MAIN_BUILD_VAR)

#Clean and build the binaries
clean:
	rm -f $(proj_bin)/*
	$(MAIN_BUILD_VAR)

install: ticket
	sudo cp $(proj_bin)/$(APP_NAME) $(install_bin)
# Make ticket directories
	mkdir -p ~/Tickets/Ideas
	mkdir -p ~/Tickets/Issues
	mkdir -p ~/Tickets/Automations
	