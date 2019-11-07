create table product_test (
	product_id int primary key,
	item_description varchar not null,
	item_price decimal(19,4) not null,
	item_shipping decimal(19,4),
	item_specs varchar,
	star_char char(1) not null,
	star_value decimal(19,4) not null,
	/* TODO: add table for search keywords */
	keyword_1 char(20),
	keyword_2 char(20),
	keyword_3 char(20),
	keyword_4 char(20),
	keyword_5 char(20),
	keyword_6 char(20),
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
	'Gold,
	"Frugal',
	NULL,
	NULL,
	NULL,
	'Jewelry',
	1,
	2,
	3,
	4,
	5,
	6
);
