drop role if exists
	intern@localhost,
	junior_dba@localhost,
	senior_dba@localhost;

create role if not exists
	intern@localhost,
	junior_dba@localhost,
	senior_dba@localhost;

grant select on amazon_db.* to
	intern@localhost,
	junior_dba@localhost,
	senior_dba@localhost;

grant insert on amazon_db.* to
	junior_dba@localhost,
	senior_dba@localhost;

grant delete on amazon_db.* to senior_dba@localhost;

drop user if exists
	lskywalker@localhost,
	hsolo@localhost,
	aackbar@localhost;

create user if not exists lskywalker@localhost identified by '123' default role intern@localhost;
create user if not exists hsolo@localhost identified by '123' default role junior_dba@localhost;
create user if not exists aackbar@localhost identified by '123' default role senior_dba@localhost;
