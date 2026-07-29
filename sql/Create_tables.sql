CREATE DATABASE retail_sales_db;
USE retail_sales_db;

CREATE TABLE customers (
    customer_id VARCHAR(32) NOT NULL,
    customer_unique_id VARCHAR(32) NOT NULL,
    customer_zip_code_prefix VARCHAR(5) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state CHAR(2) NOT NULL,

    PRIMARY KEY (customer_id)
);

CREATE TABLE orders (
    order_id VARCHAR(32) NOT NULL,
    customer_id VARCHAR(32) NOT NULL,
    order_status VARCHAR(20) NOT NULL,

    order_purchase_timestamp DATETIME NOT NULL,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME NOT NULL,

    PRIMARY KEY (order_id)
);

CREATE TABLE order_items (
    order_id VARCHAR(32) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(32) NOT NULL,
    seller_id VARCHAR(32) NOT NULL,
    shipping_limit_date DATETIME NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    freight_value DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (order_id, order_item_id)

);

CREATE TABLE products (
    product_id VARCHAR(32) NOT NULL,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT,
    PRIMARY KEY (product_id)
);

CREATE TABLE sellers (
    seller_id VARCHAR(32) NOT NULL,
    seller_zip_code_prefix VARCHAR(5) NOT NULL,
    seller_city VARCHAR(50) NOT NULL,
    seller_state CHAR(2) NOT NULL,
    PRIMARY KEY (seller_id)
);

CREATE TABLE payments (
    order_id VARCHAR(32) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(30) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL(10,2) NOT NULL
);

CREATE TABLE reviews (
    review_id VARCHAR(32) NOT NULL,
    order_id VARCHAR(32) NOT NULL,
    review_score INT NOT NULL,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,
    PRIMARY KEY (review_id)
);

CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100) NOT NULL,
    product_category_name_english VARCHAR(100),
    PRIMARY KEY (product_category_name)
);