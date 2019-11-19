connect ap/ap;
begin
	execute immediate 'drop user john';
	execute immediate 'drop user jane';
	execute immediate 'drop user jim';
	execute immediate 'drop user joel cascade';
	execute immediate 'drop role ap_user';
	execute immediate 'drop role ap_manager';
	execute immediate 'drop role ap_developer';
	execute immediate 'drop public synonym vendors';
	execute immediate 'drop public synonym invoices';
	execute immediate 'drop public synonym invoice_line_items';
	execute immediate 'drop public synonym general_ledger_accounts';
	execute immediate 'drop public synonym terms';
	exception when others then
		dbms_output.put_line('');
end;
/

-- create the roles
create role ap_user;
create role ap_manager;
create role ap_developer;

-- grant privileges to teh ap_user role
grant create session to ap_user;
grant create public synonym to ap_user;
grant all on vendors to ap_user;
grant select, insert, update, delete on invoices to ap_user;
grant select, insert, update, delete on invoice_line_items to ap_user;
grant select on general_ledger_accounts to ap_user;
grant select on terms to ap_user;
grant select on invoice_id_seq to ap_user;
grant select on vendor_id_seq to ap_user;

-- grant privileges to the ap_manager role
grant ap_user to ap_manager with admin option;
grant all on general_ledger_accounts to ap_manager;
grant all on terms to ap_manager;

-- grant privileges to the ap_developer role
grant
	ap_manager,
	create any table,
	drop any table,
	create any view,
	drop any view,
	create any sequence,
	drop any sequence
to ap_developer;

-- create the users
create user john identified by sesame default tablespace users;
create user jane identified by sesame default tablespace users;
create user jim identified by sesame default tablespace users;
create user joel identified by sesame default tablespace users;

-- assign the users to their roles
grant ap_user to john, jane;
grant ap_manager to jim;
grant ap_developer to joel;

-- allow joel to create tables
alter user joel quota 10M on users;

-- create synonyms for all users
connect joel/sesame;
create public synonym vendors for ap.vendors;
create public synonym invoices for ap.invoices;
create public synonym invoice_line_items for ap.invoice_line_items;
create public synonym general_ledger_accounts for ap.general_ledger_accounts;
create public synonym terms for ap.terms;

-- require the users to change their passwords when they log in
connect ap/ap;
alter user john password expire;
alter user jane password expire;
alter juser jim password expire;
alter user joel password expire;

connect ap/ap;
grant create procedure to john;
grant select on vendors to john;
select * from user_sys_privs;
select * from user_tab_privs;
select * from user_role_privs;
select * from role_sys_privs;
select * from role_tab_privs;
