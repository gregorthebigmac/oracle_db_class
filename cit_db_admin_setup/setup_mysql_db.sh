#!/bin/bash

boo
echo "Creating Database..."
if mkdir ~/mysql; then
	if mkdir ~/mysql/log; then
		if touch ~/mysql/log/db_setup.log; then
			
echo "All output will be logged to ~/"
read -n 1 -s -r -p "Press any key to continue"