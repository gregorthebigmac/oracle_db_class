tee logs/;
connect c##ap/ap;

-- Use an anonymous PL/SQL script to drop all tables and sequences in the
-- schema and suppress any error messages that may be displayed if these objects
-- don't exist.
begin
	execute immediate 'drop sequence vendor_id_seq';
	execute immediate 'drop sequence invoice_id_seq';
	execute immediate 'drop table invoice_archive';
	execute immediate 'drop table invoice_line_items';
	execute immediate 'drop table invoices';
	execute immediate 'drop table vendor_contacts';
	execute immediate 'drop table vendors';
	execute immediate 'drop table terms';
	execute immediate 'drop table general_ledger_accounts';
exception when others then
	dbms_output.put_line('');
end;
/

create table general_ledger_accounts (
	account_number 				number 			not null,
	account_description 		varchar2(50) 	not null,
	constraint gl_accounts_pk primary key (account_number),
	unique (account_description)
);

create table terms (
	terms_id			number 			not null,
	terms_description	varchar2(50)	not null,
	terms_due_days		number 			not null,
	constraint terms_pk (terms_id)
);

create table vendors (
	vendor_id 					number 			not null,
	vendor_name					varchar2(50)	not null,
	vendor_address1				varchar2(50),
	vendor_address2				varchar2(50),
	vendor_city					varchar2(50)	not null,
	vendor_state				char(2)			not null,
	vendor_zip_code				varchar2(20)	not null,
	vendor_phone				varchar2(50),
	vendor_contact_last_name	varchar2(50),
	vendor_contact_first_name	varchar2(50),
	default_terms_id			number			not null,
	constraint vendors_pk
		primary key (vendor_id),
	constraint vendors_vendor_name_uq
		unique (vendor_name),
	constraint vendors_fk_terms
		foreign key (default_terms_id) references terms (terms_id),
	constraint vendors_fk_accounts
		foreign key (default_account_number) references general_ledger_accounts (account_number)
);

create table invoices (
	invoice_id			number,
	vendor_id			number			not null,
	invoice_number		varchar2(50)	not null,
	invoice_date		date			not null,
	invoice_total		number(9,2)		not null,
	payment_total		number(9,2)		default 0,
	credit_total		number(9,2)		default 0,
	terms_id			number			not null,
	invoice_due_date	date		not null,
	payment_date		date,
	constraint invoices_pk
		primary key (invoice_id),
	constraint invoices_fk_vendors
		foreign key (vendor_id) references vendors (vendor_id),
	constraint invoices_fk_terms
		foreign key (terms_id) references terms (terms_id)
);

create table invoice_line_items (
	invoice_id				number			not null,
	invoice_sequence		number			not null,
	account_number			number			not null,
	line_item_amt			number(9,2)		not null,
	line_item_description	varchar2(100)	not null,
	constraint line_items_pk
		primary key (invoice_id, invoice_sequence),
	constraint line_items_fk_invoices
		foreign key (invoice_id) references invoices (invoice_id),
	constraint line_items_fk_accounts
		foreign key (account_number) references general_ledger_accounts (account_number)
);

-- create the indexes
create index vendors_terms_id_ix
	on vendors (default_terms_id);
create index vendors_account_number_ix
	on vendors (default_account_number);

create index invoices_invoice_date_ix
	on invoices (invoice_date desc);
create index invoices_vendor_id_ix
	on invoices (vendor_id);
create index invoices_terms_id_ix
	on invoices (terms_id);
create index line_items_account_number_ix
	on invoice_line_items (account_number);

-- create the sequences
create sequence vendor_id_seq
	start with 124;
create sequence invoice_id_seq
	start with 115;

-- create the test tables that aren't explicitly
-- related to teh previous five tables
create table vendor_contracts (
	vendor_id	number			not null,
	last_name	varchar2(50)	not null,
	first_name	varchar2(50)	not null
);

create table invoice_archive (
	invoice_id			number 			not null,
	vendor_id			number 			not null,
	invoice_number		varchar2(50)	not null,
	invoice_date		date			not null,
	invoice_total		number			not null,
	payment_total		number			not null,
	credit_total		number			not null,
	terms_id			number			not null,
	invoice_due_date	date			not null,
	payment_date		date
);

-- disable substitution variable prompting
set define off;

-- insert into general_ledger_accounts
insert into general_ledger_accounts (account_number,account_description) values (100,'Cash');
insert into general_ledger_accounts (account_number,account_description) values (110,'Accounts Receivable');
insert into general_ledger_accounts (account_number,account_description) values (120,'Book Inventory');
insert into general_ledger_accounts (account_number,account_description) values (150,'Furniture');
insert into general_ledger_accounts (account_number,account_description) values (160,'Computer Equipment');
insert into general_ledger_accounts (account_number,account_description) values (162,'Capitalized Lease');
insert into general_ledger_accounts (account_number,account_description) values (167,'Software');
insert into general_ledger_accounts (account_number,account_description) values (170,'Other Equipment');
insert into general_ledger_accounts (account_number,account_description) values (181,'Book Development');
insert into general_ledger_accounts (account_number,account_description) values (200,'Accounts Payable');
insert into general_ledger_accounts (account_number,account_description) values (205,'Royalties Payable');
insert into general_ledger_accounts (account_number,account_description) values (221,'401K Employee Contributions');
insert into general_ledger_accounts (account_number,account_description) values (230,'Sales Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (234,'Medicare Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (235,'Income Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (237,'State Payroll Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (238,'Employee FICA Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (239,'Employer FICA Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (241,'Employer FUTA Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (242,'Employee SDI Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (243,'Employer UCI Taxes Payable');
insert into general_ledger_accounts (account_number,account_description) values (251,'IBM Credit Corporation Payable');
insert into general_ledger_accounts (account_number,account_description) values (280,'Capital Stock');
insert into general_ledger_accounts (account_number,account_description) values (290,'Retained Earnings');
insert into general_ledger_accounts (account_number,account_description) values (300,'Retail Sales');
insert into general_ledger_accounts (account_number,account_description) values (301,'College Sales');
insert into general_ledger_accounts (account_number,account_description) values (302,'Trade Sales');
insert into general_ledger_accounts (account_number,account_description) values (306,'Consignment Sales');
insert into general_ledger_accounts (account_number,account_description) values (310,'Compositing Revenue');
insert into general_ledger_accounts (account_number,account_description) values (394,'Book Club Royalties');
insert into general_ledger_accounts (account_number,account_description) values (400,'Book Printing Costs');
insert into general_ledger_accounts (account_number,account_description) values (403,'Book Production Costs');
insert into general_ledger_accounts (account_number,account_description) values (500,'Salaries and Wages');
insert into general_ledger_accounts (account_number,account_description) values (505,'FICA');
insert into general_ledger_accounts (account_number,account_description) values (506,'FUTA');
insert into general_ledger_accounts (account_number,account_description) values (507,'UCI');
insert into general_ledger_accounts (account_number,account_description) values (508,'Medicare');
insert into general_ledger_accounts (account_number,account_description) values (510,'Group Insurance');
insert into general_ledger_accounts (account_number,account_description) values (520,'Building Lease');
insert into general_ledger_accounts (account_number,account_description) values (521,'Utilities');
insert into general_ledger_accounts (account_number,account_description) values (522,'Telephone');
insert into general_ledger_accounts (account_number,account_description) values (523,'Building Maintenance');
insert into general_ledger_accounts (account_number,account_description) values (527,'Computer Equipment Maintenance');
insert into general_ledger_accounts (account_number,account_description) values (528,'IBM Lease');
insert into general_ledger_accounts (account_number,account_description) values (532,'Equipment Rental');
insert into general_ledger_accounts (account_number,account_description) values (536,'Card Deck Advertising');
insert into general_ledger_accounts (account_number,account_description) values (540,'Direct Mail Advertising');
insert into general_ledger_accounts (account_number,account_description) values (541,'Space Advertising');
insert into general_ledger_accounts (account_number,account_description) values (546,'Exhibits and Shows');
insert into general_ledger_accounts (account_number,account_description) values (548,'Web Site Production and Fees');
insert into general_ledger_accounts (account_number,account_description) values (550,'Packaging Materials');
insert into general_ledger_accounts (account_number,account_description) values (551,'Business Forms');
insert into general_ledger_accounts (account_number,account_description) values (552,'Postage');
insert into general_ledger_accounts (account_number,account_description) values (553,'Freight');
insert into general_ledger_accounts (account_number,account_description) values (555,'Collection Agency Fees');
insert into general_ledger_accounts (account_number,account_description) values (556,'Credit Card Handling');
insert into general_ledger_accounts (account_number,account_description) values (565,'Bank Fees');
insert into general_ledger_accounts (account_number,account_description) values (568,'Auto License Fee');
insert into general_ledger_accounts (account_number,account_description) values (569,'Auto Expense');
insert into general_ledger_accounts (account_number,account_description) values (570,'Office Supplies');
insert into general_ledger_accounts (account_number,account_description) values (572,'Books, Dues, and Subscriptions');
insert into general_ledger_accounts (account_number,account_description) values (574,'Business Licenses and Taxes');
insert into general_ledger_accounts (account_number,account_description) values (576,'PC Software');
insert into general_ledger_accounts (account_number,account_description) values (580,'Meals');
insert into general_ledger_accounts (account_number,account_description) values (582,'Travel and Accomodations');
insert into general_ledger_accounts (account_number,account_description) values (589,'Outside Services');
insert into general_ledger_accounts (account_number,account_description) values (590,'Business Insurance');
insert into general_ledger_accounts (account_number,account_description) values (591,'Accounting');
insert into general_ledger_accounts (account_number,account_description) values (610,'Charitable Contributions');
insert into general_ledger_accounts (account_number,account_description) values (611,'Profit Sharing Contributions');
insert into general_ledger_accounts (account_number,account_description) values (620,'Interest Paid to Banks');
insert into general_ledger_accounts (account_number,account_description) values (621,'Other Interest');
insert into general_ledger_accounts (account_number,account_description) values (630,'Federal Corporation Income Taxes');
insert into general_ledger_accounts (account_number,account_description) values (631,'State Corporation Income Taxes');
insert into general_ledger_accounts (account_number,account_description) values (632,'Sales Tax');

-- insert into terms
insert into terms (terms_id,terms_description,terms_due_days) values (1,'Net due 10 days',10);
insert into terms (terms_id,terms_description,terms_due_days) values (2,'Net due 20 days',20);
insert into terms (terms_id,terms_description,terms_due_days) values (3,'Net due 30 days',30);
insert into terms (terms_id,terms_description,terms_due_days) values (4,'Net due 60 days',60);
insert into terms (terms_id,terms_description,terms_due_days) values (5,'Net due 90 days',90);

-- insert into vendors
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (1,'US Postal Service','Attn:  Supt. Window Services','PO Box 7005','Madison','WI','53707','(800) 555-1205','Alberto','Francesco',1,552);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (2,'National Information Data Ctr','PO Box 96621','NULL','Washington','DC','20090','(301) 555-8950','Irvin','Ania',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (3,'Register of Copyrights','Library Of Congress','NULL','Washington','DC','20559','NULL','Liana','Lukas',3,403);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (4,'Jobtrak','1990 Westwood Blvd Ste 260','NULL','Los Angeles','CA','90025','(800) 555-8725','Quinn','Kenzie',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (5,'Newbrige Book Clubs','3000 Cindel Drive','NULL','Washington','NJ','07882','(800) 555-9980','Marks','Michelle',4,394);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (6,'California Chamber Of Commerce','3255 Ramos Cir','NULL','Sacramento','CA','95827','(916) 555-6670','Mauro','Anton',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (7,'Towne Advertiser''s Mailing Svcs','Kevin Minder','3441 W Macarthur Blvd','Santa Ana','CA','92704','NULL','Maegen','Ted',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (8,'BFI Industries','PO Box 9369','NULL','Fresno','CA','93792','(559) 555-1551','Kaleigh','Erick',3,521);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (9,'Pacific Gas & Electric','Box 52001','NULL','San Francisco','CA','94152','(800) 555-6081','Anthoni','Kaitlyn',3,521);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (10,'Robbins Mobile Lock And Key','4669 N Fresno','NULL','Fresno','CA','93726','(559) 555-9375','Leigh','Bill',2,523);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (11,'Bill Marvin Electric Inc','4583 E Home','NULL','Fresno','CA','93703','(559) 555-5106','Hostlery','Kaitlin',2,523);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (12,'City Of Fresno','PO Box 2069','NULL','Fresno','CA','93718','(559) 555-9999','Mayte','Kendall',3,574);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (13,'Golden Eagle Insurance Co','PO Box 85826','NULL','San Diego','CA','92186','NULL','Blanca','Korah',3,590);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (14,'Expedata Inc','4420 N. First Street, Suite 108','NULL','Fresno','CA','93726','(559) 555-9586','Quintin','Marvin',3,589);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (15,'ASC Signs','1528 N Sierra Vista','NULL','Fresno','CA','93703','NULL','Darien','Elisabeth',1,546);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (16,'Internal Revenue Service','NULL','NULL','Fresno','CA','93888','NULL','Aileen','Joan',1,235);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (17,'Blanchard & Johnson Associates','27371 Valderas','NULL','Mission Viejo','CA','92691','(214) 555-3647','Keeton','Gonzalo',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (18,'Fresno Photoengraving Company','1952 "H" Street','P.O. Box 1952','Fresno','CA','93718','(559) 555-3005','Chaddick','Derek',3,403);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (19,'Crown Printing','1730 "H" St','NULL','Fresno','CA','93721','(559) 555-7473','Randrup','Leann',2,400);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (20,'Diversified Printing & Pub','2632 Saturn St','NULL','Brea','CA','92621','(714) 555-4541','Lane','Vanesa',3,400);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (21,'The Library Ltd','7700 Forsyth','NULL','St Louis','MO','63105','(314) 555-8834','Marques','Malia',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (22,'Micro Center','1555 W Lane Ave','NULL','Columbus','OH','43221','(614) 555-4435','Evan','Emily',2,160);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (23,'Yale Industrial Trucks-Fresno','3711 W Franklin','NULL','Fresno','CA','93706','(559) 555-2993','Alexis','Alexandro',3,532);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (24,'Zee Medical Service Co','4221 W Sierra Madre #104','NULL','Washington','IA','52353','NULL','Hallie','Juliana',3,570);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (25,'California Data Marketing','2818 E Hamilton','NULL','Fresno','CA','93721','(559) 555-3801','Jonessen','Moises',4,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (26,'Small Press','121 E Front St - 4th Floor','NULL','Traverse City','MI','49684','NULL','Colette','Dusty',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (27,'Rich Advertising','12 Daniel Road','NULL','Fairfield','NJ','07004','(201) 555-9742','Neil','Ingrid',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (29,'Vision Envelope & Printing','PO Box 3100','NULL','Gardena','CA','90247','(310) 555-7062','Raven','Jamari',3,551);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (30,'Costco','Fresno Warehouse','4500 W Shaw','Fresno','CA','93711','NULL','Jaquan','Aaron',3,570);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (31,'Enterprise Communications Inc','1483 Chain Bridge Rd, Ste 202','NULL','Mclean','VA','22101','(770) 555-9558','Lawrence','Eileen',2,536);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (32,'RR Bowker','PO Box 31','NULL','East Brunswick','NJ','08810','(800) 555-8110','Essence','Marjorie',3,532);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (33,'Nielson','Ohio Valley Litho Division','Location #0470','Cincinnati','OH','45264','NULL','Brooklynn','Keely',2,541);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (34,'IBM','PO Box 61000','NULL','San Francisco','CA','94161','(800) 555-4426','Camron','Trentin',1,160);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (35,'Cal State Termite','PO Box 956','NULL','Selma','CA','93662','(559) 555-1534','Hunter','Demetrius',2,523);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (36,'Graylift','PO Box 2808','NULL','Fresno','CA','93745','(559) 555-6621','Sydney','Deangelo',3,532);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (37,'Blue Cross','PO Box 9061','NULL','Oxnard','CA','93031','(800) 555-0912','Eliana','Nikolas',3,510);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (38,'Venture Communications Int''l','60 Madison Ave','NULL','New York','NY','10010','(212) 555-4800','Neftaly','Thalia',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (39,'Custom Printing Company','PO Box 7028','NULL','St Louis','MO','63177','(301) 555-1494','Myles','Harley',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (40,'Nat Assoc of College Stores','500 East Lorain Street','NULL','Oberlin','OH','44074','NULL','Bernard','Lucy',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (41,'Shields Design','415 E Olive Ave','NULL','Fresno','CA','93728','(559) 555-8060','Kerry','Rowan',2,403);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (42,'Opamp Technical Books','1033 N Sycamore Ave.','NULL','Los Angeles','CA','90038','(213) 555-4322','Paris','Gideon',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (43,'Capital Resource Credit','PO Box 39046','NULL','Minneapolis','MN','55439','(612) 555-0057','Maxwell','Jayda',3,589);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (44,'Courier Companies, Inc','PO Box 5317','NULL','Boston','MA','02206','(508) 555-6351','Antavius','Troy',4,400);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (45,'Naylor Publications Inc','PO Box 40513','NULL','Jacksonville','FL','32231','(800) 555-6041','Gerald','Kristofer',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (46,'Open Horizons Publishing','Book Marketing Update','PO Box 205','Fairfield','IA','52556','(515) 555-6130','Damien','Deborah',2,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (47,'Baker & Taylor Books','Five Lakepointe Plaza, Ste 500','2709 Water Ridge Parkway','Charlotte','NC','28217','(704) 555-3500','Bernardo','Brittnee',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (48,'Fresno County Tax Collector','PO Box 1192','NULL','Fresno','CA','93715','(559) 555-3482','Brenton','Kila',3,574);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (49,'Mcgraw Hill Companies','PO Box 87373','NULL','Chicago','IL','60680','(614) 555-3663','Holbrooke','Rashad',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (50,'Publishers Weekly','Box 1979','NULL','Marion','OH','43305','(800) 555-1669','Carrollton','Priscilla',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (51,'Blue Shield of California','PO Box 7021','NULL','Anaheim','CA','92850','(415) 555-5103','Smith','Kylie',3,510);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (52,'Aztek Label','Accounts Payable','1150 N Tustin Ave','Anaheim','CA','92807','(714) 555-9000','Griffin','Brian',3,551);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (53,'Gary McKeighan Insurance','3649 W Beechwood Ave #101','NULL','Fresno','CA','93711','(559) 555-2420','Jair','Caitlin',3,590);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (54,'Ph Photographic Services','2384 E Gettysburg','NULL','Fresno','CA','93726','(559) 555-0765','Cheyenne','Kaylea',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (55,'Quality Education Data','PO Box 95857','NULL','Chicago','IL','60694','(800) 555-5811','Misael','Kayle',2,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (56,'Springhouse Corp','PO Box 7247-7051','NULL','Philadelphia','PA','19170','(215) 555-8700','Maeve','Clarence',3,523);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (57,'The Windows Deck','117 W Micheltorena Top Floor','NULL','Santa Barbara','CA','93101','(800) 555-3353','Wood','Liam',3,536);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (58,'Fresno Rack & Shelving Inc','4718 N Bendel Ave','NULL','Fresno','CA','93722','NULL','Baylee','Dakota',2,523);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (59,'Publishers Marketing Assoc','627 Aviation Way','NULL','Manhatttan Beach','CA','90266','(310) 555-2732','Walker','Jovon',3,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (60,'The Mailers Guide Co','PO Box 1550','NULL','New Rochelle','NY','10802','NULL','Lacy','Karina',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (61,'American Booksellers Assoc','828 S Broadway','NULL','Tarrytown','NY','10591','(800) 555-0037','Angelica','Nashalie',3,574);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (62,'Cmg Information Services','PO Box 2283','NULL','Boston','MA','02107','(508) 555-7000','Randall','Yash',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (63,'Lou Gentile''s Flower Basket','722 E Olive Ave','NULL','Fresno','CA','93728','(559) 555-6643','Anum','Trisha',1,570);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (64,'Texaco','PO Box 6070','NULL','Inglewood','CA','90312','NULL','Oren','Grace',3,582);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (65,'The Drawing Board','PO Box 4758','NULL','Carol Stream','IL','60197','NULL','Mckayla','Jeffery',2,551);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (66,'Ascom Hasler Mailing Systems','PO Box 895','NULL','Shelton','CT','06484','NULL','Lewis','Darnell',3,532);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (67,'Bill Jones','Secretary Of State','PO Box 944230','Sacramento','CA','94244','NULL','Deasia','Tristin',3,589);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (68,'Computer Library','3502 W Greenway #7','NULL','Phoenix','AZ','85023','(602) 547-0331','Aryn','Leroy',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (69,'Frank E Wilber Co','2437 N Sunnyside','NULL','Fresno','CA','93727','(559) 555-1881','Millerton','Johnathon',3,532);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (70,'Fresno Credit Bureau','PO Box 942','NULL','Fresno','CA','93714','(559) 555-7900','Braydon','Anne',2,555);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (71,'The Fresno Bee','1626 E Street','NULL','Fresno','CA','93786','(559) 555-4442','Colton','Leah',2,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (72,'Data Reproductions Corp','4545 Glenmeade Lane','NULL','Auburn Hills','MI','48326','(810) 555-3700','Arodondo','Cesar',3,400);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (73,'Executive Office Products','353 E Shaw Ave','NULL','Fresno','CA','93710','(559) 555-1704','Danielson','Rachael',2,570);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (74,'Leslie Company','PO Box 610','NULL','Olathe','KS','66061','(800) 255-6210','Alondra','Zev',3,570);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (75,'Retirement Plan Consultants','6435 North Palm Ave, Ste 101','NULL','Fresno','CA','93704','(559) 555-7070','Edgardo','Salina',3,589);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (76,'Simon Direct Inc','4 Cornwall Dr Ste 102','NULL','East Brunswick','NJ','08816','(908) 555-7222','Bradlee','Daniel',2,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (77,'State Board Of Equalization','PO Box 942808','NULL','Sacramento','CA','94208','(916) 555-4911','Dean','Julissa',1,631);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (78,'The Presort Center','1627 "E" Street','NULL','Fresno','CA','93706','(559) 555-6151','Marissa','Kyle',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (79,'Valprint','PO Box 12332','NULL','Fresno','CA','93777','(559) 555-3112','Warren','Quentin',3,551);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (80,'Cardinal Business Media, Inc.','P O Box 7247-7844','NULL','Philadelphia','PA','19170','(215) 555-1500','Eulalia','Kelsey',2,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (81,'Wang Laboratories, Inc.','P.O. Box 21209','NULL','Pasadena','CA','91185','(800) 555-0344','Kapil','Robert',2,160);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (82,'Reiter''s Scientific & Pro Books','2021 K Street Nw','NULL','Washington','DC','20006','(202) 555-5561','Rodolfo','Carlee',2,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (83,'Ingram','PO Box 845361','NULL','Dallas','TX','75284','NULL','Yobani','Trey',2,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (84,'Boucher Communications Inc','1300 Virginia Dr. Ste 400','NULL','Fort Washington','PA','19034','(215) 555-8000','Carson','Julian',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (85,'Champion Printing Company','3250 Spring Grove Ave','NULL','Cincinnati','OH','45225','(800) 555-1957','Clifford','Jillian',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (86,'Computerworld','Department #1872','PO Box 61000','San Francisco','CA','94161','(617) 555-0700','Lloyd','Angel',1,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (87,'DMV Renewal','PO Box 942894','NULL','Sacramento','CA','94294','NULL','Josey','Lorena',4,568);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (88,'Edward Data Services','4775 E Miami River Rd','NULL','Cleves','OH','45002','(513) 555-3043','Helena','Jeanette',1,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (89,'Evans Executone Inc','4918 Taylor Ct','NULL','Turlock','CA','95380','NULL','Royce','Hannah',1,522);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (90,'Wakefield Co','295 W Cromwell Ave Ste 106','NULL','Fresno','CA','93711','(559) 555-4744','Rothman','Nathanael',2,170);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (91,'McKesson Water Products','P O Box 7126','NULL','Pasadena','CA','91109','(800) 555-7009','Destin','Luciano',2,570);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (92,'Zip Print & Copy Center','PO Box 12332','NULL','Fresno','CA','93777','(233) 555-6400','Javen','Justin',2,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (93,'AT&T','PO Box 78225','NULL','Phoenix','AZ','85062','NULL','Wesley','Alisha',3,522);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (94,'Abbey Office Furnishings','4150 W Shaw Ave','NULL','Fresno','CA','93722','(559) 555-8300','Francis','Kyra',2,150);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (95,'Pacific Bell','NULL','NULL','Sacramento','CA','95887','(209) 555-7500','Nickalus','Kurt',2,522);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (96,'Wells Fargo Bank','Business Mastercard','P.O. Box 29479','Phoenix','AZ','85038','(947) 555-3900','Damion','Mikayla',2,160);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (97,'Compuserve','Dept L-742','NULL','Columbus','OH','43260','(614) 555-8600','Armando','Jan',2,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (98,'American Express','Box 0001','NULL','Los Angeles','CA','90096','(800) 555-3344','Story','Kirsten',2,160);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (99,'Bertelsmann Industry Svcs. Inc','28210 N Avenue Stanford','NULL','Valencia','CA','91355','(805) 555-0584','Potter','Lance',3,400);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (100,'Cahners Publishing Company','Citibank Lock Box 4026','8725 W Sahara Zone 1127','The Lake','NV','89163','(301) 555-2162','Jacobsen','Samuel',4,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (101,'California Business Machines','Gallery Plz','5091 N Fresno','Fresno','CA','93710','(559) 555-5570','Rohansen','Anders',2,170);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (102,'Coffee Break Service','PO Box 1091','NULL','Fresno','CA','93714','(559) 555-8700','Smitzen','Jeffrey',4,570);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (103,'Dean Witter Reynolds','9 River Pk Pl E 400','NULL','Boston','MA','02134','(508) 555-8737','Johnson','Vance',5,589);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (104,'Digital Dreamworks','5070 N Sixth Ste. 71','NULL','Fresno','CA','93711','NULL','Elmert','Ron',3,589);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (105,'Dristas Groom & McCormick','7112 N Fresno St Ste 200','NULL','Fresno','CA','93720','(559) 555-8484','Aaronsen','Thom',3,591);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (106,'Ford Motor Credit Company','Dept 0419','NULL','Los Angeles','CA','90084','(800) 555-7000','Snyder','Karen',3,582);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (107,'Franchise Tax Board','PO Box 942857','NULL','Sacramento','CA','94257','NULL','Prado','Anita',4,507);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (108,'Gostanian General Building','427 W Bedford #102','NULL','Fresno','CA','93711','(559) 555-5100','Bragg','Walter',4,523);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (109,'Kent H Landsberg Co','File No 72686','PO Box 61000','San Francisco','CA','94160','(916) 555-8100','Stevens','Wendy',3,540);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (110,'Malloy Lithographing Inc','5411 Jackson Road','PO Box 1124','Ann Arbor','MI','48106','(313) 555-6113','Regging','Abe',3,400);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (111,'Net Asset, Llc','1315 Van Ness Ave Ste. 103','NULL','Fresno','CA','93721','NULL','Kraggin','Laura',1,572);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (112,'Office Depot','File No 81901','NULL','Los Angeles','CA','90074','(800) 555-1711','Pinsippi','Val',3,570);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (113,'Pollstar','4697 W Jacquelyn Ave','NULL','Fresno','CA','93722','(559) 555-2631','Aranovitch','Robert',5,520);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (114,'Postmaster','Postage Due Technician','1900 E Street','Fresno','CA','93706','(559) 555-7785','Finklestein','Fyodor',1,552);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (115,'Roadway Package System, Inc','Dept La 21095','NULL','Pasadena','CA','91185','NULL','Smith','Sam',4,553);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (116,'State of California','Employment Development Dept','PO Box 826276','Sacramento','CA','94230','(209) 555-5132','Articunia','Mercedez',1,631);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (117,'Suburban Propane','2874 S Cherry Ave','NULL','Fresno','CA','93706','(559) 555-2770','Spivak','Harold',3,521);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (118,'Unocal','P.O. Box 860070','NULL','Pasadena','CA','91186','(415) 555-7600','Bluzinski','Rachael',3,582);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (119,'Yesmed, Inc','PO Box 2061','NULL','Fresno','CA','93718','(559) 555-0600','Hernandez','Reba',2,589);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (120,'Dataforms/West','1617 W. Shaw Avenue','Suite F','Fresno','CA','93711','NULL','Church','Charlie',3,551);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (121,'Zylka Design','3467 W Shaw Ave #103','NULL','Fresno','CA','93711','(559) 555-8625','Ronaldsen','Jaime',3,403);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (122,'United Parcel Service','P.O. Box 505820','NULL','Reno','NV','88905','(800) 555-0855','Beauregard','Violet',3,553);
insert into vendors (vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
values (123,'Federal Express Corporation','P.O. Box 1140','Dept A','Memphis','TN','38101','(800) 555-4091','Bucket','Charlie',3,553);

-- insert into vendor_contacts 
insert into vendor_contacts (vendor_id,last_name,first_name)
values (5,'Davison','Michelle');
insert into vendor_contacts (vendor_id,last_name,first_name)
values (12,'Mayteh','Kendall');
insert into vendor_contacts (vendor_id,last_name,first_name)
values (17,'Onandonga','Bruce');
insert into vendor_contacts (vendor_id,last_name,first_name)
values (44,'Antavius','Anthony');
insert into vendor_contacts (vendor_id,last_name,first_name)
values (76,'Bradlee','Danny');
insert into vendor_contacts (vendor_id,last_name,first_name)
values (94,'Suscipe','Reynaldo');
insert into vendor_contacts (vendor_id,last_name,first_name)
values (101,'O''Sullivan','Geraldine');
insert into vendor_contacts (vendor_id,last_name,first_name)
values (123,'Bucket','Charles');

-- insert into invoices 
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (1,34,'QP58872',to_date('25-FEB-14','DD-MON-RR'),116.54,116.54,0,4,to_date('22-APR-14','DD-MON-RR'),to_date('11-APR-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (2,34,'Q545443',to_date('14-MAR-14','DD-MON-RR'),1083.58,1083.58,0,4,to_date('23-MAY-14','DD-MON-RR'),to_date('14-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (3,110,'P-0608',to_date('11-APR-14','DD-MON-RR'),20551.18,0,1200,5,to_date('30-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (4,110,'P-0259',to_date('16-APR-14','DD-MON-RR'),26881.4,26881.4,0,3,to_date('16-MAY-14','DD-MON-RR'),to_date('12-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (5,81,'MABO1489',to_date('16-APR-14','DD-MON-RR'),936.93,936.93,0,3,to_date('16-MAY-14','DD-MON-RR'),to_date('13-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (6,122,'989319-497',to_date('17-APR-14','DD-MON-RR'),2312.2,0,0,4,to_date('26-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (7,82,'C73-24',to_date('17-APR-14','DD-MON-RR'),600,600,0,2,to_date('10-MAY-14','DD-MON-RR'),to_date('05-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (8,122,'989319-487',to_date('18-APR-14','DD-MON-RR'),1927.54,0,0,4,to_date('19-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (9,122,'989319-477',to_date('19-APR-14','DD-MON-RR'),2184.11,2184.11,0,4,to_date('12-JUN-14','DD-MON-RR'),to_date('07-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (10,122,'989319-467',to_date('24-APR-14','DD-MON-RR'),2318.03,2318.03,0,4,to_date('05-JUN-14','DD-MON-RR'),to_date('29-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (11,122,'989319-457',to_date('24-APR-14','DD-MON-RR'),3813.33,3813.33,0,3,to_date('29-MAY-14','DD-MON-RR'),to_date('20-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (12,122,'989319-447',to_date('24-APR-14','DD-MON-RR'),3689.99,3689.99,0,3,to_date('22-MAY-14','DD-MON-RR'),to_date('12-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (13,122,'989319-437',to_date('24-APR-14','DD-MON-RR'),2765.36,2765.36,0,2,to_date('15-MAY-14','DD-MON-RR'),to_date('03-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (14,122,'989319-427',to_date('25-APR-14','DD-MON-RR'),2115.81,2115.81,0,1,to_date('08-MAY-14','DD-MON-RR'),to_date('01-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (15,121,'97/553B',to_date('26-APR-14','DD-MON-RR'),313.55,0,0,4,to_date('09-JUL-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (16,122,'989319-417',to_date('26-APR-14','DD-MON-RR'),2051.59,2051.59,0,1,to_date('01-MAY-14','DD-MON-RR'),to_date('28-APR-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (17,90,'97-1024A',to_date('26-APR-14','DD-MON-RR'),356.48,356.48,0,3,to_date('09-JUN-14','DD-MON-RR'),to_date('09-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (18,121,'97/553',to_date('27-APR-14','DD-MON-RR'),904.14,0,0,4,to_date('09-JUL-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (19,121,'97/522',to_date('30-APR-14','DD-MON-RR'),1962.13,0,200,4,to_date('10-JUL-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (20,121,'97/503',to_date('30-APR-14','DD-MON-RR'),639.77,639.77,0,4,to_date('11-JUN-14','DD-MON-RR'),to_date('05-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (21,121,'97/488',to_date('30-APR-14','DD-MON-RR'),601.95,601.95,0,3,to_date('03-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (22,121,'97/486',to_date('30-APR-14','DD-MON-RR'),953.1,953.1,0,2,to_date('21-MAY-14','DD-MON-RR'),to_date('13-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (23,121,'97/465',to_date('01-MAY-14','DD-MON-RR'),565.15,565.15,0,1,to_date('14-MAY-14','DD-MON-RR'),to_date('05-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (24,121,'97/222',to_date('01-MAY-14','DD-MON-RR'),1000.46,1000.46,0,3,to_date('03-JUN-14','DD-MON-RR'),to_date('25-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (25,123,'4-342-8069',to_date('01-MAY-14','DD-MON-RR'),10,10,0,4,to_date('10-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (26,123,'4-327-7357',to_date('01-MAY-14','DD-MON-RR'),162.75,162.75,0,3,to_date('27-MAY-14','DD-MON-RR'),to_date('21-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (27,123,'4-321-2596',to_date('01-MAY-14','DD-MON-RR'),10,10,0,2,to_date('20-MAY-14','DD-MON-RR'),to_date('11-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (28,123,'7548906-20',to_date('01-MAY-14','DD-MON-RR'),27,27,0,3,to_date('06-JUN-14','DD-MON-RR'),to_date('26-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (29,123,'4-314-3057',to_date('02-MAY-14','DD-MON-RR'),13.75,13.75,0,1,to_date('13-MAY-14','DD-MON-RR'),to_date('07-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (30,94,'203339-13',to_date('02-MAY-14','DD-MON-RR'),17.5,0,0,3,to_date('13-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (31,123,'2-000-2993',to_date('03-MAY-14','DD-MON-RR'),144.7,144.7,0,1,to_date('06-MAY-14','DD-MON-RR'),to_date('04-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (32,89,'125520-1',to_date('05-MAY-14','DD-MON-RR'),95,95,0,3,to_date('08-JUN-14','DD-MON-RR'),to_date('22-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (33,123,'1-202-2978',to_date('06-MAY-14','DD-MON-RR'),33,33,0,1,to_date('20-MAY-14','DD-MON-RR'),to_date('13-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (34,110,'0-2436',to_date('07-MAY-14','DD-MON-RR'),10976.06,0,0,4,to_date('17-JUL-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (35,123,'1-200-5164',to_date('07-MAY-14','DD-MON-RR'),63.4,63.4,0,1,to_date('13-MAY-14','DD-MON-RR'),to_date('10-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (36,110,'0-2060',to_date('08-MAY-14','DD-MON-RR'),23517.58,21221.63,2295.95,3,to_date('09-JUN-14','DD-MON-RR'),to_date('10-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (37,110,'0-2058',to_date('08-MAY-14','DD-MON-RR'),37966.19,37966.19,0,3,to_date('09-JUN-14','DD-MON-RR'),to_date('31-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (38,123,'963253272',to_date('09-MAY-14','DD-MON-RR'),61.5,0,0,4,to_date('29-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (39,123,'963253271',to_date('09-MAY-14','DD-MON-RR'),158,0,0,4,to_date('28-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (40,123,'963253269',to_date('09-MAY-14','DD-MON-RR'),26.75,0,0,4,to_date('25-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (41,123,'963253267',to_date('09-MAY-14','DD-MON-RR'),23.5,0,0,4,to_date('24-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (42,97,'21-4748363',to_date('09-MAY-14','DD-MON-RR'),9.95,0,0,4,to_date('25-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (43,97,'21-4923721',to_date('09-MAY-14','DD-MON-RR'),9.95,9.95,0,1,to_date('21-MAY-14','DD-MON-RR'),to_date('13-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (44,123,'963253264',to_date('10-MAY-14','DD-MON-RR'),52.25,0,0,4,to_date('23-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (45,123,'963253263',to_date('10-MAY-14','DD-MON-RR'),109.5,0,0,4,to_date('22-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (46,123,'963253261',to_date('10-MAY-14','DD-MON-RR'),42.75,42.75,0,3,to_date('16-JUN-14','DD-MON-RR'),to_date('10-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (47,123,'963253260',to_date('10-MAY-14','DD-MON-RR'),36,36,0,3,to_date('15-JUN-14','DD-MON-RR'),to_date('06-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (48,123,'963253258',to_date('10-MAY-14','DD-MON-RR'),111,111,0,3,to_date('11-JUN-14','DD-MON-RR'),to_date('31-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (49,123,'963253256',to_date('10-MAY-14','DD-MON-RR'),53.25,53.25,0,3,to_date('10-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (50,123,'963253255',to_date('11-MAY-14','DD-MON-RR'),53.75,53.75,0,3,to_date('09-JUN-14','DD-MON-RR'),to_date('03-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (51,123,'963253254',to_date('11-MAY-14','DD-MON-RR'),108.5,108.5,0,3,to_date('08-JUN-14','DD-MON-RR'),to_date('30-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (52,123,'963253252',to_date('11-MAY-14','DD-MON-RR'),38.75,38.75,0,3,to_date('07-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (53,123,'963253251',to_date('11-MAY-14','DD-MON-RR'),15.5,15.5,0,3,to_date('04-JUN-14','DD-MON-RR'),to_date('21-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (54,123,'963253249',to_date('12-MAY-14','DD-MON-RR'),127.75,127.75,0,2,to_date('03-JUN-14','DD-MON-RR'),to_date('28-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (55,123,'963253248',to_date('13-MAY-14','DD-MON-RR'),241,241,0,2,to_date('02-JUN-14','DD-MON-RR'),to_date('24-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (56,123,'963253246',to_date('13-MAY-14','DD-MON-RR'),129,129,0,2,to_date('31-MAY-14','DD-MON-RR'),to_date('20-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (57,123,'963253245',to_date('13-MAY-14','DD-MON-RR'),40.75,40.75,0,2,to_date('28-MAY-14','DD-MON-RR'),to_date('14-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (58,123,'963253244',to_date('13-MAY-14','DD-MON-RR'),60,60,0,2,to_date('27-MAY-14','DD-MON-RR'),to_date('21-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (59,123,'963253242',to_date('13-MAY-14','DD-MON-RR'),104,104,0,2,to_date('26-MAY-14','DD-MON-RR'),to_date('17-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (60,123,'963253240',to_date('23-MAY-14','DD-MON-RR'),67,67,0,1,to_date('03-JUN-14','DD-MON-RR'),to_date('28-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (61,123,'963253239',to_date('23-MAY-14','DD-MON-RR'),147.25,147.25,0,1,to_date('02-JUN-14','DD-MON-RR'),to_date('28-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (62,123,'963253237',to_date('23-MAY-14','DD-MON-RR'),172.5,172.5,0,1,to_date('30-MAY-14','DD-MON-RR'),to_date('24-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (63,123,'963253235',to_date('14-MAY-14','DD-MON-RR'),108.25,108.25,0,1,to_date('20-MAY-14','DD-MON-RR'),to_date('17-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (64,123,'963253234',to_date('14-MAY-14','DD-MON-RR'),138.75,138.75,0,1,to_date('19-MAY-14','DD-MON-RR'),to_date('16-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (65,123,'963253232',to_date('14-MAY-14','DD-MON-RR'),127.75,127.75,0,1,to_date('18-MAY-14','DD-MON-RR'),to_date('16-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (66,123,'963253230',to_date('15-MAY-14','DD-MON-RR'),739.2,739.2,0,1,to_date('17-MAY-14','DD-MON-RR'),to_date('16-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (67,123,'43966316',to_date('17-MAY-14','DD-MON-RR'),10,0,0,3,to_date('19-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (68,123,'263253273',to_date('17-MAY-14','DD-MON-RR'),30.75,0,0,4,to_date('29-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (69,37,'547479217',to_date('17-MAY-14','DD-MON-RR'),116,0,0,3,to_date('22-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (70,123,'263253270',to_date('18-MAY-14','DD-MON-RR'),67.92,0,0,3,to_date('25-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (71,123,'263253268',to_date('18-MAY-14','DD-MON-RR'),59.97,0,0,3,to_date('24-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (72,123,'263253265',to_date('18-MAY-14','DD-MON-RR'),26.25,0,0,3,to_date('23-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (73,123,'263253257',to_date('18-MAY-14','DD-MON-RR'),22.57,22.57,0,2,to_date('10-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (74,123,'263253253',to_date('18-MAY-14','DD-MON-RR'),31.95,31.95,0,2,to_date('07-JUN-14','DD-MON-RR'),to_date('01-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (75,123,'263253250',to_date('19-MAY-14','DD-MON-RR'),42.67,42.67,0,2,to_date('03-JUN-14','DD-MON-RR'),to_date('25-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (76,123,'263253243',to_date('20-MAY-14','DD-MON-RR'),44.44,44.44,0,1,to_date('26-MAY-14','DD-MON-RR'),to_date('23-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (77,123,'263253241',to_date('20-MAY-14','DD-MON-RR'),40.2,40.2,0,1,to_date('25-MAY-14','DD-MON-RR'),to_date('22-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (78,123,'94007069',to_date('22-MAY-14','DD-MON-RR'),400,400,0,3,to_date('01-JUL-14','DD-MON-RR'),to_date('25-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (79,123,'963253262',to_date('22-MAY-14','DD-MON-RR'),42.5,0,0,3,to_date('21-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (80,105,'94007005',to_date('23-MAY-14','DD-MON-RR'),220,220,0,1,to_date('30-MAY-14','DD-MON-RR'),to_date('26-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (81,83,'31359783',to_date('23-MAY-14','DD-MON-RR'),1575,0,0,2,to_date('09-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (82,115,'25022117',to_date('24-MAY-14','DD-MON-RR'),6,0,0,3,to_date('21-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (83,115,'24946731',to_date('25-MAY-14','DD-MON-RR'),25.67,25.67,0,2,to_date('14-JUN-14','DD-MON-RR'),to_date('28-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (84,115,'24863706',to_date('27-MAY-14','DD-MON-RR'),6,6,0,1,to_date('07-JUN-14','DD-MON-RR'),to_date('01-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (85,115,'24780512',to_date('29-MAY-14','DD-MON-RR'),6,6,0,1,to_date('31-MAY-14','DD-MON-RR'),to_date('30-MAY-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (86,88,'972110',to_date('30-MAY-14','DD-MON-RR'),207.78,207.78,0,1,to_date('06-JUN-14','DD-MON-RR'),to_date('02-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (87,100,'587056',to_date('31-MAY-14','DD-MON-RR'),2184.5,2184.5,0,3,to_date('28-JUN-14','DD-MON-RR'),to_date('22-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (88,86,'367447',to_date('31-MAY-14','DD-MON-RR'),2433,0,0,3,to_date('30-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (89,99,'509786',to_date('31-MAY-14','DD-MON-RR'),6940.25,6940.25,0,2,to_date('16-JUN-14','DD-MON-RR'),to_date('08-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (90,108,'121897',to_date('01-JUN-14','DD-MON-RR'),450,450,0,2,to_date('19-JUN-14','DD-MON-RR'),to_date('14-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (91,80,'134116',to_date('01-JUN-14','DD-MON-RR'),90.36,0,0,3,to_date('02-JUL-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (92,80,'133560',to_date('01-JUN-14','DD-MON-RR'),175,175,0,2,to_date('20-JUN-14','DD-MON-RR'),to_date('03-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (93,104,'P02-3772',to_date('03-JUN-14','DD-MON-RR'),7125.34,7125.34,0,2,to_date('18-JUN-14','DD-MON-RR'),to_date('08-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (94,106,'9982771',to_date('03-JUN-14','DD-MON-RR'),503.2,0,0,2,to_date('18-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (95,107,'RTR-72-3662-X',to_date('04-JUN-14','DD-MON-RR'),1600,1600,0,2,to_date('18-JUN-14','DD-MON-RR'),to_date('11-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (96,113,'77290',to_date('04-JUN-14','DD-MON-RR'),1750,1750,0,2,to_date('18-JUN-14','DD-MON-RR'),to_date('08-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (97,119,'10843',to_date('04-JUN-14','DD-MON-RR'),4901.26,4901.26,0,2,to_date('18-JUN-14','DD-MON-RR'),to_date('11-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (98,95,'111-92R-10092',to_date('04-JUN-14','DD-MON-RR'),46.21,0,0,1,to_date('29-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (99,95,'111-92R-10093',to_date('05-JUN-14','DD-MON-RR'),39.77,0,0,2,to_date('28-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (100,96,'I77271-O01',to_date('05-JUN-14','DD-MON-RR'),662,0,0,2,to_date('24-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (101,103,'75C-90227',to_date('06-JUN-14','DD-MON-RR'),1367.5,1367.5,0,1,to_date('13-JUN-14','DD-MON-RR'),to_date('09-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (102,48,'P02-88D77S7',to_date('06-JUN-14','DD-MON-RR'),856.92,856.92,0,1,to_date('13-JUN-14','DD-MON-RR'),to_date('09-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (103,95,'111-92R-10094',to_date('06-JUN-14','DD-MON-RR'),19.67,0,0,1,to_date('27-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (104,114,'CBM9920-M-T77109',to_date('07-JUN-14','DD-MON-RR'),290,290,0,1,to_date('12-JUN-14','DD-MON-RR'),to_date('09-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (105,95,'111-92R-10095',to_date('07-JUN-14','DD-MON-RR'),32.7,0,0,3,to_date('26-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (106,95,'111-92R-10096',to_date('08-JUN-14','DD-MON-RR'),16.33,0,0,2,to_date('25-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (107,95,'111-92R-10097',to_date('08-JUN-14','DD-MON-RR'),16.33,0,0,1,to_date('24-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (108,117,'111897',to_date('11-JUN-14','DD-MON-RR'),16.62,16.62,0,1,to_date('14-JUN-14','DD-MON-RR'),to_date('12-JUN-14','DD-MON-RR'));
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (109,102,'109596',to_date('14-JUN-14','DD-MON-RR'),41.8,0,0,3,to_date('11-JUL-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (110,72,'39104',to_date('20-JUN-14','DD-MON-RR'),85.31,0,0,3,to_date('20-JUL-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (111,37,'547480102',to_date('19-MAY-14','DD-MON-RR'),224,0,0,3,to_date('24-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (112,37,'547481328',to_date('20-MAY-14','DD-MON-RR'),224,0,0,3,to_date('25-JUN-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (113,72,'40318',to_date('18-JUL-14','DD-MON-RR'),21842,0,0,3,to_date('20-JUL-14','DD-MON-RR'),null);
insert into invoices (invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
values (114,83,'31361833',to_date('23-MAY-14','DD-MON-RR'),579.42,0,0,2,to_date('09-JUN-14','DD-MON-RR'),null);

-- insertING into invoice_line_items
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (1,1,572,116.54,'MVS Online Library');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (2,1,572,1083.58,'MSDN');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (3,1,120,20551.18,'CICS Part 2');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (4,1,120,26881.4,'MVS JCL');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (5,1,527,936.93,'Quarterly Maintenance');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (6,1,553,2312.2,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (7,1,541,600,'Trade advertising');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (8,1,553,1927.54,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (9,1,553,2184.11,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (10,1,553,2318.03,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (11,1,553,3813.33,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (12,1,553,3689.99,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (13,1,553,2765.36,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (14,1,553,2115.81,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (15,1,540,313.55,'Card revision');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (16,1,553,2051.59,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (17,1,523,356.48,'Network wiring');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (18,1,540,904.14,'DB2 Card decks');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (19,1,536,1197,'MC Bouncebacks');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (19,2,540,765.13,'SCMD Flyer');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (20,1,536,639.77,'Card deck');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (21,1,536,601.95,'Card deck revision');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (22,1,536,953.1,'Crash Course revision');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (23,1,541,565.15,'Crash Course Ad');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (24,1,540,1000.46,'Crash Course Cover');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (25,1,553,10,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (26,1,553,162.75,'International shipment');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (27,1,553,10,'Address correction');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (28,1,553,27,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (29,1,553,13.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (30,1,570,17.5,'Supplies');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (31,1,553,144.7,'Int''l shipment');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (32,1,523,95,'Telephone service');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (33,1,553,33,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (34,1,120,10976.06,'VSAM for the Cobol Programmer');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (35,1,553,63.4,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (36,1,120,23517.58,'DB2 Part 1');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (37,1,120,37966.19,'CICS Desk Reference');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (38,1,553,61.5,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (39,1,553,158,'Int''l shipment');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (40,1,553,26.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (41,1,553,23.5,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (42,1,572,9.95,'Monthly access fee');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (43,1,572,9.95,'Monthly access fee');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (44,1,553,52.25,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (45,1,553,109.5,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (46,1,553,42.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (47,1,553,36,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (48,1,553,111,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (49,1,553,53.25,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (50,1,553,53.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (51,1,553,108.5,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (52,1,553,38.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (53,1,553,15.5,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (54,1,553,127.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (55,1,553,241,'Int''l shipment');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (56,1,553,129,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (57,1,553,40.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (58,1,553,60,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (59,1,553,104,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (60,1,553,67,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (61,1,553,147.25,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (62,1,553,172.5,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (63,1,553,108.25,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (64,1,553,138.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (65,1,553,127.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (66,1,553,739.2,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (67,1,553,10,'Address correction');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (68,1,553,30.75,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (69,1,510,116,'Health Insurance');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (70,1,553,67.92,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (71,1,553,59.97,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (72,1,553,26.25,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (73,1,553,22.57,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (74,1,553,31.95,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (75,1,553,42.67,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (76,1,553,44.44,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (77,1,553,40.2,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (78,1,553,400,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (79,1,553,42.5,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (80,1,591,220,'Form 571-L');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (81,1,541,1575,'Catalog ad');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (82,1,553,6,'Freight out');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (83,1,553,25.67,'Freight out');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (84,1,552,6,'Freight out');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (85,1,553,6,'Freight');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (86,1,540,207.78,'Prospect list');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (87,1,536,2184.5,'PC card deck');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (88,1,536,2433,'Card deck');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (89,1,120,6940.25,'OS Utilities');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (90,1,523,450,'Back office additions');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (91,1,536,90.36,'Card deck advertising');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (92,1,536,175,'Card deck advertising');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (93,1,548,7125.34,'Web site design');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (94,1,569,503.2,'Bronco lease');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (95,1,235,1600,'Income Tax');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (96,1,520,1750,'Warehouse lease');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (97,1,520,4901.26,'Office lease');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (98,1,522,46.21,'Telephone (Line 1)');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (99,1,522,39.77,'Telephone (Line 2)');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (100,1,580,50,'DiCicco''s');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (100,2,540,75.6,'Kinko''s');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (100,3,570,58.4,'Office Max');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (100,4,546,478,'Publishers Marketing');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (101,1,221,1367.5,'401K Contributions');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (102,1,574,856.92,'Property Taxes');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (103,1,522,19.67,'Telephone (Line 3)');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (104,1,552,290,'International pkg.');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (105,1,522,32.7,'Telephone (line 4)');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (106,1,522,16.33,'Telephone (line 5)');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (107,1,522,16.33,'Telephone (line 6)');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (108,1,589,16.62,'Propane-forklift');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (109,1,580,41.8,'Coffee');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (110,1,540,85.31,'Book copy');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (111,1,510,224,'Health Insurance');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (112,1,510,224,'Health Insurance');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (113,1,540,21842,'Book repro');
insert into invoice_line_items (invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
values (114,1,541,579.42,'Catalog ad');

commit;
