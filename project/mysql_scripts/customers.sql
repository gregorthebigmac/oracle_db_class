connect amazon_db;
create table customer_test (
	customer_id 		int 			primary key,
	first_name 			varchar2(50) 	not null,
	last_name 			varchar2(50) 	not null,
	email 				varchar2(255),
	phone_number 		varchar2(15),
	bldg_number_address varchar2(10),
	apt_number_address 	varchar2(5),
	street_address 		varchar2(50),
	city_address 		varchar2(100),
	state_address 		varchar2(50),
	postal_code_address varchar2(30)	not null,
	country_address 	varchar2(3)		not null,
	password_hashed 	varchar2(255)	not null,
	credit_card 		varchar2(19),
	cvv_code 			varchar2(4),
	paypal_account 		varchar2(255)
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
