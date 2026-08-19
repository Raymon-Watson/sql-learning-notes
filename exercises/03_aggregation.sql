-- ============================================================
-- 03_aggregation.sql
-- PostgreSQL practice: COUNT, COUNT DISTINCT, SUM, AVG, MIN, MAX,
-- GROUP BY, HAVING, conditional aggregation.
--
-- Assumed tables/columns:
-- customers(customer_id, customer_name, city, state, signup_date)
-- products(product_id, product_name, category)
-- orders(order_id, customer_id, order_date, order_status)
-- order_items(order_id, product_id, quantity, unit_price,
--             discount_pct, item_total)
-- ============================================================


-- EXERCISE 1
-- Return:
--   total number of orders
--   number of distinct customers who placed orders

-- TODO:

SELECT COUNT(order_id), COUNT(DISTINCT customer_id) FROM orders;



-- EXERCISE 2
-- Return total revenue from order_items.
-- Use item_total.

-- TODO:

SELECT SUM(item_total) AS total_revenue FROM order_items;



-- EXERCISE 3
-- Return:
--   total units sold
--   average unit_price
--   minimum unit_price
--   maximum unit_price

-- TODO:

SELECT SUM(quantity),
	ROUND(AVG(unit_price),2),
	MIN(unit_price),
	MAX(unit_price)
FROM order_items;


-- EXERCISE 4
-- Calculate total revenue for each product_id.
-- Sort highest revenue first.

-- TODO:


SELECT product_id, SUM(item_total) AS total_product_rev FROM order_items
GROUP BY product_id
ORDER BY total_product_rev DESC;



-- EXERCISE 5
-- Join order_items to products and calculate total revenue by category.
-- Sort highest revenue first.

-- TODO:
SELECT * FROM order_items;

SELECT products.category, SUM(order_items.item_total) cat_rev FROM order_items
INNER JOIN products
	ON order_items.product_id = products.product_id
GROUP BY products.category
ORDER BY cat_rev DESC;



-- EXERCISE 6
-- Calculate the number of orders placed by each customer_id.
-- Sort from most orders to fewest.

-- TODO:

-- First, let's check that each order only appears once in orders:
SELECT COUNT(order_id), COUNT(DISTINCT order_id)  FROM orders;

SELECT customer_id, COUNT(order_id) AS num_orders FROM orders
	GROUP BY customer_id;


-- EXERCISE 7
-- Return only customers who have placed more than 3 orders.
-- Use GROUP BY and HAVING.

-- TODO:

SELECT customer_id, COUNT(order_id) AS num_orders FROM orders
	GROUP BY customer_id
	HAVING COUNT(order_id) > 3;
-- Note that we cannot use num_orders in HAVING, as it is not defined yet.


-- EXERCISE 8
-- Calculate total revenue by customer.
-- You will need orders and order_items.
-- Sort highest spending customers first.

-- TODO:

-- Note: we actually don't need both, since final_amount
-- is actually contained in orders. But let's do it their
-- way, since it will be good practice.
-- This gives us a method for checking our answer!

SELECT * FROM orders;

-- Easy way first:
SELECT orders.customer_id, SUM(orders.gross_amount) AS cust_rev FROM orders
GROUP BY orders.customer_id
ORDER BY cust_rev DESC;

-- Note, if we used final_total, this would include shipping
-- this is not included in order_items.

-- Hard way next:
SELECT orders.customer_id, SUM(order_items.item_total) AS cust_rev FROM orders
INNER JOIN order_items
	ON orders.order_id = order_items.order_id
GROUP BY orders.customer_id
ORDER BY cust_rev DESC;



-- EXERCISE 9
-- Calculate total revenue by state.
-- You will need customers, orders, and order_items.

-- TODO:

SELECT customers.customer_state, SUM(order_items.item_total) AS revenue FROM customers
INNER JOIN orders
	ON customers.customer_id = orders.customer_id
INNER JOIN order_items
	ON orders.order_id = order_items.order_id
GROUP BY customers.customer_state
ORDER BY revenue DESC;


-- EXERCISE 10
-- Using conditional aggregation, return a single row containing
-- counts for at least three different order_status values.
--
-- Example output shape:
-- completed_orders | cancelled_orders | shipped_orders
--
-- Use the actual status values found in your data.

-- TODO:

-- Check for all types of order_status:
SELECT DISTINCT order_status FROM orders;
SELECT * FROM orders;

SELECT
	SUM( CASE WHEN order_status = 'Delivered' THEN 1
	ELSE 0
	END) AS Delivered_count,
	SUM( CASE WHEN order_status = 'Returned' THEN 1
	ELSE 0
	END) AS Returned_count,
	SUM( CASE WHEN order_status = 'Cancelled' THEN 1
	ELSE 0
	END) AS Cancelled_count
FROM orders;



-- EXERCISE 11
-- Calculate total units sold and total revenue by category.
-- Return only categories whose total revenue is above a threshold
-- of your choice.
-- Use HAVING.

-- TODO:
-- products - category
-- order_items - quantity
-- order_items - item_total

SELECT 
	products.category,
	SUM(order_items.quantity) AS units_sold,
	SUM(order_items.item_total) AS total_revenue
FROM order_items
INNER JOIN products
	ON order_items.product_id = products.product_id
GROUP BY products.product_id
	HAVING SUM(order_items.item_total) > 40000
ORDER BY total_revenue ASC;


