connect  c##om/om;

set define off;

-- begin an anonymous PL/SQL script that drops all tables in the ex schema and
-- suppresses displaying the error messages if the tables don't exist
begin
	execute immediate 'drop table order_details';
	execute immediate 'drop table orders';
	execute immediate 'drop table items';
	execute immediate 'drop table customers';
exception when others then dbms_output.put_line('');
end;
/

create table customers (
	customer_id			number			not null,
	customer_first_name	varchar2(50),
	customer_last_name	varchar2(50)	not null,
	customer_address	varchar2(255)	not null,
	customer_city		varchar2(50)	not null,
	customer_state		char(2)			not null,
	customer_zip		varchar2(20)	not null,
	customer_phone		varchar2(30)	not null,
	customer_fax		varchar2(30),
	constraint customers_pk primary key (customer_id)
);

create table items (
	item_id		number			not null,
	title		varchar2(50)	not null,
	artist		varchar2(50)	not null,
	unit_price	number			not null,
	constraint items_pk primary key (item_id),
	constraint title_artist_unq unique (title, artist)
);

create table orders (
	order_id 		number	not null,
	customer_id		number	not null,
	order_date		date 	not null,
	shipped_date	date,
	constraint orders_pk primary key (order_id),
	constraint orders_fk_customers foreign key (customer_id) references customers (customer_id)
);

create table order_details (
	order_id	number	not null,
	item_id		number	not null,
	order_qty	number	not null,
	constraint order_details_pk primary key (order_id, item_id),
	constraint order_details_fk_orders foreign key (order_id) references orders (order_id),
	constraint order_details_fk_orders foreign key (item_id) references items (item_id)
);

-- insert into customers
insert into customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_city, customer_state, customer_zip, customer_phone, customer_fax)
values (1,'Korah','Blanca','1555 W Lane Ave','Columbus','OH','43221','6145554435','6145553928');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (2,'Yash','Randall','11 E Rancho Madera Rd','Madison','WI','53707','2095551205','2095552262');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (3,'Johnathon','Millerton','60 Madison Ave','New York','NY','10010','2125554800','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (4,'Mikayla','Damion','2021 K Street Nw','Washington','DC','20006','2025555561','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (5,'Kendall','Mayte','4775 E Miami River Rd','Cleves','OH','45002','5135553043','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (6,'Kaitlin','Hostlery','3250 Spring Grove Ave','Cincinnati','OH','45225','8005551957','8005552826');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (7,'Derek','Chaddick','9022 E Merchant Wy','Fairfield','IA','52556','5155556130','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (8,'Deborah','Damien','415 E Olive Ave','Fresno','CA','93728','5595558060','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (9,'Karina','Lacy','882 W Easton Wy','Los Angeles','CA','90084','8005557000','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (10,'Kurt','Nickalus','28210 N Avenue Stanford','Valencia','CA','91355','8055550584','8055556689');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (11,'Kelsey','Eulalia','7833 N Ridge Rd','Sacramento','CA','95887','2095557500','2095551302');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (12,'Anders','Rohansen','12345 E 67th Ave NW','Takoma Park','MD','24512','3385556772','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (13,'Thalia','Neftaly','2508 W Shaw Ave','Fresno','CA','93711','5595556245','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (14,'Gonzalo','Keeton','12 Daniel Road','Fairfield','NJ','07004','2015559742','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (15,'Ania','Irvin','1099 N Farcourt St','Orange','CA','92807','7145559000','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (16,'Dakota','Baylee','1033 N Sycamore Ave.','Los Angeles','CA','90038','2135554322','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (17,'Samuel','Jacobsen','3433 E Widget Ave','Palo Alto','CA','92711','4155553434','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (18,'Justin','Javen','828 S Broadway','Tarrytown','NY','10591','8005550037','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (19,'Kyle','Marissa','789 E Mercy Ave','Phoenix','AZ','85038','9475553900','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (20,'Erick','Kaleigh','Five Lakepointe Plaza, Ste 500','Charlotte','NC','28217','7045553500','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (21,'Marvin','Quintin','2677 Industrial Circle Dr','Columbus','OH','43260','6145558600','6145557580');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (22,'Rashad','Holbrooke','3467 W Shaw Ave #103','Fresno','CA','93711','5595558625','5595558495');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (23,'Trisha','Anum','627 Aviation Way','Manhatttan Beach','CA','90266','3105552732','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (24,'Julian','Carson','372 San Quentin','San Francisco','CA','94161','6175550700','NULL');
insert into customers (customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
values (25,'Kirsten','Story','2401 Wisconsin Ave NW','Washington','DC','20559','2065559115','NULL');

-- insert into items 
insert into items (item_id,title,artist,unit_price) values (1,'Umami In Concert','Umami',17.95);
insert into items (item_id,title,artist,unit_price) values (2,'Race Car Sounds','The Ubernerds',13);
insert into items (item_id,title,artist,unit_price) values (3,'No Rest For The Weary','No Rest For The Weary',16.95);
insert into items (item_id,title,artist,unit_price) values (4,'More Songs About Structures and Comestibles','No Rest For The Weary',17.95);
insert into items (item_id,title,artist,unit_price) values (5,'On The Road With Burt Ruggles','Burt Ruggles',17.5);
insert into items (item_id,title,artist,unit_price) values (6,'No Fixed Address','Sewed the Vest Pocket',16.95);
insert into items (item_id,title,artist,unit_price) values (7,'Rude Noises','Jess & Odie',13);
insert into items (item_id,title,artist,unit_price) values (8,'Burt Ruggles: An Intimate Portrait','Burt Ruggles',17.95);
insert into items (item_id,title,artist,unit_price) values (9,'Zone Out With Umami','Umami',16.95);
insert into items (item_id,title,artist,unit_price) values (10,'Etcetera','Onn & Onn',17);

-- insert into orders 
insert into orders (order_id,customer_id,order_date,shipped_date) values (19,1,to_date('23-OCT-12','DD-MON-RR'),to_date('28-OCT-12','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (29,8,to_date('05-NOV-12','DD-MON-RR'),to_date('11-NOV-12','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (32,11,to_date('10-NOV-12','DD-MON-RR'),to_date('13-NOV-12','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (45,2,to_date('25-NOV-12','DD-MON-RR'),to_date('30-NOV-12','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (70,10,to_date('28-DEC-12','DD-MON-RR'),to_date('07-JAN-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (89,22,to_date('20-JAN-13','DD-MON-RR'),to_date('22-JAN-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (97,20,to_date('29-JAN-13','DD-MON-RR'),to_date('02-FEB-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (118,3,vto_date('24-FEB-13','DD-MON-RR'),to_date('28-FEB-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (144,17,to_date('21-MAR-13','DD-MON-RR'),to_date('29-MAR-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (158,9,to_date('04-APR-13','DD-MON-RR'),to_date('20-APR-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (165,14,to_date('11-APR-13','DD-MON-RR'),to_date('13-APR-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (180,24,to_date('25-APR-13','DD-MON-RR'),to_date('30-MAY-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (231,15,to_date('14-JUN-13','DD-MON-RR'),to_date('22-JUN-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (242,23,to_date('24-JUN-13','DD-MON-RR'),to_date('06-JUL-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (264,9,to_date('15-JUL-13','DD-MON-RR'),to_date('18-JUL-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (298,18,to_date('18-AUG-13','DD-MON-RR'),to_date('22-SEP-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (321,2,to_date('09-SEP-13','DD-MON-RR'),to_date('05-OCT-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (381,7,to_date('08-NOV-13','DD-MON-RR'),to_date('16-NOV-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (392,19,to_date('16-NOV-13','DD-MON-RR'),to_date('23-NOV-13','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (413,17,to_date('05-DEC-13','DD-MON-RR'),to_date('11-JAN-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (442,5,to_date('28-DEC-13','DD-MON-RR'),to_date('03-JAN-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (479,1,to_date('30-JAN-14','DD-MON-RR'),to_date('03-MAR-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (491,16,to_date('08-FEB-14','DD-MON-RR'),to_date('14-FEB-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (494,4,to_date('10-FEB-14','DD-MON-RR'),to_date('14-FEB-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (523,3,to_date('07-MAR-14','DD-MON-RR'),to_date('15-MAR-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (548,2,to_date('22-MAR-14','DD-MON-RR'),to_date('18-APR-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (550,17,to_date('23-MAR-14','DD-MON-RR'),to_date('03-APR-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (601,16,to_date('21-APR-14','DD-MON-RR'),to_date('27-APR-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (606,6,to_date('25-APR-14','DD-MON-RR'),to_date('02-MAY-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (607,20,to_date('25-APR-14','DD-MON-RR'),to_date('04-MAY-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (624,2,to_date('04-MAY-14','DD-MON-RR'),to_date('09-MAY-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (627,17,to_date('05-MAY-14','DD-MON-RR'),to_date('10-MAY-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (630,20,to_date('08-MAY-14','DD-MON-RR'),to_date('18-MAY-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (631,21,to_date('09-MAY-14','DD-MON-RR'),to_date('11-MAY-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (651,12,to_date('19-MAY-14','DD-MON-RR'),to_date('02-JUN-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (658,12,to_date('23-MAY-14','DD-MON-RR'),to_date('02-JUN-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (687,17,to_date('05-JUN-14','DD-MON-RR'),to_date('08-JUN-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (693,9,to_date('07-JUN-14','DD-MON-RR'),to_date('19-JUN-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (703,19,to_date('12-JUN-14','DD-MON-RR'),to_date('19-JUN-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (773,25,to_date('11-JUL-14','DD-MON-RR'),to_date('13-JUL-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (778,13,to_date('12-JUL-14','DD-MON-RR'),to_date('21-JUL-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (796,17,to_date('19-JUL-14','DD-MON-RR'),to_date('26-JUL-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (800,19,to_date('21-JUL-14','DD-MON-RR'),to_date('28-JUL-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (802,2,to_date('21-JUL-14','DD-MON-RR'),to_date('31-JUL-14','DD-MON-RR'));
insert into orders (order_id,customer_id,order_date,shipped_date) values (824,1,to_date('01-AUG-14','DD-MON-RR'),null);
insert into orders (order_id,customer_id,order_date,shipped_date) values (827,18,to_date('02-AUG-14','DD-MON-RR'),null);
insert into orders (order_id,customer_id,order_date,shipped_date) values (829,9,to_date('02-AUG-14','DD-MON-RR'),null);

-- INSERTING into ORDER_DETAILS
insert into order_details (order_id,item_id,order_qty) values (381,1,1);
insert into order_details (order_id,item_id,order_qty) values (601,9,1);
insert into order_details (order_id,item_id,order_qty) values (442,1,1);
insert into order_details (order_id,item_id,order_qty) values (523,9,1);
insert into order_details (order_id,item_id,order_qty) values (630,5,1);
insert into order_details (order_id,item_id,order_qty) values (778,1,1);
insert into order_details (order_id,item_id,order_qty) values (693,10,1);
insert into order_details (order_id,item_id,order_qty) values (118,1,1);
insert into order_details (order_id,item_id,order_qty) values (264,7,1);
insert into order_details (order_id,item_id,order_qty) values (607,10,1);
insert into order_details (order_id,item_id,order_qty) values (624,7,1);
insert into order_details (order_id,item_id,order_qty) values (658,1,1);
insert into order_details (order_id,item_id,order_qty) values (800,5,1);
insert into order_details (order_id,item_id,order_qty) values (158,3,1);
insert into order_details (order_id,item_id,order_qty) values (321,10,1);
insert into order_details (order_id,item_id,order_qty) values (687,6,1);
insert into order_details (order_id,item_id,order_qty) values (827,6,1);
insert into order_details (order_id,item_id,order_qty) values (144,3,1);
insert into order_details (order_id,item_id,order_qty) values (264,8,1);
insert into order_details (order_id,item_id,order_qty) values (479,1,2);
insert into order_details (order_id,item_id,order_qty) values (630,6,2);
insert into order_details (order_id,item_id,order_qty) values (796,5,1);
insert into order_details (order_id,item_id,order_qty) values (97,4,1);
insert into order_details (order_id,item_id,order_qty) values (601,5,1);
insert into order_details (order_id,item_id,order_qty) values (773,10,1);
insert into order_details (order_id,item_id,order_qty) values (800,1,1);
insert into order_details (order_id,item_id,order_qty) values (29,10,1);
insert into order_details (order_id,item_id,order_qty) values (70,1,1);
insert into order_details (order_id,item_id,order_qty) values (97,8,1);
insert into order_details (order_id,item_id,order_qty) values (165,4,1);
insert into order_details (order_id,item_id,order_qty) values (180,4,1);
insert into order_details (order_id,item_id,order_qty) values (231,10,1);
insert into order_details (order_id,item_id,order_qty) values (392,8,1);
insert into order_details (order_id,item_id,order_qty) values (413,10,1);
insert into order_details (order_id,item_id,order_qty) values (491,6,1);
insert into order_details (order_id,item_id,order_qty) values (494,2,1);
insert into order_details (order_id,item_id,order_qty) values (606,8,1);
insert into order_details (order_id,item_id,order_qty) values (607,3,1);
insert into order_details (order_id,item_id,order_qty) values (651,3,1);
insert into order_details (order_id,item_id,order_qty) values (703,4,1);
insert into order_details (order_id,item_id,order_qty) values (796,2,1);
insert into order_details (order_id,item_id,order_qty) values (802,2,1);
insert into order_details (order_id,item_id,order_qty) values (802,3,1);
insert into order_details (order_id,item_id,order_qty) values (824,7,2);
insert into order_details (order_id,item_id,order_qty) values (829,1,1);
insert into order_details (order_id,item_id,order_qty) values (550,4,1);
insert into order_details (order_id,item_id,order_qty) values (796,7,1);
insert into order_details (order_id,item_id,order_qty) values (829,2,1);
insert into order_details (order_id,item_id,order_qty) values (693,6,1);
insert into order_details (order_id,item_id,order_qty) values (29,3,1);
insert into order_details (order_id,item_id,order_qty) values (32,7,1);
insert into order_details (order_id,item_id,order_qty) values (242,1,1);
insert into order_details (order_id,item_id,order_qty) values (298,1,1);
insert into order_details (order_id,item_id,order_qty) values (479,4,1);
insert into order_details (order_id,item_id,order_qty) values (548,9,1);
insert into order_details (order_id,item_id,order_qty) values (627,9,1);
insert into order_details (order_id,item_id,order_qty) values (778,3,1);
insert into order_details (order_id,item_id,order_qty) values (687,8,1);
insert into order_details (order_id,item_id,order_qty) values (19,5,1);
insert into order_details (order_id,item_id,order_qty) values (89,4,1);
insert into order_details (order_id,item_id,order_qty) values (242,6,1);
insert into order_details (order_id,item_id,order_qty) values (264,4,1);
insert into order_details (order_id,item_id,order_qty) values (550,1,1);
insert into order_details (order_id,item_id,order_qty) values (631,10,1);
insert into order_details (order_id,item_id,order_qty) values (693,7,3);
insert into order_details (order_id,item_id,order_qty) values (824,3,1);
insert into order_details (order_id,item_id,order_qty) values (829,5,1);
insert into order_details (order_id,item_id,order_qty) values (829,9,1);

commit;
