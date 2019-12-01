# Command List

## Show all users

    mysql> select user, host from mysql.user;

This will output something like:

    +------------------+-----------+
    | User             | Host      |
    +------------------+-----------+
    | debian-sys-maint | localhost |
    | mysql.session    | localhost |
    | mysql.sys        | localhost |
    | root             | localhost |
    +------------------+-----------+
    4 rows in set (0.00 sec)

## Create new user (database agnostic)

    mysql> create user '[username]'@'localhost' identified by '[password]';
    mysql> create user 'test_user'@'localhost' identified by 'test123test!';

This will only work if the user doesn't already exist. If the user already exists, it will drop out with an error (which will break your script if you're trying to scriptify this).

## Drop a user (database agnostic)

    mysql> drop user username@localhost;

This will only work if the user already exists. If the user doesn't exist, it will drop out with an error (which will throw a wrench in your spokes if you're trying to scriptify this). To check if the user exists, and drop it if it does exist, use the following:

    mysql> drop user if exists username@localhost;

## Create a database

    mysql> create database db_name;

Like with the other examples, this only works if the database doesn't already exist.
