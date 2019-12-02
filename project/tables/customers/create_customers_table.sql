connect amazon_db;
create table customers (
	customer_id 		int 			primary key,
	first_name			varchar(50) 	not null,
	last_name 			varchar(50) 	not null,
	email 				varchar(255),
	phone_number 		varchar(15),
	bldg_number_address varchar(10),
	apt_number_address 	varchar(5),
	street_address		varchar(50),
	city_address 		varchar(100),
	state_address 		varchar(50),
	postal_code_address varchar(30)		not null,
	country_address 	varchar(3)		not null,
	password_hashed 	varchar(255)	not null,
	credit_card 		varchar(19),
	cvv_code 			varchar(4),
	paypal_account		varchar(255)
);

create sequence cust_id_seq
	start with 1
	increment by 1
	minvalue 0
	maxvalue 99999
	cycle cache 10 order;

insert into customers values (cust_id_seq.nextVal, 'generic_item',5, 5, 5,5,5,null,null,null,null,null,null,null,null,null,null,null, null);
insert into customers values (cust_id_seq.nextVal, 'Ben', 'Dover', 'bendover69@gmail.com', '223-575-5354', '4578', '9A', 'Artesian', 'Chicago', 'IL', '6032', 'USA', 'gqpoihoep95w8gsgoihtroewa987alsoigoewirhglusa', '1234567890123456', '590', 'Bendover69@compuserve.com');
insert into customers values (cust_id_seq.nextVal, 'John', 'Jackson', '12345@gmail.com', '312-555-5654', '1232', '5B', 'Carpenter', 'Chicago', 'IL', '60007', 'USA', 'po3-8y9h8uw9pg4shieghi;ty8e4', '1234567890123456', '324', 'jjackson32@hotmail.com');
