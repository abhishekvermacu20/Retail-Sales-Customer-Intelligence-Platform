USE retail_sales_db;
-- Module 4: Product Analysis
-- Query 24: Top 10 Selling Product Categories (by Revenue)
SELECT P.product_category_NAME AS CATEGORY, PCT.product_category_NAME_ENGLISH AS ENG_CATEGORY, ROUND(SUM(OI.PRICE),2) AS REVENUE
FROM ORDER_ITEMS OI
JOIN PRODUCTS P
ON OI.PRODUCT_ID = P.PRODUCT_ID
JOIN product_category_translation PCT
ON PCT.product_category_NAME = P.product_category_NAME
GROUP BY P.product_category_NAME
ORDER BY REVENUE DESC;

-- Query 25: Top 10 Categories by Number of Products Sold
SELECT PCT.product_category_name_ENGLISH, COUNT(P.PRODUCT_ID) NUMBER_OF_PRODUCT_SOLD
FROM products P
JOIN ORDER_ITEMS OI
ON P.PRODUCT_ID = OI.PRODUCT_ID
JOIN product_category_translation PCT
ON PCT.product_category_name = P.product_category_name
GROUP BY P.product_category_name
ORDER BY NUMBER_OF_PRODUCT_SOLD DESC;

-- Query 26: Top 10 Most Expensive Products
SELECT PRODUCT_ID, MAX(PRICE) AS Expensive_Products
FROM ORDER_ITEMS
GROUP BY PRODUCT_ID
ORDER BY Expensive_Products DESC
LIMIT 10;

-- Query 27: Average Product Price by Category
SELECT P.product_category_NAME AS CATEGORY, PCT.product_category_NAME_ENGLISH AS ENG_CATEGORY, ROUND(AVG(OI.PRICE),2) AS AVG_REVENUE
FROM ORDER_ITEMS OI
JOIN PRODUCTS P
ON OI.PRODUCT_ID = P.PRODUCT_ID
JOIN product_category_translation PCT
ON PCT.product_category_NAME = P.product_category_NAME
GROUP BY P.product_category_NAME
ORDER BY AVG_REVENUE DESC;

-- Query 28: Top 10 Products Sold
SELECT PRODUCT_ID, COUNT(*) AS TOTAL_SOLD
FROM ORDER_ITEMS
GROUP BY PRODUCT_ID
ORDER BY TOTAL_SOLD DESC;

-- Query 29: Average Freight Cost by Category
SELECT PCT.product_category_NAME_ENGLISH AS ENG_CATEGORY, ROUND(AVG(OI.freight_value),2) AS freight_value_AVG
FROM ORDER_ITEMS OI
JOIN PRODUCTS P
ON OI.PRODUCT_ID = P.PRODUCT_ID
JOIN product_category_translation PCT
ON PCT.product_category_NAME = P.product_category_NAME
GROUP BY P.product_category_NAME
ORDER BY freight_value_AVG DESC;

-- Query 30: Product Category Distribution
SELECT ct.product_category_name_english AS category, COUNT(*) AS total_products
FROM products p
JOIN PRODUCT_category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_products DESC;
