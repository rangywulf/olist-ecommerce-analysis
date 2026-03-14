SELECT
    t.product_category_name_english,
    ROUND(SUM(o.price), 2)AS total_revenue,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.price) / COUNT(o.order_id), 2) AS avg_order_value
FROM products p
INNER JOIN product_category_translation t ON p.product_category_name = t.product_category_name
INNER JOIN order_items o ON p.product_id = o.product_id
GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 15
