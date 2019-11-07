create table customer_test (
	customer_id int primary key,
	first_name char(50) not null,
	last_name char(50) not null,
	email char(255),
	phone_number char(15),
	bldg_number_address char(10),
	apt_number_address char(5),
	street_address char(50),
	city_address char(100),
	state_address char(50),
	postal_code_address char(30) not null,
	country_address char(3) not null,
	password_hashed char(255) not null,
	credit_card char(19),
	cvv_code char(4),
	paypal_account char(255)
);

INSERT INTO CUSTOMER_TEST VALUES (
	'2',
	'Ben',
	'Dover',
	'bendover69@gmail.com',
	'223-575-5354',
	'4578',
	'Apt 9',
	'Artesian',
	'Chicago',
	'IL',
	'6032',
	'USA',
	'gqpoihoep95w8gsgoihtroewa987alsoigoewirhglusa',
	'555-555-5555',
	'590',
	'Bendover69'
);