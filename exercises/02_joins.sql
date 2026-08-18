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



-- EXERCISE 4
-- Use a LEFT JOIN to find customers who have never placed an order.
-- Return customer_id and customer_name.

-- TODO:



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



-- EXERCISE 7
-- Join customers -> orders -> order_items.
-- Count the number of DISTINCT customers represented in the joined data.
-- Then compare this result with COUNT(*) from the same join.

-- TODO:



-- EXERCISE 8
-- Join products to order_items with a LEFT JOIN.
-- Find products that have never appeared in an order.
-- Return product_id and product_name.

-- TODO:



-- EXERCISE 9
-- Join all four core tables and return only rows for customers
-- from one state of your choice and one product category of your choice.
-- Return sensible identifying columns from each table.

-- TODO:
