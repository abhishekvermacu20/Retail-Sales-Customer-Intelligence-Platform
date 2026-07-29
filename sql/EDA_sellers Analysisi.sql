-- Module 5: Seller Analysis
USE RETAIL_SALES_DB;
-- Query 31: Top 10 Sellers by Revenue
SELECT SELLER_ID, SUM(PRICE) AS REVENUE
FROM ORDER_ITEMS
GROUP BY SELLER_ID
ORDER BY REVENUE DESC
LIMIT 10;

-- Query 32: Top 10 Sellers by Products Sold
SELECT SELLER_ID, COUNT(PRODUCT_ID) AS PRODUCT_SOLD
FROM ORDER_ITEMS 
GROUP BY SELLER_ID
ORDER BY PRODUCT_SOLD DESC;

-- Query 33: Sellers by State
SELECT
    seller_state,
    COUNT(seller_id) AS total_sellers
FROM sellers
GROUP BY seller_state
ORDER BY total_sellers DESC;

-- Query 34: Average Revenue per Seller
SELECT
    ROUND(AVG(seller_revenue), 2) AS avg_revenue_per_seller
FROM
(
    SELECT
        seller_id,
        SUM(price) AS seller_revenue
    FROM order_items
    GROUP BY seller_id
) AS seller_summary;

-- Query 35: Sellers with Highest Average Freight
SELECT
    seller_id,
    ROUND(AVG(freight_value), 2) AS avg_freight
FROM order_items
GROUP BY seller_id
ORDER BY avg_freight DESC
LIMIT 10;





