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



-- EXERCISE 2
-- Return customer_id, customer_name, city, and state.
-- Rename customer_name as name in the output.

-- TODO:



-- EXERCISE 3
-- Return all customers who live in one specific state of your choice.
-- Sort by city, then customer_name.

-- TODO:



-- EXERCISE 4
-- Return all customers who live in either of two states of your choice.
-- Use IN rather than several OR conditions.

-- TODO:



-- EXERCISE 5
-- Return products belonging to one category of your choice.
-- Sort them alphabetically by product_name.

-- TODO:



-- EXERCISE 6
-- Return order items with unit_price between two values of your choice.
-- Sort from highest to lowest unit_price.

-- TODO:



-- EXERCISE 7
-- Find orders whose order_status is not one status of your choice.
-- Return order_id, customer_id, order_date, and order_status.

-- TODO:



-- EXERCISE 8
-- Return the distinct product categories in products.
-- Sort them alphabetically.

-- TODO:



-- EXERCISE 9
-- Find customer rows where city is NULL.

-- TODO:



-- EXERCISE 10
-- Find products whose product_name contains a word or letter sequence
-- of your choice, ignoring case.
-- Use ILIKE.

-- TODO:



-- EXERCISE 11
-- Create a price_band column for order_items using CASE:
--   unit_price < 20       -> 'Low'
--   unit_price < 50       -> 'Medium'
--   otherwise             -> 'High'
-- Return product_id, unit_price, and price_band.

-- TODO:



-- EXERCISE 12
-- Return the 10 most expensive order-item rows.
-- Show product_id, unit_price, quantity, and item_total.

-- TODO:
