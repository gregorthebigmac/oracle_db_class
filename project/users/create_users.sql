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

grant insert, update on amazon_db.* to
	junior_dba@localhost,
	senior_dba@localhost;

grant delete on amazon_db.* to senior_dba@localhost;

drop user if exists
	chewbacca@localhost,
	hsolo@localhost,
	jabba@localhost;





create user if not exists chewbacca@localhost identified by '123' default role intern@localhost;
create user if not exists hsolo@localhost identified by '123' default role junior_dba@localhost;
create user if not exists jabba@localhost identified by '123' default role senior_dba@localhost;

GRANT CREATE SESSION, SELECT ON CUSTOMER_TEST TO intern@localhost,

GRANT CREATE SESSION, SELECT, ADD, UPDATE ON CUSTOMER_TEST TO junior_dba@localhost,

GRANT CREATE SESSION, SELECT, ADD, UPDATE, DELETE ON CUSTOMER_TEST TO senior_dba@localhost;

CREATE SEQUENCE qty_seq
    START WITH 1   INCREMENT BY 1
    MINVALUE 0   MAXVALUE 99999
    CYCLE CACHE 10 ORDER;
    
    INSERT INTO product_test VALUES (test_seq.nextVal, 'generic_item',5, 5, 5,5,5,null,null,null,null,null,null,null,null,null,null,null, null);
    