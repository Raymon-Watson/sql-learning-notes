-- ============================================================
-- Customer Orders Example
-- Purpose:
-- Demonstrate table creation, inserting data, joins,
-- aggregation, filtering and sorting in PostgreSQL.
-- ============================================================


-- 1. Remove the tables if they already exist.
-- Orders must be removed first because it references customers.

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;


-- 2. Create a customer table.
-- One row represents one customer.

CREATE TABLE customers (
    customer_id integer PRIMARY KEY,
    customer_name varchar(100) NOT NULL,
    city varchar(100)
);


-- 3. Create an orders table.
-- One row represents one order.

CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    customer_id integer NOT NULL,
    order_date date NOT NULL,
    order_value numeric(10, 2) NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- 4. Add some sample customers.

INSERT INTO customers (
    customer_id,
    customer_name,
    city
)
VALUES
    (1, 'Aisha Khan', 'Brisbane'),
    (2, 'Daniel Lee', 'Gold Coast'),
    (3, 'Maria Silva', 'Brisbane'),
    (4, 'James Brown', 'Toowoomba');


-- 5. Add some sample orders.

INSERT INTO orders (
    order_id,
    customer_id,
    order_date,
    order_value
)
VALUES
    (101, 1, '2026-07-01', 120.00),
    (102, 1, '2026-07-14', 80.50),
    (103, 2, '2026-07-09', 250.00),
    (104, 3, '2026-07-18', 60.00),
    (105, 3, '2026-07-25', 140.00);


-- 6. View all customers.

SELECT *
FROM customers
ORDER BY customer_id;


-- 7. Join customers to their orders.

SELECT
    c.customer_name,
    c.city,
    o.order_date,
    o.order_value
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY o.order_date;


-- 8. Calculate total spending by customer.

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS number_of_orders,
    COALESCE(SUM(o.order_value), 0) AS total_spending
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spending DESC;


-- 9. Find customers whose total spending exceeds $150.

SELECT
    c.customer_name,
    SUM(o.order_value) AS total_spending
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.order_value) > 150
ORDER BY total_spending DESC;


-- 10. Find customers who have not placed an order.

SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
