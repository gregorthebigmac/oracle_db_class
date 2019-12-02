connect amazon_db;
create table products (
	product_id			int primary key,
	description			varchar(4000) not null,
	unit_price 			decimal(19,4) not null,
	shipping_cost		decimal(19,4),
	product_specs		varchar(1000),
	qty_in_stock		int,
	star_char 			varchar(1) not null,
	star_value 			decimal(19,4) not null,
	keyword_1 varchar(20),
	keyword_2 varchar(20),
	keyword_3 varchar(20),
	keyword_4 varchar(20),
	keyword_5 varchar(20),
	keyword_6 varchar(20),
	related_product_1 int references products(product_id),
	related_product_2 int references products(product_id),
	related_product_3 int references products(product_id),
	related_product_4 int references products(product_id),
	related_product_5 int references products(product_id),
	related_product_6 int references products(product_id)
);

create sequence prod_id_seq
	start with 1
	increment by 1
	minvalue 0	maxvalue 99999
	cycle cache 10 order;

insert into products values (prod_id_seq.nextVal, 'Watch', '99.99', '4.99', NULL, '5', '5.64', 'Gold', 'Frugal', NULL, NULL, NULL, 'Jewelry', 1,2,3,4,5,6);
