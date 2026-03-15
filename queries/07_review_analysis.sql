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
ORDER BY avg_score DESC
