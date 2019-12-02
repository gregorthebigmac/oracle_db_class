drop role intern;
drop role junior_dba;
drop role senior_dba;

create role intern;
create role junior_dba;
create role senior_dba; 

grant select on customer_test to intern;
grant create session to intern;

grant select on customer_test to junior_dba;
grant create session to junior_dba;
grant insert on customer_test to junior_dba;
grant update on customer_test to junior_dba;

grant select on customer_test to intern;
grant create session to intern;

grant select on customer_test to senior_dba;
grant create session to senior_dba;
grant insert on customer_test to senior_dba;
grant update on customer_test to senior_dba;
grant delete on customer_test to senior_dba;

drop role intern;
drop role junior_dba;
drop role senior_dba;

grant select on customer_test to intern;
grant create session to intern;

grant select on customer_test to junior_dba;
grant create session to junior_dba;
grant insert on customer_test to junior_dba;
grant update on customer_test to junior_dba;

grant select on customer_test to intern;
grant create session to intern;

grant select on customer_test to senior_dba;
grant create session to senior_dba;
grant insert on customer_test to senior_dba;
grant update on customer_test to senior_dba;
grant delete on customer_test to senior_dba;


create user  chewbacca identified by passwordispassword;
grant intern to chewbacca;

create user  hsolo identified by passwordisurmum;
grant junior_dba to hsolo;

create user  jabba identified by hanshotfirst;
grant senior_dba to jabba;

