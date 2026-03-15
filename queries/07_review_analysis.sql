SELECT
    CASE
        WHEN delivery_delay < 0 THEN 'Early'
        WHEN delivery_delay = 0 THEN 'On Time'
        WHEN delivery_delay BETWEEN 1 AND 3 THEN 'Slightly Late'
        WHEN delivery_delay BETWEEN 4 AND 7 THEN 'Late'
        ELSE 'Very Late'
    END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS avg_score,
    COUNT(*) AS order_count
FROM (
    SELECT
        order_id,
        ROUND(JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date), 1) AS delivery_delay
    FROM orders
    WHERE order_delivered_customer_date != ''
) AS delivery_scores

INNER JOIN order_reviews r ON delivery_scores.order_id = r.order_id
GROUP BY delivery_status
ORDER BY avg_score DESC;

SELECT
    pt.product_category_name_english AS category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date) > 0 THEN 1 ELSE 0 END) AS late_orders,
    ROUND(SUM(CASE WHEN JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date) > 0 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS pct_late,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_translation pt ON p.product_category_name = pt.product_category_name
WHERE o.order_delivered_customer_date != ''
GROUP BY category
HAVING total_orders >= 50
ORDER BY avg_review_score ASC;    