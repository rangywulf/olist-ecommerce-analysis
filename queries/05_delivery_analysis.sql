SELECT
    order_id,
    order_estimated_delivery_date,
    order_delivered_customer_date,
    ROUND(JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_estimated_delivery_date), 1) AS delivery_delay
FROM orders
WHERE order_delivered_customer_date != ''
LIMIT 20;