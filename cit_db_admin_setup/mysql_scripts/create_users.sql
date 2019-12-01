tee logs/db_setup.log;	-- this is the MySQL equivalent to 'spool'

-- remove old users if they exist (does not check, just does it)
drop user c##ap cascade;
drop user c##ex cascade;
drop user c##om cascade;

-- creates users
create user c##ap identified by ap default tablespace users;
create user c##ex identified by ex default tablespace users;
create user c##om identified by om default tablespace users;

-- granting all privileges to all created users
grant all privileges to c##ap;
grant all privileges to c##ex;
grant all privileges to c##om;

notee;	-- this is the MySQL equivalent to spool off
exit;