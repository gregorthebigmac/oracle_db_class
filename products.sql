create table product_test (
	product_id bigint primary key,
	item_description text not null,
	item_price decimal(19,4) not null,
	item_shipping decimal(19,4),
	item_specs text,
	star_char char(1) not null,
	star_value decimal (1,3), not null,
	/* TODO: add sub table for search keywords */
	keyword_1 char(20),
	keyword_2 char(20),
	keyword_3 char(20),
	keyword_4 char(20),
	keyword_5 char(20),
	keyword_6 char(20),
	/* TODO: add sub table for customer reviews */
	/* TODO: add sub table for related products */
	related_product_1 int references products(product_id),
	related_product_2 int references products(product_id),
	related_product_3 int references products(product_id),
	related_product_4 int references products(product_id),
	related_product_5 int references products(product_id),
	related_product_6 int references products(product_id),
);
