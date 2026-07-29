-- Module 8: SQL Views
-- View 1: Monthly Sales Summary
DROP VIEW vw_monthly_sales;
CREATE VIEW vw_monthly_sales AS
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value),2) AS total_revenue,
    ROUND(AVG(p.payment_value),2) AS average_payment
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY sales_month;

SELECT *
FROM vw_monthly_sales;

-- View 2: Customer Summary:
CREATE VIEW vw_customer_summary AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value),2) AS total_spent,
    ROUND(AVG(p.payment_value),2) AS average_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id;

SELECT *
FROM vw_customer_summary
ORDER BY total_spent DESC;

-- View 3: Seller Summary
CREATE VIEW vw_seller_summary AS
SELECT
    oi.seller_id,
    COUNT(oi.order_id) AS total_orders,
    COUNT(oi.product_id) AS products_sold,
    ROUND(SUM(oi.price),2) AS revenue,
    ROUND(AVG(oi.freight_value),2) AS average_freight
FROM order_items oi
GROUP BY oi.seller_id;

SELECT *
FROM vw_seller_summary
ORDER BY revenue DESC;

-- View 4: Product Performance
CREATE VIEW vw_product_performance AS
SELECT
    ct.product_category_name_english AS category,
    COUNT(oi.product_id) AS products_sold,
    ROUND(SUM(oi.price),2) AS revenue,
    ROUND(AVG(oi.price),2) AS average_price
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN product_category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english;

SELECT *
FROM vw_product_performance
ORDER BY revenue DESC;

-- View 5: Delivery Performance
CREATE VIEW vw_delivery_performance AS
SELECT
    order_id,
    order_status,
    DATEDIFF(order_delivered_customer_date,
             order_purchase_timestamp) AS delivery_days,
    DATEDIFF(order_delivered_customer_date,
             order_estimated_delivery_date) AS delay_days,
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

SELECT *
FROM vw_delivery_performance;

-- View 6: Review Summary
CREATE VIEW vw_review_summary AS
SELECT
    ct.product_category_name_english AS category,
    ROUND(AVG(r.review_score),2) AS average_review,
    COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN orders o
ON r.order_id = o.order_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
JOIN product_category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english;

SELECT *
FROM vw_review_summary
ORDER BY average_review DESC;

-- View 7: State-wise Revenue
CREATE VIEW vw_state_revenue AS
SELECT
    c.customer_state,
    ROUND(SUM(p.payment_value),2) AS revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state;

-- View 8: Payment Summary
CREATE VIEW vw_payment_summary AS
SELECT
    payment_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(payment_value),2) AS revenue,
    ROUND(AVG(payment_installments),2) AS average_installments
FROM payments
GROUP BY payment_type;

-- View 9: Customer Lifetime Value (CLV)
CREATE VIEW vw_customer_clv AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value),2) AS lifetime_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id;

-- View 10: Executive Dashboard Summary
CREATE VIEW vw_executive_summary AS
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers,
    COUNT(DISTINCT oi.seller_id) AS total_sellers,
    ROUND(SUM(p.payment_value),2) AS total_revenue,
    ROUND(AVG(p.payment_value),2) AS average_payment
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN payments p
ON o.order_id = p.order_id
JOIN order_items oi
ON o.order_id = oi.order_id;

-- HOw to see all View:
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';
