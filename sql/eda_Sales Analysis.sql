-- Module 2: Sales Analysis
-- Query 9: Monthly Order Trend - How many orders were placed each month?
SELECT DATE_FORMAT(order_purchase_timestamp,'%Y-%m') AS Order_Month, COUNT(order_id)
FROM ORDERS
GROUP BY DATE_FORMAT(order_purchase_timestamp,'%Y-%m')
ORDER BY Order_Month DESC;

-- Query 10: Monthly Revenue - How much revenue was generated each month?
SELECT 
DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS MONTHS, ROUND(SUM(p.payment_value),2) AS TOTAL_REVENUE
FROM orders AS o
JOIN payments AS p
ON o.order_id = p.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') 
ORDER BY MONTHS DESC;

-- Query 11: Yearly Revenue
SELECT
YEAR(o.order_purchase_timestamp) AS MONTHS, ROUND(SUM(p.payment_value),2) AS TOTAL_REVENUE
FROM orders AS o
JOIN payments AS p
ON o.order_id = p.order_id
GROUP BY YEAR(o.order_purchase_timestamp) 
ORDER BY MONTHS DESC;

-- Query 12: Average Order Value (AOV) - On average, how much does a customer spend per order?
SELECT AVG(ORDER_TOTAL) AS AOV
FROM
(SELECT ORDER_ID, SUM(PAYMENT_VALUE) AS ORDER_TOTAL
FROM PAYMENTS
GROUP BY ORDER_ID) T;

-- Query 13: Highest Revenue Month
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY revenue DESC
LIMIT 1;

-- Query 14: Lowest Revenue Month
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(p.payment_value),2) AS revenue
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY revenue asc
LIMIT 1;

-- Query 15: Average Products per Order - How many products does a customer buy in one order on average?
SELECT * FROM ORDER_ITEMS;

SELECT AVG(NUMBER_OF_ORDERS)
FROM
(SELECT ORDER_ID, COUNT(ORDER_ITEM_ID) AS NUMBER_OF_ORDERS
FROM ORDER_ITEMS
GROUP BY ORDER_ID
ORDER BY NUMBER_OF_ORDERS DESC) T;

-- Query 16: Average Freight Cost
SELECT
    ROUND(AVG(freight_value),2) AS average_freight
FROM order_items;

