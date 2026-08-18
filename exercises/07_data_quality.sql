-- ============================================================
-- 07_data_quality.sql
-- PostgreSQL practice: practical checks before analysis.
--
-- Assumed tables/columns:
-- customers(customer_id, customer_name, city, state, signup_date)
-- products(product_id, product_name, category)
-- orders(order_id, customer_id, order_date, order_status)
-- order_items(order_id, product_id, quantity, unit_price,
--             discount_pct, item_total)
--
-- Do not modify data in this file. Only investigate it.
-- ============================================================


-- EXERCISE 1
-- Return the row count of each of the four core tables.
-- You may use four separate queries.

-- TODO:



-- EXERCISE 2
-- Check whether customer_id is duplicated in customers.
-- Return only duplicated IDs and their counts.

-- TODO:



-- EXERCISE 3
-- Check whether order_id is duplicated in orders.

-- TODO:



-- EXERCISE 4
-- Check whether product_id is duplicated in products.

-- TODO:



-- EXERCISE 5
-- Check critical columns for NULL values.
-- At minimum investigate:
--   customers.customer_id
--   orders.order_id
--   orders.customer_id
--   orders.order_date
--   order_items.order_id
--   order_items.product_id
--   order_items.quantity
--   order_items.unit_price
--
-- You may use several queries or one conditional-aggregation query.

-- TODO:



-- EXERCISE 6
-- Find order-item rows where:
--   quantity <= 0
--   OR unit_price < 0
--   OR item_total < 0

-- TODO:



-- EXERCISE 7
-- Find discount_pct values outside the expected percentage range
-- of 0 to 100.

-- TODO:



-- EXERCISE 8
-- Find orders whose customer_id does not exist in customers.
-- Use LEFT JOIN.

-- TODO:



-- EXERCISE 9
-- Find order_items whose order_id does not exist in orders.
-- Use LEFT JOIN.

-- TODO:



-- EXERCISE 10
-- Find order_items whose product_id does not exist in products.
-- Use LEFT JOIN.

-- TODO:



-- EXERCISE 11
-- Inspect the minimum and maximum:
--   order_date
--   signup_date
-- Look for dates that seem impossible or outside the expected period.

-- TODO:



-- EXERCISE 12
-- Look for category values that may be duplicates caused by
-- differences in capitalization or whitespace.
--
-- Hint: compare the original category with a normalized version
-- using TRIM() and LOWER(), then count rows by normalized category.

-- TODO:



-- EXERCISE 13
-- Check whether item_total agrees with your expected calculation from:
--   quantity
--   unit_price
--   discount_pct
--
-- First decide from the dataset documentation how discount_pct is stored.
-- Return rows where the stored and calculated totals differ materially.

-- TODO:
