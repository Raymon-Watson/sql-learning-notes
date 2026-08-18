-- ============================================================
-- 08_data_create_drop_KEYS.sql
-- PostgreSQL practice: CREATE TABLE, DROP TABLE, data types,
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, composite keys.
--
-- IMPORTANT:
-- Use PRACTICE table names only.
-- Do not drop or alter your real project tables.
--
-- Suggested names:
--   practice_customers
--   practice_products
--   practice_orders
--   practice_order_items
--
-- Fill in all SQL yourself.
-- ============================================================


-- EXERCISE 1
-- Safely remove the four practice tables if they already exist.
-- Because of foreign-key dependencies, think about the correct order
-- in which to drop them.
-- Use DROP TABLE IF EXISTS.

-- TODO:



-- EXERCISE 2
-- Create practice_customers with:
--   customer_id      TEXT primary key
--   customer_name    TEXT not null
--   city             TEXT
--   state            TEXT
--   signup_date      DATE

-- TODO:



-- EXERCISE 3
-- Create practice_products with:
--   product_id       TEXT primary key
--   product_name     TEXT not null
--   category         TEXT
--   unit_price       NUMERIC
--
-- Add a constraint that unit_price cannot be negative.

-- TODO:



-- EXERCISE 4
-- Create practice_orders with:
--   order_id         TEXT primary key
--   customer_id      TEXT not null
--   order_date       DATE not null
--   order_status     TEXT
--
-- Add a foreign key from customer_id to practice_customers(customer_id).

-- TODO:



-- EXERCISE 5
-- Create practice_order_items with:
--   order_id         TEXT
--   product_id       TEXT
--   quantity         INTEGER not null
--   unit_price       NUMERIC not null
--
-- Requirements:
--   foreign key to practice_orders
--   foreign key to practice_products
--   quantity must be greater than 0
--   unit_price must be >= 0
--
-- Use a composite primary key made from:
--   (order_id, product_id)

-- TODO:



-- EXERCISE 6
-- Add a new column called email of type TEXT to practice_customers
-- using ALTER TABLE.

-- TODO:



-- EXERCISE 7
-- Add a UNIQUE constraint to the email column.

-- TODO:



-- EXERCISE 8
-- Remove the email column from practice_customers.

-- TODO:



-- EXERCISE 9
-- Drop all four practice tables again.
-- Drop them in an order that does not violate foreign-key dependencies.

-- TODO:
