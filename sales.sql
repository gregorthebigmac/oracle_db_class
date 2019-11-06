create table sales_test (
	product_id bigint primary key,
	qty_sold int,
	revenue_from_product decimal(19,4),
	num_of_customers_who_bought int,
	keyword_1_hits int,
	keyword_2_hits int,
	keyword_3_hits int,
	keyword_4 hits int,
	keyword_5 hits int,
	keyword_6 hits int,
	views_sales_ratio float,
	similar_product_after_viewing_1 bigint references products(product_id)
	similar_product_after_viewing_2 bigint references products(product_id)
	similar_product_after_viewing_3 bigint references products(product_id)
	similar_product_after_viewing_4 bigint references products(product_id)
	similar_product_after_viewing_5 bigint references products(product_id)
	similar_product_after_viewing_6 bigint references products(product_id)
)
