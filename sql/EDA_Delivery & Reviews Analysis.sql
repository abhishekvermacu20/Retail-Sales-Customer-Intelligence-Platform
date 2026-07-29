-- Module 6: Delivery & Reviews Analysis
-- Query 36: Average Delivery Time
SELECT
    ROUND(
        AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)),
        2
    ) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Query 37: Average Delay Against Estimated Delivery - On average, how many days early or late are orders delivered?
SELECT
    ROUND(
        AVG(DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)),
        2
    ) AS avg_delay_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Query 38: On-Time vs Late Deliveries - How many orders were delivered on time versus late?
SELECT
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;

-- Query 39: Average Delivery Time by State - Which states experience the fastest and slowest deliveries?
SELECT
    c.customer_state,
    ROUND(
        AVG(DATEDIFF(o.order_delivered_customer_date,
                     o.order_purchase_timestamp)),
        2
    ) AS avg_delivery_days
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days;

-- Query 40: Review Score Distribution - How are customers rating their orders?
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

-- Query 41: Average Review Score
SELECT
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM reviews;

-- Query 42: Average Review Score by Product Category - 
SELECT
    ct.product_category_name_english AS category,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM reviews r
JOIN orders o
    ON r.order_id = o.order_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY avg_review_score DESC;

-- Query 43: Does Delivery Delay Affect Reviews? - Do late deliveries receive lower review scores?
SELECT
    CASE
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
            THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;

-- Expected Insight
-- Typically, on-time deliveries receive higher review scores, while late deliveries receive lower scores. This helps evaluate the impact of logistics on customer satisfaction.