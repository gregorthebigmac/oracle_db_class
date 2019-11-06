create table sales_test (
	product_id bigint primary key,
	qty_sold int,
	revenue_from_product decimal(19,4),
	num_of_customers_who_bought int,
	keyword_1_hits int,
	keyword_2_hits int,
	keyword_3_hits int,
	keyword_4_hits int,
	studpi_shit;
	keyword_5_hits int,
	keyword_6_hits int,
	views_sales_ratio float,
	similar_product_after_viewing_1 bigint references product_test(product_id),
	similar_product_after_viewing_2 bigint references product_test(product_id),
	similar_product_after_viewing_3 bigint references product_test(product_id),
	similar_product_after_viewing_4 bigint references product_test(product_id),
	similar_product_after_viewing_5 bigint references product_test(product_id),
	similar_product_after_viewing_6 bigint references product_test(product_id
);
