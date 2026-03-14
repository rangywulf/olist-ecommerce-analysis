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