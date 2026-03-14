SELECT
    order_id,
    order_estimated_delivery_date,
    order_delivered_customer_date,
    ROUND(JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date), 1) AS delivery_delay
FROM orders
WHERE order_delivered_customer_date != ''
LIMIT 20;

SELECT
    COUNT(*) AS total_delivered,
    SUM(CASE WHEN ROUND(JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date), 1) > 0 THEN 1 ELSE 0 END) AS late_orders,
    ROUND(SUM(CASE WHEN ROUND(JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date), 1) > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS late_pct
FROM orders
WHERE order_delivered_customer_date != '';

SELECT
    c.customer_state,
    COUNT(*) AS total_orders,
    ROUND(AVG(JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date)), 1) AS avg_delivery_days
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;

SELECT
    oi.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date)), 1) AS avg_delivery_days,
    SUM(CASE WHEN ROUND(JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date), 1) > 0 THEN 1 ELSE 0 END) AS late_orders
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN sellers s ON oi.seller_id = s.seller_id
WHERE o.order_delivered_customer_date != ''
GROUP BY oi.seller_id
HAVING total_orders >= 10
ORDER BY avg_delivery_days DESC
LIMIT 20;