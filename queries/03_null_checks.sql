SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_delivered_customer_date = '' THEN 1 ELSE 0 END) AS missing_delivery_date,
    SUM(CASE WHEN order_estimated_delivery_date = '' THEN 1 ELSE 0 END) AS missing_estimated_delivery_date
FROM orders;

SELECT
    COUNT(*) AS total_reviews,
    SUM(CASE WHEN review_score = '' THEN 1 ELSE 0 END) AS reviews_missing_score,
    SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END) AS reviews_with_null_score
FROM order_reviews;

SELECT
    COUNT(*) AS total_products,
    SUM(CASE WHEN product_category_name = '' THEN 1 ELSE 0 END) AS products_missing_category,
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS products_with_null_category
FROM products;