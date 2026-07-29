SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'secure_file_priv';


USE retail_sales_db;

-- Load data for customer table
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load data for order items table
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load data for orders table
-- We use diffrent command because orders dataset has empty fields, like ,,, istead of Null.
-- order_id,customer_id,order_status,purchase_date,approved_date,carrier_date
-- 12345,ABC,delivered,2018-01-01 10:00:00,2018-01-01 10:05:00,
-- Notice carrier date = ''
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
order_id,
customer_id,
order_status,
@purchase,
@approved,
@carrier,
@delivered,
@estimated
)
SET
order_purchase_timestamp =
    STR_TO_DATE(@purchase,'%Y-%m-%d %H:%i:%s'),

order_approved_at =
    STR_TO_DATE(NULLIF(@approved,''),'%Y-%m-%d %H:%i:%s'),

order_delivered_carrier_date =
    STR_TO_DATE(NULLIF(@carrier,''),'%Y-%m-%d %H:%i:%s'),

order_delivered_customer_date =
    STR_TO_DATE(NULLIF(@delivered,''),'%Y-%m-%d %H:%i:%s'),

order_estimated_delivery_date =
    STR_TO_DATE(@estimated,'%Y-%m-%d %H:%i:%s');

SELECT COUNT(*) FROM ORDERS;

-- Load data for payments table
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	order_id,
    payment_sequential,
    @paymentType,
    @paymentInstallments,
    @paymentValue
)
SET
payment_type = NULLIF(@paymentType,''),
payment_installments = NULLIF(@paymentInstallments,''),
payment_value = NULLIF(@paymentValue,'');

SELECT COUNT(*) FROM PAYMENTS;

-- Load data for product_category_translation table

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv'
INTO TABLE product_category_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	product_category_name,
    @translation
)
SET 
Product_category_name_english = NULLIF(@translation,'');

SELECT COUNT(*) FROM product_category_translation;



-- Load data for products table
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    product_id,
    @category,
    @name_length,
    @description_length,
    @photos_qty,
    @weight,
    @length,
    @height,
    @width
)
SET
product_category_name = NULLIF(@category,''),

product_name_lenght =
    CAST(NULLIF(@name_length,'') AS UNSIGNED),

product_description_lenght =
    CAST(NULLIF(@description_length,'') AS UNSIGNED),

product_photos_qty =
    CAST(NULLIF(@photos_qty,'') AS UNSIGNED),

product_weight_g =
    CAST(NULLIF(@weight,'') AS UNSIGNED),

product_length_cm =
    CAST(NULLIF(@length,'') AS UNSIGNED),

product_height_cm =
    CAST(NULLIF(@height,'') AS UNSIGNED),

product_width_cm =
    CAST(NULLIF(@width,'') AS UNSIGNED);
    
    
-- Load data for sellers table
-- Truncated the values : 
TRUNCATE TABLE reviews;
-- In this Olist dataset, a review_id may be associated with multiple orders, so using only review_id as 
-- the primary key can cause this error.A composite key using both review_id and order_id is more appropriate.
ALTER TABLE reviews
DROP PRIMARY KEY,
ADD PRIMARY KEY (review_id, order_id);

-- Load/Insert review data:-
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load data for reviews table
    
    LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
IGNORE
INTO TABLE reviews
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    review_id,
    order_id,
    review_score,
    @review_title,
    @review_message,
    @creation_date,
    @answer_date
)
SET
    review_comment_title = NULLIF(TRIM(@review_title), ''),
    review_comment_message = NULLIF(TRIM(@review_message), ''),
    review_creation_date =
        STR_TO_DATE(NULLIF(TRIM(@creation_date), ''), '%Y-%m-%d %H:%i:%s'),
    review_answer_timestamp =
        STR_TO_DATE(NULLIF(TRIM(@answer_date), ''), '%Y-%m-%d %H:%i:%s');


select count(*) from reviews;

