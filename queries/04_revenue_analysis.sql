SELECT
    t.product_category_name_english,
    ROUND(SUM(o.price), 2)AS total_revenue,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.price) / COUNT(o.order_id), 2) AS avg_order_value
FROM products p
INNER JOIN product_category_translation t ON p.product_category_name = t.product_category_name
INNER JOIN order_items o ON p.product_id = o.product_id
GROUP BY t.product_category_name_english
ORDER BY total_revenue ASC
LIMIT 10;

SELECT
    STRFTIME('%Y-%m', o.order_purchase_timestamp) AS month,
    ROUND(SUM(i.price), 2) AS total_revenue
FROM order_items i
INNER JOIN orders o ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month ASC;