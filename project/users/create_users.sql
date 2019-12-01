drop role if exists intern@localhost;
drop role if exists junior_dba@localhost;
drop role if exists senior_dba@localhost;

create role if not exists intern@localhost;
create role if not exists junior_dba@localhost;
create role if not exists senior_dba@localhost;

drop user if exists cust_intern@localhost;
drop user if exists sale_intern@localhost;
drop user if exists prod_intern@localhost;

drop user if exists cust_junior_dba@localhost;
drop user if exists sale_junior_dba@localhost;
drop user if exists prod_junior_dba@localhost;

drop user if exists cust_senior_dba@localhost;
drop user if exists sale_senior_dba@localhost;
drop user if exists prod_senior_dba@localhost;

create user if not exists cust_intern@localhost role intern identified by '123';
create user if not exists sale_intern@localhost role intern identified by '123';
create user if not exists prod_intern@localhost role intern identified by '123';

create user if not exists cust_junior_dba@localhost role junior_dba identified by '123';
create user if not exists sale_junior_dba@localhost role junior_dba identified by '123';
create user if not exists prod_senior_dba@localhost role junior_dba identified by '123';

create user if not exists cust_senior_dba@localhost role senior_dba identified by '123';
create user if not exists cust_senior_dba@localhost role senior_dba identified by '123';
create user if not exists prod_senior_dba@localhost role senior_dba identified by '123';
