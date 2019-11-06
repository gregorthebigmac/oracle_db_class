create table sales_test (
	product_id int primary key,
	qty_sold int,
	revenue_from_product decimal(19,4),
	num_of_customers_who_bought int,
	keyword_1_hits int,
	keyword_2_hits int,
	keyword_3_hits int,
	keyword_4_hits int,
	keyword_5_hits int,
	keyword_6_hits int,
	views_sales_ratio float,
	sim_product_after_viewing_1 int references product_test(product_id),
	sim_product_after_viewing_2 int references product_test(product_id),
	sim_product_after_viewing_3 int references product_test(product_id),
	sim_product_after_viewing_4 int references product_test(product_id),
	sim_product_after_viewing_5 int references product_test(product_id),
	sim_product_after_viewing_6 int references product_test(product_id)
);
