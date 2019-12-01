/* NOTE: varchar2 is SPECIFIC TO ORACLE DB and will not work in MySQL!
	varhcar(int size) works on both, but the max size compatible with both is
	only 4000.
*/
connect amazon_db;
create table product_test (
	product_id			int primary key,
	item_description	varchar(4000) not null,
	item_price 			decimal(19,4) not null,
	item_shipping		decimal(19,4),
	item_specs 			varchar(1000),
	star_char 			varchar(1) not null,
	star_value 			decimal(19,4) not null,
	/* TODO: add table for search keywords */
	keyword_1 varchar(20),
	keyword_2 varchar(20),
	keyword_3 varchar(20),
	keyword_4 varchar(20),
	keyword_5 varchar(20),
	keyword_6 varchar(20),
	/* TODO: add table for customer reviews */
	/* TODO: add table for related products */
	related_product_1 int references product_test(product_id),
	related_product_2 int references product_test(product_id),
	related_product_3 int references product_test(product_id),
	related_product_4 int references product_test(product_id),
	related_product_5 int references product_test(product_id),
	related_product_6 int references product_test(product_id)
);

insert into product_test values (
	'1',
	'Watch',
	'99.99',
	'4.99',
	NULL,
	'5',
	'5.64',
	'Gold',
	'Frugal',
	NULL, NULL,	NULL,
	'Jewelry',
	1,2,3,4,5,6
);
