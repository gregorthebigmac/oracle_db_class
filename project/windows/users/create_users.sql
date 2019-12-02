drop role if exists
	intern,
	junior_dba,
	senior_dba;

create role if not exists
	intern,
	junior_dba,
	senior_dba;

grant create session on amazon_db.* to
	intern,
	junior_dba,
	senior_dba;

grant select on amazon_db.* to
	intern,
	junior_dba,
	senior_dba;

grant insert, update on amazon_db.* to
	junior_dba,
	senior_dba;

grant delete on amazon_db.* to senior_dba;

drop user if exists
	chewbacca,
	hsolo,
	jabba;

create user if not exists chewbacca identified by '123' default role intern;
create user if not exists hsolo identified by '123' default role junior_dba;
create user if not exists jabba identified by '123' default role senior_dba;
