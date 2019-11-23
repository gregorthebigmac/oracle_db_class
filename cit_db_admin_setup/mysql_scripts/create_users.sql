tee log;
drop user c##ap cascade;
drop user c##ex cascade;
drop user c##om cascade;

create user c##ap identified by ap default tablespace users;
create user c##ex identified by ex default tablespace users;
create user c##om identified by om default tablespace users;

grant all privileges to c##ap;
grant all privileges to c##ex;
grant all privileges to c##om;
notee;