-- ============================================================
-- 06_dates_and_strings.sql
-- PostgreSQL practice: DATE_TRUNC, EXTRACT, date arithmetic,
-- UPPER, LOWER, TRIM, LENGTH, CONCAT, LIKE/ILIKE.
--
-- Assumed tables/columns:
-- customers(customer_id, customer_name, city, state, signup_date)
-- products(product_id, product_name, category)
-- orders(order_id, customer_id, order_date, order_status)
-- order_items(order_id, product_id, quantity, unit_price,
--             discount_pct, item_total)
-- ============================================================


-- EXERCISE 1
-- Return order_id, order_date, order year, and order month number.
-- Use EXTRACT().

-- TODO:



-- EXERCISE 2
-- Group orders by calendar month using DATE_TRUNC().
-- Return month and number_of_orders.

-- TODO:



-- EXERCISE 3
-- Calculate monthly revenue.
-- Use DATE_TRUNC() and join orders to order_items.

-- TODO:



-- EXERCISE 4
-- Return customers who signed up within a date range of your choice.
-- Use BETWEEN or >= / <= with DATE values.

-- TODO:



-- EXERCISE 5
-- Return customer_name in:
--   original form
--   UPPERCASE
--   lowercase

-- TODO:



-- EXERCISE 6
-- Return product_name and the number of characters in the name.
-- Sort longest names first.

-- TODO:



-- EXERCISE 7
-- Return customer_id and a display label built from
-- customer_name, city, and state using CONCAT() or ||.
--
-- Example shape:
-- "Alex Smith - Brisbane, QLD"

-- TODO:



-- EXERCISE 8
-- Find products whose product_name contains a search term of your choice,
-- regardless of upper/lower case.
-- Use ILIKE.

-- TODO:



-- EXERCISE 9
-- Use TRIM() on customer_name and compare the original and trimmed
-- string lengths.
-- Return rows where the lengths differ.
--
-- Purpose: identify leading/trailing whitespace.

-- TODO:



-- EXERCISE 10
-- Calculate the number of days between each customer's signup_date
-- and their first order_date.
--
-- You may use a CTE or subquery to find first_order_date.

-- TODO:
