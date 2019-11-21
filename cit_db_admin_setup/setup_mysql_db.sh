#!/bin/bash

proceed=0
echo "Creating Database..."
# if (file exists) {
#	break;
#	if (log_dir exists) {
#		if (~/mysql exists) {
#			mkdir ~/mysql/log
#		else {
#			mkdir ~/mysql
#			mkdir ~/mysql/log
#		}
#		touch ~/mysql/log/db_setup.log
#	}
#	else mkdir ~/mysql/log
# else touch ~/mysql/log/db_setup.log



if mkdir ~/mysql; then
	if mkdir ~/mysql/log; then
		if touch ~/mysql/log/db_setup.log; then
			
		else 
		fi
	else 
	fi
	
echo "All output will be logged to ~/"
read -n 1 -s -r -p "Press any key to continue"