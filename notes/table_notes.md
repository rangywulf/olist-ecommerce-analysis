# Olist Table Notes

## Orders
| Column | Type | Notes |
|--------|------|-------|
| order_id | ANY | Unique identifier |
| customer_id | ANY | Links to customers table |
| order_status | ANY | delivered, cancelled, etc. |
| order_purchase_timestamp | ANY | Date of purchase |
| order_approved_at | ANY | Date payment approved |
| order_delivered_carrier_date | ANY | Date handed to carrier |
| order_delivered_customer_date | ANY | Date received by customer |
| order_estimated_delivery_date | ANY | Estimated delivery date |

**Key notes:**
- No primary key set (SQLite CSV import quirk)
- order_id is the effective unique identifier
- 5 date columns — critical for Phase 3 delivery analysis

---

## Order Items
| Column | Type | Notes |
|--------|------|-------|
| order_id | ANY | Links to orders table |
| order_item_id | ANY | Numbers items within an order (1, 2, 3...) |
| product_id | ANY | Links to products table |
| seller_id | ANY | Links to sellers table |
| shipping_limit_date | ANY | Deadline for seller to ship |
| price | ANY | Item price — revenue lives here |
| freight_value | ANY | Shipping cost |

**Key notes:**
- No single primary key — order_id + order_item_id together uniquely identify each row
- price column is what we SUM for revenue analysis in Phase 2

---

## Order Payments
| Column | Type | Notes |
|--------|------|-------|
| order_id | ANY | Links to orders table |
| payment_sequential | ANY | Numbers multiple payment methods on one order |
| payment_type | ANY | Credit card, boleto, voucher, etc. |
| payment_installments | ANY | Number of installments payment was split into |
| payment_value | ANY | Amount paid |

**Key notes:**
- One order can have multiple payment rows if paid with multiple methods
- payment_installments is interesting for Phase 5 — do installment buyers spend more?

---

## Order Reviews
| Column | Type | Notes |
|--------|------|-------|
| review_id | ANY | Unique identifier for the review |
| order_id | ANY | Links to orders table |
| review_score | ANY | Star rating 1-5 — key column for Phase 5 |
| review_comment_title | ANY | Short title written by customer |
| review_comment_message | ANY | Full written review |
| review_creation_date | ANY | When customer was invited to review |
| review_answer_timestamp | ANY | When customer submitted the review |

**Key notes:**
- review_score is the most important column — used heavily in Phase 5
- review_comment_title and review_comment_message likely have many nulls
- Most customers leave a score but skip the written review

---

## Customers
| Column | Type | Notes |
|--------|------|-------|
| customer_id | ANY | Links to orders table — not unique per person |
| customer_unique_id | ANY | Truly unique customer identifier |
| customer_zip_code_prefix | ANY | Links to geolocation table |
| customer_city | ANY | Customer city |
| customer_state | ANY | Customer state abbreviation |

**Key notes:**
- customer_id is per order, NOT per person
- customer_unique_id is the real unique identifier per customer
- Use customer_unique_id when counting repeat buyers in Phase 4
- customer_state is key for the delivery heatmap in Phase 3

---

## Sellers
| Column | Type | Notes |
|--------|------|-------|
| seller_id | ANY | Unique identifier — links to order_items table |
| seller_zip_code_prefix | ANY | Links to geolocation table |
| seller_city | ANY | City seller is based in |
| seller_state | ANY | State seller is based in |

**Key notes:**
- Only 3,095 sellers in the dataset
- No performance data here — that gets built by joining with orders and reviews in Phase 4
- seller_state useful for comparing delivery performance by seller location

---

## Products
| Column | Type | Notes |
|--------|------|-------|
| product_id | ANY | Unique identifier — links to order_items table |
| product_category_name | ANY | Category in Portuguese — links to translation table |
| product_name_lenght | ANY | Character count of product name — NOTE TYPO |
| product_description_lenght | ANY | Character count of description — NOTE TYPO |
| product_photos_qty | ANY | Number of listing photos |
| product_weight_g | ANY | Weight in grams |
| product_length_cm | ANY | Package length |
| product_height_cm | ANY | Package height |
| product_width_cm | ANY | Package width |

**Key notes:**
- product_category_name is in Portuguese — must join with product_category_translation to get English names
- "lenght" is a typo in the original dataset — use exactly as written in queries
- Physical dimensions could be interesting for correlating weight/size with shipping delays

---

## Product Category Translation
| Column | Type | Notes |
|--------|------|-------|
| product_category_name | ANY | Portuguese category name — links to products table |
| product_category_name_english | ANY | English translation |

**Key notes:**
- Lookup table only — 71 rows, one per category
- Always join this when displaying category names so results are readable
- Remember this table imported as product_category_translation not product_category_name_translation

---

## Geolocation
| Column | Type | Notes |
|--------|------|-------|
| geolocation_zip_code_prefix | ANY | Links to customers and sellers tables |
| geolocation_lat | ANY | Latitude coordinate |
| geolocation_lng | ANY | Longitude coordinate |
| geolocation_city | ANY | City name |
| geolocation_state | ANY | State abbreviation |

**Key notes:**
- Over 1 million rows — largest table in the dataset
- Multiple coordinate entries per zip code — be careful with joins or you'll get duplicates
- Used for mapping in Tableau during Phase 6

---