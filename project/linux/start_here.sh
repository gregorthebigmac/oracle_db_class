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

echo "Also, for your convenience, you can enter your MySQL username and password"
echo "to allow this script to run without prompting for it each time."
echo -n "MySQL username: "
read username
echo -n "MySQL password: "
read -s password
echo "Creating users and roles..."
# you'll notice NO space between -p and "$password" this is not a typo!
# This is the only way it works!
if mysql -u "$username" -p"$password" < users/create_users.sql; then
	echo "Creating users and roles...[OK]"
else
	echo "Creating users and roles...[FAIL]"
	echo "ERROR: $working_dir/users/create_users.sql Failed. Check the logs."
	exit 1
fi

echo "Creating database..."
if mysql -u "$username" -p"$password" < database/create_database.sql; then
	echo "Creating database...[OK]"
else
	echo "Creating database...[FAIL]"
	echo "ERROR: $working_dir/database/create_database.sql Failed. Check the logs."
	exit 2
fi

echo "Creating customers table..."
if mysql -u "$username" -p"$password" < tables/customers/create_customers_table.sql; then
	echo "Creating customers table...[OK]"
else
	echo "Creating customers table...[FAIL]"
	echo "ERROR: $working_dir/tables/customers/create_customers_table.sql Failed. Check the logs."
	exit 3
fi

echo "Creating products table..."
if mysql -u "$username" -p"$password" < tables/products/create_products_table.sql; then
	echo "Creating products table...[OK]"
else
	echo "Creating products table...[FAIL]"
	echo "ERROR: $working_dir/tables/products/create_products_table.sql Failed. Check the logs."
	exit 4
fi

echo "Creating sales table..."
if mysql -u "$username" -p"$password" < tables/sales/create_sales_table.sql; then
	echo "Creating sales table...[OK]"
else
	echo "Creating sales table...[FAIL]"
	echo "ERROR: $working_dir/tables/sales/create_sales_table.sql Failed. Check the logs."
	exit 5
fi
