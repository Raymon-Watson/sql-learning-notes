-- ============================================================
-- 04_subqueries_and_ctes.sql
-- PostgreSQL practice: scalar subqueries, derived tables, CTEs,
-- multi-stage analysis, readable query structure.
--
-- Assumed tables/columns:
-- customers(customer_id, customer_name, city, state, signup_date)
-- products(product_id, product_name, category)
-- orders(order_id, customer_id, order_date, order_status)
-- order_items(order_id, product_id, quantity, unit_price,
--             discount_pct, item_total)
-- ============================================================


-- EXERCISE 1
-- Use a subquery to find order-item rows whose unit_price is above
-- the overall average unit_price.

-- TODO:



-- EXERCISE 2
-- First calculate total spending for each customer.
-- Then return the average of those customer totals.
-- Use a subquery in the FROM clause.

-- TODO:



-- EXERCISE 3
-- Rewrite Exercise 2 using a CTE instead of a subquery.

-- TODO:



-- EXERCISE 4
-- Use a CTE to calculate total spending for each customer.
-- Return only customers whose spending is above the average
-- customer spending.
--
-- Hint: this requires more than one logical step.

-- TODO:



-- EXERCISE 5
-- Use a CTE to calculate total value for each order.
-- Then calculate the overall average order value.

-- TODO:



-- EXERCISE 6
-- Use one or more CTEs to produce a customer summary containing:
--   customer_id
--   customer_name
--   number_of_orders
--   total_spent
--   average_order_value
--
-- Keep the query readable by splitting the work into logical stages.

-- TODO:



-- EXERCISE 7
-- Use a CTE to calculate revenue for each product.
-- Then return products whose revenue is above the average
-- product revenue.

-- TODO:



-- EXERCISE 8
-- Use multiple CTEs to calculate:
--   total revenue by category
--   overall total revenue
-- Then return each category and its percentage of total revenue.
--
-- Do not use a window function for this exercise.

-- TODO:



-- EXERCISE 9
-- Use a CTE to find each customer's first order date.
-- Join the result back to customers and return:
--   customer_id
--   customer_name
--   signup_date
--   first_order_date

-- TODO:
