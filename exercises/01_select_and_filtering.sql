-- ============================================================
-- 01_select_and_filtering.sql
-- PostgreSQL practice: SELECT, filtering, sorting, aliases,
-- DISTINCT, NULL, CASE, IN, BETWEEN, LIKE/ILIKE, LIMIT
--
-- Assumed tables/columns:
-- customers(customer_id, customer_name, city, state, signup_date)
-- products(product_id, product_name, category)
-- orders(order_id, customer_id, order_date, order_status)
-- order_items(order_id, product_id, quantity, unit_price,
--             discount_pct, item_total)
--
-- Fill in SQL only underneath each -- TODO.
-- No solutions are included.
-- ============================================================


-- EXERCISE 1
-- Return every column from customers.
-- Show only the first 10 rows.

-- TODO:

SELECT * FROM customers
LIMIT 10;



-- EXERCISE 2
-- Return customer_id, customer_name, city, and state.
-- Rename customer_name as name in the output.

-- TODO:

SELECT customer_id, customer_name AS name, city, customer_state FROM customers;



-- EXERCISE 3
-- Return all customers who live in one specific state of your choice.
-- Sort by city, then customer_name.

-- TODO:

SELECT * FROM customers
	WHERE customer_state = 'Haryana' -- NOTE: needs single quote, double quote means column name.
	ORDER BY city, customer_name;




-- EXERCISE 4
-- Return all customers who live in either of two states of your choice.
-- Use IN rather than several OR conditions.

-- TODO:

SELECT * FROM customers
	WHERE customer_state IN ('Haryana','Tamil Nadu');



-- EXERCISE 5
-- Return products belonging to one category of your choice.
-- Sort them alphabetically by product_name.

-- TODO:

-- First check all the different categories
SELECT DISTINCT category FROM products;
-- Then select one
SELECT * FROM products
	WHERE category = 'Moisturizer'
	ORDER BY product_name ASC;



-- EXERCISE 6
-- Return order items with unit_price between two values of your choice.
-- Sort from highest to lowest unit_price.

-- TODO:

-- First find min/max prices
SELECT MIN(cost_price), MAX(cost_price) FROM products;
-- Then choose range
SELECT * FROM products
	WHERE cost_price BETWEEN 120 AND 250
	ORDER BY cost_price DESC;
	



-- EXERCISE 7
-- Find orders whose order_status is not one status of your choice.
-- Return order_id, customer_id, order_date, and order_status.

-- TODO:

-- First, look at the structure of orders
SELECT * FROM orders
LIMIT 10;
-- Then look at the order status options
SELECT DISTINCT order_status FROM orders;
-- Choose one: Cancelled
SELECT order_id, customer_id, order_date, order_status FROM orders
	WHERE order_status NOT IN ('cancelled');

-- Another way of doing the same thing:
SELECT order_id, customer_id, order_date, order_status FROM orders
	WHERE order_status != 'cancelled';


-- EXERCISE 8
-- Return the distinct product categories in products.
-- Sort them alphabetically.

-- TODO:

-- First look at products to remind ourselves of labels
SELECT * FROM products
LIMIT 10;
-- Then select distinct product categories, sorting alphabetically:
SELECT DISTINCT category FROM products
ORDER BY category ASC;



-- EXERCISE 9
-- Find customer rows where city is NULL.

-- TODO:
SELECT * FROM customers
WHERE city IS NULL;



-- EXERCISE 10
-- Find products whose product_name contains a word or letter sequence
-- of your choice, ignoring case.
-- Use ILIKE.

-- TODO:

SELECT * FROM products
LIMIT 10;

SELECT * FROM products
	WHERE product_name ILIKE 'serum';
-- NOTE: ILIKE is case insensitive, LIKE is case sensitive


-- EXERCISE 11
-- Create a price_band column for order_items using CASE:
--   unit_price < 20       -> 'Low'
--   unit_price < 50       -> 'Medium'
--   otherwise             -> 'High'
-- Return product_id, unit_price, and price_band.

-- TODO:
SELECT * FROM products;

SELECT product_id, cost_price,
CASE
	WHEN cost_price < 150 THEN 'Low'
	WHEN cost_price BETWEEN 150 AND 300 THEN 'Medium'
	ELSE 'High'
END AS price_band
FROM products;

-- EXERCISE 12
-- Return the 10 most expensive order-item rows.
-- Show product_id, unit_price, quantity, and item_total.

-- TODO:

SELECT product_id, unit_price, quantity, item_total FROM order_items
ORDER BY item_total DESC
LIMIT 10;
