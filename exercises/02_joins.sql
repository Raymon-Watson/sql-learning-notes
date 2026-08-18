-- ============================================================
-- 02_joins.sql
-- PostgreSQL practice: INNER JOIN, LEFT JOIN, multi-table joins,
-- join keys, and understanding row duplication.
--
-- Assumed tables/columns:
-- customers(customer_id, customer_name, city, state, signup_date)
-- products(product_id, product_name, category)
-- orders(order_id, customer_id, order_date, order_status)
-- order_items(order_id, product_id, quantity, unit_price,
--             discount_pct, item_total)
-- ============================================================


-- EXERCISE 1
-- INNER JOIN orders to customers.
-- Return:
--   order_id
--   order_date
--   customer_id
--   customer_name
--   city

-- TODO:

-- First, check both tables to see what to join on
SELECT * FROM orders
LIMIT 10;

SELECT * FROM customers
LIMIT 10;
-- Will be INNER JOINing on customer_id

SELECT orders.order_id, 
	orders.order_date, 
	orders.customer_id, 
	customers.customer_name, 
	customers.city 
FROM orders
INNER JOIN customers
	ON orders.customer_id = customers.customer_id;


-- EXERCISE 2
-- INNER JOIN order_items to products.
-- Return:
--   order_id
--   product_id
--   product_name
--   category
--   quantity
--   unit_price
--   item_total

-- TODO:

-- Check what we are joining on
SELECT * FROM order_items
LIMIT 10;

SELECT * FROM products
LIMIT 10;
-- Joining on product_id

SELECT order_items.order_id,
	order_items.product_id,
	products.product_name,
	products.category,
	order_items.quantity,
	order_items.unit_price,
	order_items.item_total
FROM order_items
INNER JOIN products
	ON order_items.product_id = products.product_id;


-- EXERCISE 3
-- Join orders, customers, order_items, and products.
-- Return one row per order-item row with:
--   order_id
--   order_date
--   customer_name
--   city
--   product_name
--   category
--   quantity
--   item_total

-- TODO:

SELECT * FROM orders
LIMIT 10;

SELECT order_items.order_id,
	orders.order_date,
	customers.customer_name,
	customers.city,
	products.product_name,
	products.category,
	order_items.quantity,
	order_items.item_total
FROM order_items
INNER JOIN products
	ON order_items.product_id = products.product_id
INNER JOIN orders
	ON order_items.order_id = orders.order_id
INNER JOIN customers
	ON orders.customer_id = customers.customer_id;



-- EXERCISE 4
-- Use a LEFT JOIN to find customers who have never placed an order.
-- Return customer_id and customer_name.

-- TODO:

SELECT customers.customer_id, customers.customer_name FROM customers
LEFT JOIN orders
	ON customers.customer_id = orders.customer_id
WHERE order_id IS NULL;



-- EXERCISE 5
-- Use a LEFT JOIN to return every customer together with any orders
-- they may have placed.
-- Return:
--   customer_id
--   customer_name
--   order_id
--   order_date
-- Keep customers with no orders in the result.

-- TODO:

SELECT customers.customer_id,
	customers.customer_name,
	orders.order_id,
	orders.order_date
FROM customers
LEFT JOIN orders
	ON customers.customer_id = orders.customer_id
ORDER BY customers.customer_name;
	



-- EXERCISE 6
-- Join orders to order_items.
-- Count:
--   a) the total number of joined rows
--   b) the number of distinct order_ids
-- Put both counts in the same result.
--
-- Purpose: observe why joining a one-to-many relationship can
-- increase the number of rows.

-- TODO:

SELECT COUNT(*), COUNT(DISTINCT orders.order_id) FROM orders
LEFT JOIN order_items
	ON orders.order_id = order_items.order_id;



-- EXERCISE 7
-- Join customers -> orders -> order_items.
-- Count the number of DISTINCT customers represented in the joined data.
-- Then compare this result with COUNT(*) from the same join.

-- TODO:

SELECT COUNT(DISTINCT customers.customer_id), COUNT(*) FROM customers
INNER JOIN orders
	ON customers.customer_id = orders.customer_id
INNER JOIN order_items
	ON orders.order_id = order_items.order_id;




-- EXERCISE 8
-- Join products to order_items with a LEFT JOIN.
-- Find products that have never appeared in an order.
-- Return product_id and product_name.

-- TODO:

SELECT products.product_id, products.product_name
FROM products
LEFT JOIN order_items
	ON products.product_id = order_items.product_id
WHERE order_items.product_id IS NULL;

-- Note: we use the joined key as it is more consistent when
-- checking for missing data on a match.


-- EXERCISE 9
-- Join all four core tables and return only rows for customers
-- from one state of your choice and one product category of your choice.
-- Return sensible identifying columns from each table.

-- TODO:
SELECT * FROM orders;

SELECT customers.customer_state,
	products.category,
	orders.final_amount,
	order_items.quantity
FROM customers
INNER JOIN orders
	ON customers.customer_id = orders.customer_id
INNER JOIN order_items
	ON orders.order_id = order_items.order_id
INNER JOIN products
	ON order_items.product_id = products.product_id
WHERE customers.customer_state = 'Tamil Nadu'
	AND products.category = 'Serum';

