prompt>Dropping users
DROP USER ap_admin CASCADE;
DROP USER ex_admin CASCADE;
DROP USER om_admin CASCADE;

prompt>Creating users
CREATE USER ap_admin IDENTIFIED BY ap DEFAULT TABLESPACE users;
CREATE USER ex_admin IDENTIFIED BY ex DEFAULT TABLESPACE users;
CREATE USER om_admin IDENTIFIED BY om DEFAULT TABLESPACE users;

prompt>Granting privileges
GRANT ALL PRIVILEGES TO ap_admin;
GRANT ALL PRIVILEGES TO ex_admin;
GRANT ALL PRIVILEGES TO om_admin;
