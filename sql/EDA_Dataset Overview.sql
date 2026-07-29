-- Module 1 — Dataset Overview

-- Query 1: Total Customers
SELECT COUNT(*) AS Total_customers
FROM customers;
-- Total Customers : 99441

-- Query 2: Unique Customers
SELECT COUNT(DISTINCT customer_unique_id) AS Unique_customers
FROM customers;
-- Total Unique Customers : 96096

-- Query 3: Total Orders
SELECT COUNT(*) AS Total_Orders
FROM ORDERS;

-- Query 4: Order Status Distribution - How many orders are delivered, canceled, shipped, etc.?
SELECT order_status,COUNT(*) AS Total_Orders
FROM orders
GROUP BY order_status
ORDER BY Total_Orders DESC;
/*
'delivered', '96478'
'shipped', '1107'
'canceled', '625'
'unavailable', '609'
'invoiced', '314'
'processing', '301'
'created', '5'
'approved', '2'
*/

-- Query 5: Total Sellers
SELECT COUNT(*) AS Total_Sellers
FROM sellers;
-- 3095

-- Query 6: Total Products
SELECT COUNT(*) AS Total_Products
FROM products;
-- 32973

-- Query 7: Total Reviews
SELECT COUNT(*) AS Total_Reviews
FROM reviews;

-- Query 8: Total Revenue
SELECT ROUND(SUM(payment_value),2) AS Total_Revenue
FROM payments;
-- '16008872.12'






