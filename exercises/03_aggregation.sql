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



-- EXERCISE 2
-- Return total revenue from order_items.
-- Use item_total.

-- TODO:



-- EXERCISE 3
-- Return:
--   total units sold
--   average unit_price
--   minimum unit_price
--   maximum unit_price

-- TODO:



-- EXERCISE 4
-- Calculate total revenue for each product_id.
-- Sort highest revenue first.

-- TODO:



-- EXERCISE 5
-- Join order_items to products and calculate total revenue by category.
-- Sort highest revenue first.

-- TODO:



-- EXERCISE 6
-- Calculate the number of orders placed by each customer_id.
-- Sort from most orders to fewest.

-- TODO:



-- EXERCISE 7
-- Return only customers who have placed more than 3 orders.
-- Use GROUP BY and HAVING.

-- TODO:



-- EXERCISE 8
-- Calculate total revenue by customer.
-- You will need orders and order_items.
-- Sort highest spending customers first.

-- TODO:



-- EXERCISE 9
-- Calculate total revenue by state.
-- You will need customers, orders, and order_items.

-- TODO:



-- EXERCISE 10
-- Using conditional aggregation, return a single row containing
-- counts for at least three different order_status values.
--
-- Example output shape:
-- completed_orders | cancelled_orders | shipped_orders
--
-- Use the actual status values found in your data.

-- TODO:



-- EXERCISE 11
-- Calculate total units sold and total revenue by category.
-- Return only categories whose total revenue is above a threshold
-- of your choice.
-- Use HAVING.

-- TODO:
