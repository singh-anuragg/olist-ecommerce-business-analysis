CREATE TABLE customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);
CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
	order_delivered_carrier_date TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date DATE
);
CREATE TABLE products (
	product_id VARCHAR(50),
	product_category_name Text,
	product_name_length NUMERIC,
	product_description_length NUMERIC,
	product_photos_qty NUMERIC,
	product_weight_g NUMERIC,
	product_length_qty NUMERIC,
	product_height_qty NUMERIC,
	product_widt_qty NUMERIC
);
Select * from products

CREATE TABLE sellers (
	seller_id VARCHAR(50),
	seller_zip_code_prefix NUMERIC,
	seller_city Text,
	seller_state Text
	);

CREATE TABLE name_translation (
	product_category_name Text,
	product_category_name_english Text
	);

CREATE TABLE order_review(
	review_id VARCHAR(50),
	order_id VARCHAR(50),
	review_score NUMERIC,
	review_comment_title TEXT,
	review_comment_message TEXT,
	review_creation_date DATE,
	review_answer_timestamp TIMESTAMP
);

CREATE TABLE order_payments(
	order_id VARCHAR(50),
	payment_sequential NUMERIC,
	payment_type TEXT,
	payment_installments NUMERIC,
	payment_value NUMERIC
);

CREATE TABLE order_items(
	order_id VARCHAR(50),
	order_item_id NUMERIC,
	product_id VARCHAR(50),
	seller_id VARCHAR(50),
	shipping_limit_date TIMESTAMP,
	price NUMERIC,
	freight_value NUMERIC
);

CREATE TABLE geolocation(
	geolocation_zip_code_prefix NUMERIC,
	geolocation_lat DOUBLE PRECISION,
	geolocation_lng DOUBLE PRECISION,
	geolocation_city TEXT,
 	geolocation_state TEXT
);
