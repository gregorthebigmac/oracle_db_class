#!/bin/bash

working_dir="$(pwd)"
log_file="$working_dir/logs/db_setup.log"
# if the log directory doesn't exist, make it
if [ ! -d "$working_dir/logs" ]; then
	mkdir logs
fi
# if a log file already exists then move it to .old
if [ -f "$log_file" ]; then
	mv "$log_file" "$log_file.old"
fi

touch "$working_dir/logs/db_setup.log"

echo "During this setup, everything will be recorded in a log file located in"
echo "$log_file"
read -n 1 -s -r -p "Press any key to continue"

echo "Also, for your convenience, you can enter your MySQL username to allow"
echo "this script to run without prompting for it each time. You will still"
echo "need to enter your password if prompted, however."
echo -n "MySQL username: "
read username

echo "Creating users..."
if mysql -u "$username" -p < mysql_scripts/create_users.sql; then
	echo "Creating users...[OK]"
else
	echo "Creating users...[FAIL]"
	echo "ERROR: mysql_scripts/create_users.sql Failed. Check the logs."
	exit 1
fi

echo "Creating AP Tables..."
if mysql -u "$username" -p < mysql_scripts/create_ap_tables.sql; then
	echo "Creating AP Tables...[OK]"
else
	echo "Creating AP Tables...[FAIL]"
	echo "ERROR: mysql_scripts/create_ap_tables.sql Failed. Check the logs."
	exit 2
fi

echo "Creating OM Tables..."
if mysql -u "$username" -p < mysql_scripts/create_om_tables.sql; then
	echo "Creating OM Tables...[OK]"
else
	echo "Creating OM Tables...[FAIL]"
	echo "ERROR: mysql_scripts/create_om_tables.sql Failed. Check the logs."
	exit 3
fi

echo "Creating EX Tables..."
if mysql -u "$username" -p < mysql_scripts/create_ex_tables.sql; then
	echo "Creating EX Tables...[OK]"
else
	echo "Creating EX Tables...[FAIL]"
	echo "ERROR: mysql_scripts/create_ex_tables.sql Failed. Check the logs."
	exit 4
fi
