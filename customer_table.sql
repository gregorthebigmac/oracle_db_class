create table amazon_test (
	customer_id int not null,
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
	paypal_account char(255),
	primary key (customer_id)
);
