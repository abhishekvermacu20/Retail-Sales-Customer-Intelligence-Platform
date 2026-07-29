-- Module 3: Customer Analysis
-- Query 17: Customers by State - which state has most customers
SELECT CUSTOMER_STATE, COUNT(DISTINCT(CUSTOMER_UNIQUE_ID)) AS TOTAL_CUSTOMERS
FROM CUSTOMERS
GROUP BY CUSTOMER_STATE
ORDER BY TOTAL_CUSTOMERS DESC;
-- iDENTIFIY MY BIGEST CUSTOMER'S MARKET - SP

-- Query 18: Top 10 Cities - TOP 10 CUSTOMERS
SELECT CUSTOMER_CITY, COUNT(DISTINCT(CUSTOMER_UNIQUE_ID)) TOTAL_CUSTOMERS
FROM CUSTOMERS
GROUP BY CUSTOMER_CITY
ORDER BY TOTAL_CUSTOMERS DESC;

-- Query 19: Repeat vs One-Time Customers - How many customers purchased more than once?

SELECT SUMARRY, COUNT(*) TOTAL_CUSTOMERS
FROM
(SELECT C.CUSTOMER_UNIQUE_ID,
	CASE
		WHEN COUNT(O.ORDER_ID)=1 THEN 'ONE TIME CUSTOMER'
        ELSE 'REPEAT CUSTOMER'
	END AS SUMARRY
FROM CUSTOMERS C
JOIN ORDERS O
ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_UNIQUE_ID) T
GROUP BY SUMARRY
ORDER BY TOTAL_CUSTOMERS DESC;
-- ONE TIME CUSTOMER	93099
-- REPEAT CUSTOMER	2997


-- Query 20: Average Orders per Customer
SELECT
    ROUND(AVG(total_orders),2) AS avg_orders_per_customer
FROM
(
    SELECT
        customer_unique_id,
        COUNT(order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY customer_unique_id
) AS customer_orders;

-- Query 21: Top 10 Customers by Number of Orders
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;

-- Query 22: Top 10 Customers by Spending
SELECT
    c.customer_unique_id,
    ROUND(SUM(p.payment_value),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

-- Query 23: Customer Distribution by State
SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS total_customers,
    ROUND(
        COUNT(DISTINCT customer_unique_id) * 100.0 /
        (
            SELECT COUNT(DISTINCT customer_unique_id)
            FROM customers
        ),
        2
    ) AS percentage
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;



