connect c##ex/ex;

set define off;

-- begin an anonymous PS/SQL script that drops all tables in the EX schema and
-- suppresses the error messages that are displayed if the tables don't exist
begin
	execute immediate 'drop table active_invoices';
	execute immediate 'drop table color_sample';
	execute immediate 'drop table customers';
	execute immediate 'drop table date_sample';
	execute immediate 'drop table departments';
	execute immediate 'drop table employees';
	execute immediate 'drop table float_sample';
	execute immediate 'drop table null_sample';
	execute immediate 'drop table paid_invoices';
	execute immediate 'drop table projects';
	execute immediate 'drop table string_sample';
exception when others then dbms_output.put_line('');
end;
/

create table active_invoices (
	invoice_id			number			not null,
	vendor_id			number			not null,
	invoice_number		varchar2(50)	not null,
	invoice_date		date 			not null,
	invoice_total		number(9,2)		not null,
	payment_total		number(9,2)		not null,
	credit_total		number(9,2)		not null,
	terms_id			number			not null,
	invoice_due_date	date			not null,
	payment_date		date
);

create table color_sample (
	color_id		number						not null,
	color_number	number			default 0	not null,
	color_name		varchar2(10)				not null,
);

create table customers (
	customer_id			number			not null,
	customer_last_name	varchar2(30),
	customer_first_name	varchar2(30),
	customer_address	varchar2(60),
	customer_city		varchar2(15),
	customer_state		varchar2(15),
	customer_zip		varchar2(10),
	customer_phone		varchar2(24),
);

create table date_sample (
	date_id		number	not null,
	start_date	date
);

create table departments (
	department_number	number			not null,
	department_name		varchar2(50)	not null,
	constraint department_number_unq unique (department_number)
);

create table employees (
	employee_id			number			not null,
	last_name			varchar2(35)	not null,
	first_name			varchar2(35)	not null,
	department_number	number			not null,
	manager_id			number			not null,
);

create table float_sample (
	float_id	number,
	float_value	binary_double
);

create table null_sample (
	invoice_id		number			not null,
	invoice_total	number(9,2),
	constraint invoice_id_unq unique (invoice_id)
);

create table paid_invoices (
	invoice_id			number			not null,
	vendor_id			number			not null,
	invoice_number		varchar2(50)	not null,
	invoice_date		date			not null,
	invoice_total		number(9,2)		not null,
	payment_total		number(9,2)		not null,
	credit_total		number(9,2)		not null,
	terms_id			number			not null,
	invoice_due_date	date			not null,
	payment_date		date			not null,
)

create table projects (
	project_number	varchar2(5)	not null,
	employee_id		number		not null,
);

create table string_sample (
	id		varchar2(3),
	name	varchar2(25)
);

-- insert into active_invoices

insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(3,110,'P-0608',to_date('11-APR-14','DD-MON-RR'),20551.18,0,1200,5,to_date('30-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(6,122,'989319-497',to_date('17-APR-14','DD-MON-RR'),2312.2,0,0,4,to_date('26-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(8,122,'989319-487',to_date('18-APR-14','DD-MON-RR'),1927.54,0,0,4,to_date('19-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(15,121,'97/553B',to_date('26-APR-14','DD-MON-RR'),313.55,0,0,4,to_date('09-JUL-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(18,121,'97/553',to_date('27-APR-14','DD-MON-RR'),904.14,0,0,4,to_date('09-JUL-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(19,121,'97/522',to_date('30-APR-14','DD-MON-RR'),1962.13,0,200,4,to_date('10-JUL-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(30,94,'203339-13',to_date('02-MAY-14','DD-MON-RR'),17.5,0,0,3,to_date('13-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(34,110,'0-2436',to_date('07-MAY-14','DD-MON-RR'),10976.06,0,0,4,to_date('17-JUL-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(38,123,'963253272',to_date('09-MAY-14','DD-MON-RR'),61.5,0,0,4,to_date('29-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(39,123,'963253271',to_date('09-MAY-14','DD-MON-RR'),158,0,0,4,to_date('28-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(40,123,'963253269',to_date('09-MAY-14','DD-MON-RR'),26.75,0,0,4,to_date('25-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(41,123,'963253267',to_date('09-MAY-14','DD-MON-RR'),23.5,0,0,4,to_date('24-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(42,97,'21-4748363',to_date('09-MAY-14','DD-MON-RR'),9.95,0,0,4,to_date('25-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(44,123,'963253264',to_date('10-MAY-14','DD-MON-RR'),52.25,0,0,4,to_date('23-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(45,123,'963253263',to_date('10-MAY-14','DD-MON-RR'),109.5,0,0,4,to_date('22-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(67,123,'43966316',to_date('17-MAY-14','DD-MON-RR'),10,0,0,3,to_date('19-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(68,123,'263253273',to_date('17-MAY-14','DD-MON-RR'),30.75,0,0,4,to_date('29-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(69,37,'547479217',to_date('17-MAY-14','DD-MON-RR'),116,0,0,3,to_date('22-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(70,123,'263253270',to_date('18-MAY-14','DD-MON-RR'),67.92,0,0,3,to_date('25-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(71,123,'263253268',to_date('18-MAY-14','DD-MON-RR'),59.97,0,0,3,to_date('24-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(72,123,'263253265',to_date('18-MAY-14','DD-MON-RR'),26.25,0,0,3,to_date('23-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(79,123,'963253262',to_date('22-MAY-14','DD-MON-RR'),42.5,0,0,3,to_date('21-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(81,83,'31359783',to_date('23-MAY-14','DD-MON-RR'),1575,0,0,2,to_date('09-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(82,115,'25022117',to_date('24-MAY-14','DD-MON-RR'),6,0,0,3,to_date('21-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(88,86,'367447',to_date('31-MAY-14','DD-MON-RR'),2433,0,0,3,to_date('30-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(91,80,'134116',to_date('01-JUN-14','DD-MON-RR'),90.36,0,0,3,to_date('02-JUL-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(94,106,'9982771',to_date('03-JUN-14','DD-MON-RR'),503.2,0,0,2,to_date('18-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(98,95,'111-92R-10092',to_date('04-JUN-14','DD-MON-RR'),46.21,0,0,1,to_date('29-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(99,95,'111-92R-10093',to_date('05-JUN-14','DD-MON-RR'),39.77,0,0,2,to_date('28-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(100,96,'I77271-O01',to_date('05-JUN-14','DD-MON-RR'),662,0,0,2,to_date('24-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(103,95,'111-92R-10094',to_date('06-JUN-14','DD-MON-RR'),19.67,0,0,1,to_date('27-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(105,95,'111-92R-10095',to_date('07-JUN-14','DD-MON-RR'),32.7,0,0,3,to_date('26-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(106,95,'111-92R-10096',to_date('08-JUN-14','DD-MON-RR'),16.33,0,0,2,to_date('25-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(107,95,'111-92R-10097',to_date('08-JUN-14','DD-MON-RR'),16.33,0,0,1,to_date('24-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(109,102,'109596',to_date('14-JUN-14','DD-MON-RR'),41.8,0,0,3,to_date('11-JUL-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(110,72,'39104',to_date('20-JUN-14','DD-MON-RR'),85.31,0,0,3,to_date('20-JUL-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(111,37,'547480102',to_date('19-MAY-14','DD-MON-RR'),224,0,0,3,to_date('24-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(112,37,'547481328',to_date('20-MAY-14','DD-MON-RR'),224,0,0,3,to_date('25-JUN-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(113,72,'40318',to_date('18-JUL-14','DD-MON-RR'),21842,0,0,3,to_date('20-JUL-14','DD-MON-RR'),null);
insert into active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(114,83,'31361833',to_date('23-MAY-14','DD-MON-RR'),579.42,0,0,2,to_date('09-JUN-14','DD-MON-RR'),null);


-- insert into customers

insert into customers values (1, 'Anders', 'Maria', '345 Winchell Pl', 'Anderson', 'IN', '46014', '(765) 555-7878');
insert into customers values (2, 'Trujillo', 'Ana', '1298 E Smathers St', 'Benton', 'AR', '72018', '(501) 555-7733');
insert into customers values (3, 'Moreno', 'Antonio', '6925 N Parkland Ave', 'Puyallup', 'WA', '98373', '(253) 555-8332');
insert into customers values (4, 'Hardy', 'Thomas', '83 d''Urberville Ln', 'Casterbridge', 'GA', '31209', '(478) 555-1139');
insert into customers values (5, 'Berglund', 'Christina', '22717 E 73rd Ave', 'Dubuque', 'IA', '52004', '(319) 555-1139');
insert into customers values (6, 'Moos', 'Hanna', '1778 N Bovine Ave', 'Peoria', 'IL', '61638', '(309) 555-8755');
insert into customers values (7, 'Citeaux', 'Fred', '1234 Main St', 'Normal', 'IL', '61761', '(309) 555-1914');
insert into customers values (8, 'Summer', 'Martin', '1877 Ete Ct', 'Frogtown', 'LA', '70563', '(337) 555-9441');
insert into customers values (9, 'Lebihan', 'Laurence', '717 E Michigan Ave', 'Chicago', 'IL', '60611', '(312) 555-9441');
insert into customers values (10, 'Lincoln', 'Elizabeth', '4562 Rt 78 E', 'Vancouver', 'WA', '98684', '(360) 555-2680');
insert into customers values (11, 'Snyder', 'Howard', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', '(503) 555-7555');
insert into customers values (12, 'Latimer', 'Yoshi', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', '(503) 555-6874');
insert into customers values (13, 'Steel', 'John', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', '(509) 555-7969');
insert into customers values (14, 'Yorres', 'Jaime', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', '(415) 555-5938');
insert into customers values (15, 'Wilson', 'Fran', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', '(503) 555-9573');
insert into customers values (16, 'Phillips', 'Rene', '2743 Bering St.', 'Anchorage', 'AK', '99508', '(907) 555-7584');
insert into customers values (17, 'Wilson', 'Paula', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', '(505) 555-5939');
insert into customers values (18, 'Pavarotti', 'Jose', '187 Suffolk Ln.', 'Boise', 'ID', '83720', '(208) 555-8097');
insert into customers values (19, 'Braunschweiger', 'Art', 'P.O. Box 555', 'Lander', 'WY', '82520', '(307) 555-4680');
insert into customers values (20, 'Nixon', 'Liz', '89 Jefferson Way Suite 2', 'Providence', 'RI', '02909', '(401) 555-3612');
insert into customers values (21, 'Wong', 'Liu', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', '(406) 555-5834');
insert into customers values (22, 'Nagy', 'Helvetius', '722 DaVinci Blvd.', 'Concord', 'MA', '01742', '(351) 555-1219');
insert into customers values (23, 'Jablonski', 'Karl', '305 - 14th Ave. S. Suite 3B', 'Seattle', 'WA', '98128', '(206) 555-4112');
insert into customers values (24, 'Chelan', 'Donna', '2299 E Baylor Dr', 'Dallas', 'TX', '75224', '(469) 555-8828');

-- insert into date_sample

insert into date_sample values (1, to_date('1979-03-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into date_sample values (2, to_date('1999-02-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into date_sample values (3, to_date('2003-10-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into date_sample values (4, to_date('2005-02-28 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into date_sample values (5, to_date('2006-02-28 13:58:32', 'YYYY-MM-DD HH24:MI:SS'));
insert into date_sample values (6, to_date('2006-03-01 09:02:25', 'YYYY-MM-DD HH24:MI:SS'));

-- insert into departments 

insert into departments (department_number,department_name) values
(1,'Accounting');
insert into departments (department_number,department_name) values
(2,'Payroll');
insert into departments (department_number,department_name) values
(3,'Operations');
insert into departments (department_number,department_name) values
(4,'Personnel');
insert into departments (department_number,department_name) values
(5,'Maintenance');

-- insert into employees

insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(1,'Smith','Cindy',2,null);
insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(2,'Jones','Elmer',4,1);
insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(3,'Simonian','Ralph',2,2);
insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(4,'Hernandez','Olivia',1,9);
insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(5,'Aaronsen','Robert',2,4);
insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(6,'Watson','Denise',6,8);
insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(7,'Hardy','Thomas',5,2);
insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(8,'O''Leary','Rhea',4,9);
insert into employees
(employee_id,last_name,first_name,department_number,manager_id) values
(9,'Locario','Paulo',6,1);

-- insert into float_sample 

insert into float_sample values (1, 0.999999999999999);
insert into float_sample values (2, 1);
insert into float_sample values (3, 1.000000000000001);
insert into float_sample values (4, 1234.56789012345);
insert into float_sample values (5, 999.04440209348);
insert into float_sample values (6, 24.04849);


-- insert into null_sample 

insert into null_sample (invoice_id,invoice_total) values (1,125);
insert into null_sample (invoice_id,invoice_total) values (2,0);
insert into null_sample (invoice_id,invoice_total) values (3,null);
insert into null_sample (invoice_id,invoice_total) values (4,2199.99);
insert into null_sample (invoice_id,invoice_total) values (5,0);

-- insert into paid_invoices

insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(2,34,'Q545443',to_date('14-MAR-14','DD-MON-RR'),1083.58,1083.58,0,4,to_date('23-MAY-14','DD-MON-RR'),to_date('14-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(4,110,'P-0259',to_date('16-APR-14','DD-MON-RR'),26881.4,26881.4,0,3,to_date('16-MAY-14','DD-MON-RR'),to_date('12-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(5,81,'MABO1489',to_date('16-APR-14','DD-MON-RR'),936.93,936.93,0,3,to_date('16-MAY-14','DD-MON-RR'),to_date('13-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(7,82,'C73-24',to_date('17-APR-14','DD-MON-RR'),600,600,0,2,to_date('10-MAY-14','DD-MON-RR'),to_date('05-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(9,122,'989319-477',to_date('19-APR-14','DD-MON-RR'),2184.11,2184.11,0,4,to_date('12-JUN-14','DD-MON-RR'),to_date('07-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(10,122,'989319-467',to_date('24-APR-14','DD-MON-RR'),2318.03,2318.03,0,4,to_date('05-JUN-14','DD-MON-RR'),to_date('29-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(11,122,'989319-457',to_date('24-APR-14','DD-MON-RR'),3813.33,3813.33,0,3,to_date('29-MAY-14','DD-MON-RR'),to_date('20-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(12,122,'989319-447',to_date('24-APR-14','DD-MON-RR'),3689.99,3689.99,0,3,to_date('22-MAY-14','DD-MON-RR'),to_date('12-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(13,122,'989319-437',to_date('24-APR-14','DD-MON-RR'),2765.36,2765.36,0,2,to_date('15-MAY-14','DD-MON-RR'),to_date('03-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(14,122,'989319-427',to_date('25-APR-14','DD-MON-RR'),2115.81,2115.81,0,1,to_date('08-MAY-14','DD-MON-RR'),to_date('01-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(16,122,'989319-417',to_date('26-APR-14','DD-MON-RR'),2051.59,2051.59,0,1,to_date('01-MAY-14','DD-MON-RR'),to_date('28-APR-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(17,90,'97-1024A',to_date('26-APR-14','DD-MON-RR'),356.48,356.48,0,3,to_date('09-JUN-14','DD-MON-RR'),to_date('09-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(20,121,'97/503',to_date('30-APR-14','DD-MON-RR'),639.77,639.77,0,4,to_date('11-JUN-14','DD-MON-RR'),to_date('05-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(21,121,'97/488',to_date('30-APR-14','DD-MON-RR'),601.95,601.95,0,3,to_date('03-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(22,121,'97/486',to_date('30-APR-14','DD-MON-RR'),953.1,953.1,0,2,to_date('21-MAY-14','DD-MON-RR'),to_date('13-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(23,121,'97/465',to_date('01-MAY-14','DD-MON-RR'),565.15,565.15,0,1,to_date('14-MAY-14','DD-MON-RR'),to_date('05-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(24,121,'97/222',to_date('01-MAY-14','DD-MON-RR'),1000.46,1000.46,0,3,to_date('03-JUN-14','DD-MON-RR'),to_date('25-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(25,123,'4-342-8069',to_date('01-MAY-14','DD-MON-RR'),10,10,0,4,to_date('10-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(26,123,'4-327-7357',to_date('01-MAY-14','DD-MON-RR'),162.75,162.75,0,3,to_date('27-MAY-14','DD-MON-RR'),to_date('21-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(27,123,'4-321-2596',to_date('01-MAY-14','DD-MON-RR'),10,10,0,2,to_date('20-MAY-14','DD-MON-RR'),to_date('11-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(28,123,'7548906-20',to_date('01-MAY-14','DD-MON-RR'),27,27,0,3,to_date('06-JUN-14','DD-MON-RR'),to_date('26-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(29,123,'4-314-3057',to_date('02-MAY-14','DD-MON-RR'),13.75,13.75,0,1,to_date('13-MAY-14','DD-MON-RR'),to_date('07-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(31,123,'2-000-2993',to_date('03-MAY-14','DD-MON-RR'),144.7,144.7,0,1,to_date('06-MAY-14','DD-MON-RR'),to_date('04-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(32,89,'125520-1',to_date('05-MAY-14','DD-MON-RR'),95,95,0,3,to_date('08-JUN-14','DD-MON-RR'),to_date('22-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(33,123,'1-202-2978',to_date('06-MAY-14','DD-MON-RR'),33,33,0,1,to_date('20-MAY-14','DD-MON-RR'),to_date('13-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(35,123,'1-200-5164',to_date('07-MAY-14','DD-MON-RR'),63.4,63.4,0,1,to_date('13-MAY-14','DD-MON-RR'),to_date('10-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(36,110,'0-2060',to_date('08-MAY-14','DD-MON-RR'),23517.58,21221.63,2295.95,3,to_date('09-JUN-14','DD-MON-RR'),to_date('10-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(37,110,'0-2058',to_date('08-MAY-14','DD-MON-RR'),37966.19,37966.19,0,3,to_date('09-JUN-14','DD-MON-RR'),to_date('31-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(43,97,'21-4923721',to_date('09-MAY-14','DD-MON-RR'),9.95,9.95,0,1,to_date('21-MAY-14','DD-MON-RR'),to_date('13-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(46,123,'963253261',to_date('10-MAY-14','DD-MON-RR'),42.75,42.75,0,3,to_date('16-JUN-14','DD-MON-RR'),to_date('10-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(47,123,'963253260',to_date('10-MAY-14','DD-MON-RR'),36,36,0,3,to_date('15-JUN-14','DD-MON-RR'),to_date('06-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(48,123,'963253258',to_date('10-MAY-14','DD-MON-RR'),111,111,0,3,to_date('11-JUN-14','DD-MON-RR'),to_date('31-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(49,123,'963253256',to_date('10-MAY-14','DD-MON-RR'),53.25,53.25,0,3,to_date('10-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(50,123,'963253255',to_date('11-MAY-14','DD-MON-RR'),53.75,53.75,0,3,to_date('09-JUN-14','DD-MON-RR'),to_date('03-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(51,123,'963253254',to_date('11-MAY-14','DD-MON-RR'),108.5,108.5,0,3,to_date('08-JUN-14','DD-MON-RR'),to_date('30-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(52,123,'963253252',to_date('11-MAY-14','DD-MON-RR'),38.75,38.75,0,3,to_date('07-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(53,123,'963253251',to_date('11-MAY-14','DD-MON-RR'),15.5,15.5,0,3,to_date('04-JUN-14','DD-MON-RR'),to_date('21-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(54,123,'963253249',to_date('12-MAY-14','DD-MON-RR'),127.75,127.75,0,2,to_date('03-JUN-14','DD-MON-RR'),to_date('28-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(55,123,'963253248',to_date('13-MAY-14','DD-MON-RR'),241,241,0,2,to_date('02-JUN-14','DD-MON-RR'),to_date('24-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(56,123,'963253246',to_date('13-MAY-14','DD-MON-RR'),129,129,0,2,to_date('31-MAY-14','DD-MON-RR'),to_date('20-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(57,123,'963253245',to_date('13-MAY-14','DD-MON-RR'),40.75,40.75,0,2,to_date('28-MAY-14','DD-MON-RR'),to_date('14-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(58,123,'963253244',to_date('13-MAY-14','DD-MON-RR'),60,60,0,2,to_date('27-MAY-14','DD-MON-RR'),to_date('21-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(59,123,'963253242',to_date('13-MAY-14','DD-MON-RR'),104,104,0,2,to_date('26-MAY-14','DD-MON-RR'),to_date('17-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(60,123,'963253240',to_date('23-MAY-14','DD-MON-RR'),67,67,0,1,to_date('03-JUN-14','DD-MON-RR'),to_date('28-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(61,123,'963253239',to_date('23-MAY-14','DD-MON-RR'),147.25,147.25,0,1,to_date('02-JUN-14','DD-MON-RR'),to_date('28-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(62,123,'963253237',to_date('23-MAY-14','DD-MON-RR'),172.5,172.5,0,1,to_date('30-MAY-14','DD-MON-RR'),to_date('24-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(63,123,'963253235',to_date('14-MAY-14','DD-MON-RR'),108.25,108.25,0,1,to_date('20-MAY-14','DD-MON-RR'),to_date('17-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(64,123,'963253234',to_date('14-MAY-14','DD-MON-RR'),138.75,138.75,0,1,to_date('19-MAY-14','DD-MON-RR'),to_date('16-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(65,123,'963253232',to_date('14-MAY-14','DD-MON-RR'),127.75,127.75,0,1,to_date('18-MAY-14','DD-MON-RR'),to_date('16-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(66,123,'963253230',to_date('15-MAY-14','DD-MON-RR'),739.2,739.2,0,1,to_date('17-MAY-14','DD-MON-RR'),to_date('16-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(73,123,'263253257',to_date('18-MAY-14','DD-MON-RR'),22.57,22.57,0,2,to_date('10-JUN-14','DD-MON-RR'),to_date('27-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(74,123,'263253253',to_date('18-MAY-14','DD-MON-RR'),31.95,31.95,0,2,to_date('07-JUN-14','DD-MON-RR'),to_date('01-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(75,123,'263253250',to_date('19-MAY-14','DD-MON-RR'),42.67,42.67,0,2,to_date('03-JUN-14','DD-MON-RR'),to_date('25-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(76,123,'263253243',to_date('20-MAY-14','DD-MON-RR'),44.44,44.44,0,1,to_date('26-MAY-14','DD-MON-RR'),to_date('23-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(77,123,'263253241',to_date('20-MAY-14','DD-MON-RR'),40.2,40.2,0,1,to_date('25-MAY-14','DD-MON-RR'),to_date('22-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(78,123,'94007069',to_date('22-MAY-14','DD-MON-RR'),400,400,0,3,to_date('01-JUL-14','DD-MON-RR'),to_date('25-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(80,105,'94007005',to_date('23-MAY-14','DD-MON-RR'),220,220,0,1,to_date('30-MAY-14','DD-MON-RR'),to_date('26-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(83,115,'24946731',to_date('25-MAY-14','DD-MON-RR'),25.67,25.67,0,2,to_date('14-JUN-14','DD-MON-RR'),to_date('28-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(84,115,'24863706',to_date('27-MAY-14','DD-MON-RR'),6,6,0,1,to_date('07-JUN-14','DD-MON-RR'),to_date('01-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(85,115,'24780512',to_date('29-MAY-14','DD-MON-RR'),6,6,0,1,to_date('31-MAY-14','DD-MON-RR'),to_date('30-MAY-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(86,88,'972110',to_date('30-MAY-14','DD-MON-RR'),207.78,207.78,0,1,to_date('06-JUN-14','DD-MON-RR'),to_date('02-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(87,100,'587056',to_date('31-MAY-14','DD-MON-RR'),2184.5,2184.5,0,3,to_date('28-JUN-14','DD-MON-RR'),to_date('22-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(89,99,'509786',to_date('31-MAY-14','DD-MON-RR'),6940.25,6940.25,0,2,to_date('16-JUN-14','DD-MON-RR'),to_date('08-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(90,108,'121897',to_date('01-JUN-14','DD-MON-RR'),450,450,0,2,to_date('19-JUN-14','DD-MON-RR'),to_date('14-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(92,80,'133560',to_date('01-JUN-14','DD-MON-RR'),175,175,0,2,to_date('20-JUN-14','DD-MON-RR'),to_date('03-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(93,104,'P02-3772',to_date('03-JUN-14','DD-MON-RR'),7125.34,7125.34,0,2,to_date('18-JUN-14','DD-MON-RR'),to_date('08-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(95,107,'RTR-72-3662-X',to_date('04-JUN-14','DD-MON-RR'),1600,1600,0,2,to_date('18-JUN-14','DD-MON-RR'),to_date('11-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(96,113,'77290',to_date('04-JUN-14','DD-MON-RR'),1750,1750,0,2,to_date('18-JUN-14','DD-MON-RR'),to_date('08-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(97,119,'10843',to_date('04-JUN-14','DD-MON-RR'),4901.26,4901.26,0,2,to_date('18-JUN-14','DD-MON-RR'),to_date('11-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(101,103,'75C-90227',to_date('06-JUN-14','DD-MON-RR'),1367.5,1367.5,0,1,to_date('13-JUN-14','DD-MON-RR'),to_date('09-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(102,48,'P02-88D77S7',to_date('06-JUN-14','DD-MON-RR'),856.92,856.92,0,1,to_date('13-JUN-14','DD-MON-RR'),to_date('09-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(104,114,'CBM9920-M-T77109',to_date('07-JUN-14','DD-MON-RR'),290,290,0,1,to_date('12-JUN-14','DD-MON-RR'),to_date('09-JUN-14','DD-MON-RR'));
insert into paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
values
(108,117,'111897',to_date('11-JUN-14','DD-MON-RR'),16.62,16.62,0,1,to_date('14-JUN-14','DD-MON-RR'),to_date('12-JUN-14','DD-MON-RR'));

-- INSERTING into PROJECTS

insert into projects (project_number,employee_id) values ('P1011',8);
insert into projects (project_number,employee_id) values ('P1011',4);
insert into projects (project_number,employee_id) values ('P1012',3);
insert into projects (project_number,employee_id) values ('P1012',1);
insert into projects (project_number,employee_id) values ('P1012',5);
insert into projects (project_number,employee_id) values ('P1013',6);
insert into projects (project_number,employee_id) values ('P1013',9);
insert into projects (project_number,employee_id) values ('P1014',10);

-- INSERTING into STRING_SAMPLE

insert into string_sample values ('1', 'Lizbeth Darien');
insert into string_sample values ('2', 'Darnell O''Sullivan');
insert into string_sample values ('17', 'Lance Pinos-Potter');
insert into string_sample values ('20', 'Jean Paul Renard');
insert into string_sample values ('3', 'Alisha von Strump');

COMMIT;
