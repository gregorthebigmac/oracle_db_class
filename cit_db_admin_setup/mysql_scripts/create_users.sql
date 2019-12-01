tee logs/db_setup.log;	-- this is the MySQL equivalent to 'spool'

-- remove old users if they exist (does not check, just does it)
drop user if exists ap@localhost;
drop user if exists ex@localhost;
drop user if exists om@localhost;

-- creates tablespace 'users'
-- create tablespace users;

-- creates users
create user ap@localhost identified by 'ap';
create user ex@localhost identified by 'ex';
create user om@localhost identified by 'om';

-- granting all privileges to all created users
grant all privileges to 'ap';
grant all privileges to 'ex';
grant all privileges to 'om';

notee;	-- this is the MySQL equivalent to spool off
exit;
