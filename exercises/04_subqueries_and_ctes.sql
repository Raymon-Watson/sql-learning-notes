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

-- First, calculate the average price
SELECT AVG(unit_price) FROM order_items;

-- Then, use it in a subquery

SELECT * FROM order_items
WHERE unit_price > (
SELECT AVG(unit_price) FROM order_items
)
ORDER BY unit_price ASC;



-- EXERCISE 2
-- First calculate total spending for each customer.
-- Then return the average of those customer totals.
-- Use a subquery in the FROM clause.

-- TODO:

SELECT AVG(customer_spending) FROM
(SELECT customer_id, SUM(final_amount) AS customer_spending FROM orders
GROUP BY customer_id) AS customer_totals;



-- EXERCISE 3
-- Rewrite Exercise 2 using a CTE instead of a subquery.

-- TODO:


WITH customer_totals AS (
SELECT SUM(final_amount) AS customer_spending FROM orders
GROUP BY customer_id
)
SELECT AVG(customer_spending) FROM customer_totals;

-- EXERCISE 4
-- Use a CTE to calculate total spending for each customer.
-- Return only customers whose spending is above the average
-- customer spending.
--
-- Hint: this requires more than one logical step.

-- TODO:

SELECT * FROM orders;

WITH customer_total_spend AS (
	SELECT customer_id, SUM(final_amount) AS total_spend
	FROM orders
	GROUP BY customer_id
),
customer_avg_spend AS (
	SELECT AVG(total_spend) AS avg_val FROM customer_total_spend
)
SELECT * FROM customer_total_spend
WHERE total_spend > ( SELECT * FROM customer_avg_spend);

-- Note: can do this simpler without second CTE
WITH customer_total_spend AS (
	SELECT customer_id, SUM(final_amount) AS total_spend
	FROM orders
	GROUP BY customer_id
)
SELECT * FROM customer_total_spend
WHERE total_spend > ( SELECT AVG(total_spend) FROM customer_total_spend);


-- EXERCISE 5
-- Use a CTE to calculate total value for each order.
-- Then calculate the overall average order value.

-- TODO:

WITH order_total AS (
	SELECT order_id, gross_amount AS order_gross_total FROM orders
	GROUP BY order_id
)
SELECT AVG(order_gross_total) FROM order_total;


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

WITH collated_orders AS (
	SELECT order_id,
	SUM(item_total) AS order_total
	FROM order_items
	GROUP BY order_id
),
customer_collation AS (
SELECT customer_id,
SUM(order_total) AS tot_order, 
ROUND(AVG(order_total),2) AS avg_order,
COUNT(order_total) AS num_orders
FROM collated_orders
INNER JOIN orders
	ON collated_orders.order_id = orders.order_id
GROUP BY orders.customer_id)
SELECT customers.customer_id,
customers.customer_name,
customer_collation.tot_order,
customer_collation.avg_order,
customer_collation.num_orders
FROM customer_collation
INNER JOIN customers
	ON customer_collation.customer_id = customers.customer_id;








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
 