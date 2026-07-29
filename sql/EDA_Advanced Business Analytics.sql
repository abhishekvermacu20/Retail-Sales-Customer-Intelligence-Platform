-- Module 7 – Advanced Business Analytics
-- Query 44: Monthly Revenue Trend - Query 44: Monthly Revenue Trend
SELECT DATE_FORMAT(ORDER_PURCHASE_TIMESTAMP,'%Y-%M') AS MONTHS, SUM(PAYMENT_VALUE) AS REVENUE
FROM ORDERS AS O
JOIN PAYMENTS AS P
ON O.ORDER_ID = P.ORDER_ID
GROUP BY MONTHS
ORDER BY REVENUE DESC;

-- Query 45: Monthly Order Trend
SELECT DATE_FORMAT(order_purchase_timestamp,'%Y-%M') AS MONTHS, COUNT(*) AS Total_Orders
FROM ORDERS
GROUP BY MONTHS
ORDER BY Total_Orders DESC;

-- Query 46: Revenue by State
SELECT C.CUSTOMER_STATE AS STATES, SUM(P.payment_value) AS REVENUE
FROM CUSTOMERS AS C
JOIN ORDERS AS O
ON O.CUSTOMER_ID = C.CUSTOMER_ID
JOIN PAYMENTS AS P
ON O.ORDER_ID = P.ORDER_ID
GROUP BY STATES
ORDER BY REVENUE DESC;

-- Query 47: Average Order Value (AOV)

SELECT AVG(ORDER_TOTAL)
FROM
(SELECT ORDER_ID, SUM(payment_value) AS ORDER_TOTAL
FROM PAYMENTS
GROUP BY ORDER_ID) T;

-- Query 48: Top 10 Customers by Revenue
SELECT
    c.customer_unique_id,
    ROUND(SUM(p.payment_value), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

-- Query 49: Revenue by Payment Type
SELECT
    payment_type,
    ROUND(SUM(payment_value), 2) AS revenue
FROM payments
GROUP BY payment_type
ORDER BY revenue DESC;

-- Query 50: Average Installments by Payment Type
SELECT
    payment_type,
    ROUND(AVG(payment_installments), 2) AS avg_installments
FROM payments
GROUP BY payment_type;

-- Query 51: Cancellation Rate
SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage
FROM orders
GROUP BY order_status;

-- Query 52: Customer Lifetime Value (CLV)
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value), 2) AS lifetime_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY lifetime_value DESC;

-- Query 53: Top Performing Seller by Revenue
SELECT
    seller_id,
    ROUND(SUM(price), 2) AS revenue
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC
LIMIT 10;

