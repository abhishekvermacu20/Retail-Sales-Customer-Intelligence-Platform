-- Complete Data Import

-- SELECT * FROM customers;
-- SELECT * FROM order_items;
-- SELECT * FROM orders;
-- SELECT * FROM payments;
-- SELECT * FROM product_category_translation;
-- SELECT * FROM products;
-- SELECT * FROM reviews;
-- SELECT * FROM sellers;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM sellers;
SELECT COUNT(*) FROM reviews;
SELECT COUNT(*) FROM geolocation;
SELECT COUNT(*) FROM category_translation;

-- Validate Relationships
SELECT COUNT(*) FROM customers;

-- Null Values
SELECT *
FROM customers
WHERE customer_id IS NULL;
-- Check for every table

-- Duplicate Values
SELECT customer_id, count(*)
FROM customers
GROUP BY customer_id
HAVING count(*)>1;
-- Check for every table


-- Data types
DESCRIBE orders;
DESCRIBE customers;
DESCRIBE order_items;

-- Data Cleaning
-- Customer Table

SELECT COUNT(*)
FROM customers;

SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*)>1;
-- NO DUPLICATES
SELECT customer_unique_id, COUNT(*)
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(*)>1;
-- Note: Multiple rows are expected because one customer can place multiple orders.

-- CHECK NULL VALUES
SELECT 
SUM(customer_id IS NULL) AS id_null,
SUM(customer_unique_id IS NULL) AS unique_null,
SUM(customer_zip_code_prefix IS NULL) AS zip_code_null,
SUM(customer_city IS NULL) AS city_null,
SUM(customer_state IS NULL) AS state_null
FROM customers;
-- NO NULL VALUES

-- Check empty strings
SELECT *
FROM customers
WHERE TRIM(customer_city) = ''
OR TRIM(customer_state) = '';

SELECT *
FROM customers
WHERE customer_zip_code_prefix <= 0;

-- STANDARDIZE CITY NAME
UPDATE customers
SET customer_city = TRIM(customer_city);

-- CONVERT STATE NAME TO UPPER CASE
UPDATE customers
SET customer_state = UPPER(customer_state);

-- SELLERS TABLE
-- DUPLICATE SELLER ID:-
SELECT seller_id, COUNT(*)
FROM SELLERS
GROUP BY seller_id
HAVING COUNT(*)>1;
-- no duplicates

-- NULL VALUES:
SELECT 
SUM(seller_id IS NULL) AS ID_NULL,
SUM(seller_zip_code_prefix IS NULL) AS CODE_NULL,
SUM(seller_city IS NULL) AS CITY_NULL,
SUM(seller_state IS NULL) AS STATE_NULL
FROM sellers;
-- no null values

-- check empty string
SELECT *
FROM SELLERS
WHERE TRIM(SELLER_CITY) = '';

-- STANDARDIZE
UPDATE sellers
SET seller_city = TRIM(seller_city);

UPDATE sellers
SET seller_state = UPPER(seller_state);

-- PRODUCT TABLE
-- DUPLICATE
SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*)>1;

-- NULL VALUES
SELECT
SUM(product_category_name IS NULL),
SUM(product_weight_g IS NULL),
SUM(product_length_cm IS NULL),
SUM(product_height_cm IS NULL),
SUM(product_width_cm IS NULL)
FROM products;
-- There are some NULL values
SELECT *
FROM products
WHERE product_category_name IS NULL
   OR product_weight_g IS NULL
   OR product_length_cm IS NULL
   OR product_height_cm IS NULL
   OR product_width_cm IS NULL;
-- For analysis, replace the missing category with "Unknown".
UPDATE products
SET product_category_name = 'Unknown'
WHERE product_category_name IS NULL;

SELECT *
FROM products
WHERE product_weight_g IS NULL;

-- Empty strings
SELECT *
FROM products
WHERE product_category_name='';

-- Invalid dimentions:
SELECT *
FROM products
WHERE product_weight_g <=0
OR product_length_cm<=0
OR product_width_cm<=0
OR product_height_cm<=0;

-- ORDER TABLE :
SELECT order_id,
COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*)>1;

SELECT
SUM(order_purchase_timestamp IS NULL),
SUM(order_delivered_customer_date IS NULL),
SUM(order_estimated_delivery_date IS NULL)
FROM orders;

SELECT *
FROM orders
WHERE order_purchase_timestamp >
order_delivered_customer_date;

SELECT DISTINCT order_status
FROM orders;

-- Order Items Table
SELECT
order_id,
order_item_id,
COUNT(*)
FROM order_items
GROUP BY order_id,order_item_id
HAVING COUNT(*)>1;

SELECT *
FROM order_items
WHERE price<=0;
SELECT *
FROM order_items
WHERE freight_value<0;

-- Payments Table
SELECT
order_id,
payment_sequential,
COUNT(*)
FROM payments
GROUP BY order_id,payment_sequential
HAVING COUNT(*)>1;

SELECT *
FROM payments
WHERE payment_value<=0;


-- Reviews Table
SELECT review_id,
COUNT(*)
FROM reviews
GROUP BY review_id
HAVING COUNT(*)>1;

SELECT *
FROM reviews
WHERE review_score NOT BETWEEN 1 AND 5;

SELECT COUNT(*)
FROM reviews
WHERE review_comment_message IS NULL;

-- Category Translation Table
SELECT product_category_name,
COUNT(*)
FROM product_category_translation
GROUP BY product_category_name
HAVING COUNT(*)>1;

SELECT *
FROM product_category_translation
WHERE product_category_name IS NULL
OR product_category_name_english IS NULL;

-- Referential Integrity Checks, all shoul be return 0
-- Orders without customers
SELECT COUNT(*)
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order items without orders
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Payments without orders
SELECT COUNT(*)
FROM payments p
LEFT JOIN orders o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Reviews without orders
SELECT COUNT(*)
FROM reviews r
LEFT JOIN orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Order items without products
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Order items without sellers
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN sellers s
ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;