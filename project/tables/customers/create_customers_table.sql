connect amazon_db;
create table customer_test (
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
	postal_code_address varchar(30)	not null,
	country_address 	varchar(3)		not null,
	password_hashed 	varchar(255)	not null,
	credit_card 		varchar(19),
	cvv_code 			varchar(4),
	paypal_account		varchar(255)
);

insert into customer_test values (
	'1',
	'John',
	'Jackson',
	'12345@gmail.com',
	'312-555-5654',
	'1232',
	'5B',
	'Carpenter',
	'Chicago',
	'IL',
	'60007',
	'USA',
	'po3-8y9h8uw9pg4shieghi;ty8e4',
	'1234567890123456',
	'324',
	'jjackson32@hotmail.com'
);

insert into customer_test values (
	'2',
	'Ben',
	'Dover',
	'bendover69@gmail.com',
	'223-575-5354',
	'4578',
	'9A',
	'Artesian',
	'Chicago',
	'IL',
	'6032',
	'USA',
	'gqpoihoep95w8gsgoihtroewa987alsoigoewirhglusa',
	'1234567890123456',
	'590',
	'Bendover69@compuserve.com'
);

insert into customer_test values (
	'3',
	'Alex',
	'Trebeck',
	'alext15@gmail.com',
	'708-555-5555',
	'8563',
	'7C',
	'Normal',
	'Chicago',
	'IL',
	'60807',
	'USA',
	'854-8y9h8uw9pg4shieghi;ty8e4',
	'1234567890123456',
	'984',
	'alext15@hotmail.com'
);




CREATE SEQUENCE qty_seq
    START WITH 1   INCREMENT BY 1
    MINVALUE 0   MAXVALUE 99999
    CYCLE CACHE 10 ORDER;
    
    INSERT INTO product_test VALUES (test_seq.nextVal, 'generic_item',5, 5, 5,5,5,null,null,null,null,null,null,null,null,null,null,null, null);
    