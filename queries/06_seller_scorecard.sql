WITH seller_metrics AS (
    SELECT
        s.seller_id,
        COUNT(DISTINCT oi.order_id) AS total_orders,
        SUM(oi.price) AS total_revenue,
        AVG(oi.price) AS average_order_value,
        MAX(oi.price) AS highest_order_value,
        AVG(JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date)) AS avg_delivery_days,
        AVG(r.review_score) AS avg_review_score
    FROM sellers s
    INNER JOIN order_items oi ON s.seller_id = oi.seller_id
    LEFT JOIN orders o ON oi.order_id = o.order_id
    LEFT JOIN order_reviews r ON o.order_id = r.order_id
    GROUP BY s.seller_id
    HAVING total_orders >= 10
),

ranked AS (
    SELECT
    seller_id,
    total_orders,
    avg_review_score,
    avg_delivery_days,
    RANK() OVER (ORDER BY total_orders DESC) AS order_rank,
    RANK() OVER (ORDER BY avg_delivery_days ASC) AS delivery_rank,
    RANK() OVER (ORDER BY avg_review_score DESC) AS review_rank
FROM seller_metrics
)

SELECT
    seller_id,
    total_orders,
    avg_review_score,
    avg_delivery_days,
    order_rank,
    delivery_rank,
    review_rank,
    CASE
        WHEN order_rank <= 20 AND avg_review_score <= 3.5 THEN 'High Volume, Low Quality'
        WHEN review_rank <= 10 AND total_orders < 50 THEN 'Hidden Gem'
        ELSE 'Standard'
    END AS seller_flag,
    ROUND((order_rank + delivery_rank + review_rank) / 3.0, 1) AS overall_score
FROM ranked
ORDER BY overall_score ASC
LIMIT 20;

