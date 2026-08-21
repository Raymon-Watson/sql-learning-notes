-- ============================================================
-- 05_window_functions.sql
-- PostgreSQL practice: ROW_NUMBER, RANK, LAG, LEAD,
-- SUM OVER, AVG OVER, PARTITION BY, rolling calculations.
--
-- Assumed tables/columns:
-- customers(customer_id, customer_name, city, state, signup_date)
-- products(product_id, product_name, category)
-- orders(order_id, customer_id, order_date, order_status)
-- order_items(order_id, product_id, quantity, unit_price,
--             discount_pct, item_total)
--
-- CTEs are allowed where needed to create the correct grain first.
-- ============================================================


-- EXERCISE 1
-- Calculate total spending per customer.
-- Rank customers from highest to lowest spending using RANK().
-- Return customer_id, total_spent, and spending_rank.

-- TODO:

SELECT * FROM products
LIMIT 10;



-- EXERCISE 2
-- Calculate total revenue per product.
-- Join to products and rank products within each category.
-- Use:
--   RANK() OVER (PARTITION BY ... ORDER BY ...)
--
-- Return category, product_id, product_name, product_revenue,
-- and category_rank.

-- TODO:



-- EXERCISE 3
-- Assign a ROW_NUMBER to each order within each customer,
-- ordered from earliest to latest order_date.
--
-- Return:
--   customer_id
--   order_id
--   order_date
--   order_number

-- TODO:



-- EXERCISE 4
-- Using Exercise 3 as a starting point, return only the first order
-- for each customer.

-- TODO:



-- EXERCISE 5
-- Calculate monthly revenue.
-- Use LAG() to add the previous month's revenue.
--
-- Return:
--   month
--   revenue
--   previous_month_revenue

-- TODO:



-- EXERCISE 6
-- Extend Exercise 5 to calculate month-over-month percentage growth.
-- Be careful with division by zero.

-- TODO:



-- EXERCISE 7
-- Calculate monthly revenue and add cumulative revenue using SUM() OVER.

-- TODO:



-- EXERCISE 8
-- Calculate monthly revenue and add a 3-month rolling average.
-- Use a ROWS window frame covering the current month and
-- the previous two rows.

-- TODO:



-- EXERCISE 9
-- For each customer, use LAG(order_date) to show the previous order date.
-- Also calculate the number of days since the previous order.
--
-- Return:
--   customer_id
--   order_id
--   order_date
--   previous_order_date
--   days_since_previous_order

-- TODO:



-- EXERCISE 10
-- For each customer, use LEAD(order_date) to show the next order date.

-- TODO:
