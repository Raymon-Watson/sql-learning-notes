
# SQL Cheat Sheet — Beginner Data Analysis with PostgreSQL

This cheat sheet covers the SQL concepts you should know at your current stage for beginner data-analysis projects in PostgreSQL.

It focuses on:

- querying data
- filtering and sorting
- aggregate functions
- grouping
- joins
- dates
- `CASE`
- `NULL`
- subqueries
- CTEs
- window functions
- basic table design
- primary and foreign keys
- importing data
- common mistakes
- useful analysis patterns

It intentionally leaves out advanced database administration, query optimization, stored procedures, recursive CTEs, triggers, and other topics that are not important yet.

---

# 1. Basic SQL Query Structure

The most basic query is:

```sql
SELECT column_name
FROM table_name;
```

Example:

```sql
SELECT customer_name
FROM customers;
```

To select multiple columns:

```sql
SELECT customer_id, customer_name, city
FROM customers;
```

To select every column:

```sql
SELECT *
FROM customers;
```

Use `SELECT *` for quick exploration, but for finished analysis it is usually better to name the columns you actually need.

---

# 2. `SELECT DISTINCT`

Use `DISTINCT` to return only unique values.

```sql
SELECT DISTINCT city
FROM customers;
```

Without `DISTINCT`, the same city may appear many times.

You can also use it across multiple columns:

```sql
SELECT DISTINCT city, country
FROM customers;
```

SQL then returns unique combinations of `city` and `country`.

---

# 3. Column Aliases with `AS`

Use `AS` to give a column a clearer temporary name in the output.

```sql
SELECT
    customer_name AS name,
    city AS customer_city
FROM customers;
```

Aliases are especially useful for calculations:

```sql
SELECT
    quantity * price AS revenue
FROM orders;
```

The alias only exists for the result of that query. It does not rename the actual database column.

---

# 4. Filtering Rows with `WHERE`

Use `WHERE` to keep only rows that meet a condition.

```sql
SELECT *
FROM customers
WHERE country = 'United States';
```

Common comparison operators:

```text
=    equal to
<>   not equal to
!=   not equal to
>    greater than
<    less than
>=   greater than or equal to
<=   less than or equal to
```

Example:

```sql
SELECT *
FROM products
WHERE price > 100;
```

Use `=` rather than `IS` for normal comparisons.

Correct:

```sql
WHERE country = 'United States'
```

Not normally:

```sql
WHERE country IS 'United States'
```

`IS` is mainly used for things such as `NULL`.

---

# 5. Combining Conditions: `AND`, `OR`, `NOT`

## `AND`

Both conditions must be true.

```sql
SELECT *
FROM products
WHERE category = 'Technology'
  AND price > 100;
```

## `OR`

At least one condition must be true.

```sql
SELECT *
FROM customers
WHERE city = 'Brisbane'
   OR city = 'Sydney';
```

## `NOT`

Reverses a condition.

```sql
SELECT *
FROM products
WHERE NOT category = 'Furniture';
```

When mixing `AND` and `OR`, use parentheses to make your intention clear:

```sql
SELECT *
FROM products
WHERE category = 'Technology'
  AND (price > 100 OR quantity > 5);
```

---

# 6. `IN`

Use `IN` when checking whether a value matches one of several possibilities.

Instead of:

```sql
WHERE city = 'Brisbane'
   OR city = 'Sydney'
   OR city = 'Melbourne'
```

use:

```sql
WHERE city IN ('Brisbane', 'Sydney', 'Melbourne')
```

You can also use `NOT IN`:

```sql
WHERE city NOT IN ('Brisbane', 'Sydney')
```

---

# 7. `BETWEEN`

Use `BETWEEN` for inclusive ranges.

```sql
SELECT *
FROM products
WHERE price BETWEEN 50 AND 100;
```

This includes both `50` and `100`.

Equivalent to:

```sql
WHERE price >= 50
  AND price <= 100
```

It also works with dates:

```sql
WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31'
```

For timestamp columns, explicit lower/upper bounds are often safer than `BETWEEN`.

---

# 8. Pattern Matching with `LIKE`

Use `LIKE` to search text patterns.

```sql
SELECT *
FROM customers
WHERE customer_name LIKE 'A%';
```

Wildcards:

```text
%   any number of characters
_   exactly one character
```

Examples:

```sql
WHERE customer_name LIKE 'A%'
```

Starts with `A`.

```sql
WHERE customer_name LIKE '%son'
```

Ends with `son`.

```sql
WHERE customer_name LIKE '%tech%'
```

Contains `tech`.

In PostgreSQL, `ILIKE` performs case-insensitive matching:

```sql
WHERE customer_name ILIKE '%smith%'
```

---

# 9. Sorting with `ORDER BY`

Use `ORDER BY` to sort results.

Ascending:

```sql
SELECT *
FROM products
ORDER BY price ASC;
```

Descending:

```sql
SELECT *
FROM products
ORDER BY price DESC;
```

`ASC` is the default.

You can sort by multiple columns:

```sql
SELECT *
FROM customers
ORDER BY city ASC, customer_name ASC;
```

You can also sort by an alias:

```sql
SELECT
    product_id,
    quantity * price AS revenue
FROM orders
ORDER BY revenue DESC;
```

---

# 10. Limiting Results

In PostgreSQL, use `LIMIT`.

```sql
SELECT *
FROM products
ORDER BY price DESC
LIMIT 10;
```

This is useful for questions such as:

> What are the 10 most expensive products?

---

# 11. Basic Calculations

SQL can perform arithmetic:

```text
+   addition
-   subtraction
*   multiplication
/   division
```

Example:

```sql
SELECT
    quantity,
    price,
    quantity * price AS revenue
FROM orders;
```

Use parentheses where needed:

```sql
SELECT
    price,
    discount,
    price * (1 - discount) AS discounted_price
FROM products;
```

---

# 12. Aggregate Functions

Aggregate functions summarize multiple rows.

The main ones you need are:

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

## `COUNT`

```sql
SELECT COUNT(*)
FROM orders;
```

Counts rows.

```sql
SELECT COUNT(customer_id)
FROM orders;
```

Counts non-`NULL` values in `customer_id`.

## `SUM`

```sql
SELECT SUM(quantity)
FROM orders;
```

## `AVG`

```sql
SELECT AVG(price)
FROM products;
```

## `MIN`

```sql
SELECT MIN(price)
FROM products;
```

## `MAX`

```sql
SELECT MAX(price)
FROM products;
```

---

# 13. `GROUP BY`

Use `GROUP BY` when you want one result per category/group.

Example:

```sql
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city;
```

This gives one row per city.

Another example:

```sql
SELECT
    category,
    AVG(price) AS avg_price
FROM products
GROUP BY category;
```

A useful way to think about it:

```text
Raw rows
   ↓
GROUP BY category
   ↓
One row per category
```

If a selected column is not inside an aggregate function, it normally must appear in the `GROUP BY`.

Correct:

```sql
SELECT
    city,
    COUNT(*)
FROM customers
GROUP BY city;
```

---

# 14. `HAVING`

`WHERE` filters individual rows.

`HAVING` filters groups created by `GROUP BY`.

Example:

```sql
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) > 10;
```

This means:

> Group customers by city, then keep only cities with more than 10 customers.

Remember:

```text
WHERE  → filters rows before grouping
HAVING → filters groups after grouping
```

---

# 15. SQL's Logical Query Order

You normally write a query in this order:

```sql
SELECT
FROM
JOIN
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
```

But conceptually SQL evaluates roughly:

```text
FROM / JOIN
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
LIMIT
```

This helps explain why some aliases cannot be used in `WHERE`.

For example, this usually does not work:

```sql
SELECT
    quantity * price AS revenue
FROM orders
WHERE revenue > 100;
```

because `WHERE` is processed before the `SELECT` alias is created.

A CTE or subquery can solve this.

---

# 16. Joins

Joins combine related rows from different tables.

Suppose:

```text
customers
---------
customer_id
customer_name
city

orders
------
order_id
customer_id
product_id
quantity

products
--------
product_id
product_name
price
```

---

# 17. `INNER JOIN`

An `INNER JOIN` keeps only rows that match in both tables.

```sql
SELECT
    orders.order_id,
    customers.customer_name
FROM orders
INNER JOIN customers
    ON orders.customer_id = customers.customer_id;
```

`JOIN` by itself usually means `INNER JOIN`:

```sql
SELECT ...
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id;
```

---

# 18. Joining More Than Two Tables

You can join several tables in one query.

Example:

```sql
SELECT
    customers.customer_name,
    products.product_name,
    orders.quantity,
    products.price
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id
JOIN products
    ON orders.product_id = products.product_id;
```

Each join needs its own matching condition.

---

# 19. Table Aliases

Aliases make joins easier to read.

Instead of:

```sql
SELECT
    customers.customer_name,
    products.product_name
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id
JOIN products
    ON orders.product_id = products.product_id;
```

you can write:

```sql
SELECT
    c.customer_name,
    p.product_name
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products AS p
    ON o.product_id = p.product_id;
```

Common style:

```text
customers → c
orders    → o
products  → p
```

---

# 20. `LEFT JOIN`

A `LEFT JOIN` keeps every row from the left table, even if there is no match on the right.

```sql
SELECT
    c.customer_name,
    o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

Customers without an order still appear.

Their order columns will contain `NULL`.

This is useful for finding missing relationships.

Example:

```sql
SELECT
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

This finds customers who have never ordered anything.

For your current stage, focus mainly on:

```text
INNER JOIN
LEFT JOIN
```

You do not need to spend much time on `RIGHT JOIN` or `FULL OUTER JOIN` yet.

---

# 21. Revenue Across Joined Tables

A very common pattern:

```sql
SELECT
    c.city,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY c.city
ORDER BY total_revenue DESC;
```

This combines:

- joins
- calculations
- aggregation
- grouping
- sorting

This is typical beginner data-analysis SQL.

---

# 22. `NULL`

`NULL` means a value is missing or unknown.

Do not test for it with:

```sql
= NULL
```

Instead use:

```sql
IS NULL
```

Example:

```sql
SELECT *
FROM customers
WHERE phone_number IS NULL;
```

To find non-missing values:

```sql
WHERE phone_number IS NOT NULL
```

---

# 23. `COALESCE`

`COALESCE` replaces `NULL` with another value.

```sql
SELECT
    customer_name,
    COALESCE(phone_number, 'Not provided') AS phone
FROM customers;
```

For numeric data:

```sql
SELECT
    COALESCE(discount, 0) AS discount
FROM orders;
```

---

# 24. `CASE`

`CASE` lets you create categories or conditional values.

Basic structure:

```sql
CASE
    WHEN condition THEN result
    WHEN condition THEN result
    ELSE result
END
```

Example:

```sql
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 500 THEN 'Expensive'
        WHEN price >= 100 THEN 'Medium'
        ELSE 'Cheap'
    END AS price_category
FROM products;
```

This is useful for creating categories during analysis.

---

# 25. Dates in PostgreSQL

A date column should normally use a date/time type rather than text.

Common types:

```text
DATE        date only
TIMESTAMP   date and time
```

Example date:

```text
2026-08-18
```

Example timestamp:

```text
2026-08-18 14:30:00
```

If a column contains only a year, an integer is often perfectly reasonable:

```sql
year INT
```

Although `year` is not usually a major problem in PostgreSQL, names such as:

```text
order_year
release_year
sales_year
```

are often clearer.

---

# 26. Extracting Parts of a Date

Use `EXTRACT`.

Example:

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year
FROM orders;
```

Month:

```sql
SELECT
    EXTRACT(MONTH FROM order_date) AS order_month
FROM orders;
```

Day:

```sql
SELECT
    EXTRACT(DAY FROM order_date) AS order_day
FROM orders;
```

---

# 27. Revenue by Month

Example:

```sql
SELECT
    EXTRACT(MONTH FROM o.order_date) AS order_month,
    SUM(o.quantity * p.price) AS monthly_revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY order_month
ORDER BY order_month;
```

If your data spans multiple years, include the year too:

```sql
SELECT
    EXTRACT(YEAR FROM o.order_date) AS order_year,
    EXTRACT(MONTH FROM o.order_date) AS order_month,
    SUM(o.quantity * p.price) AS monthly_revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
```

---

# 28. `DATE_TRUNC`

For PostgreSQL, `DATE_TRUNC` is very useful for time-based analysis.

Monthly:

```sql
SELECT
    DATE_TRUNC('month', order_date) AS month
FROM orders;
```

You can combine it with aggregation:

```sql
SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.quantity * p.price) AS revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY month
ORDER BY month;
```

This is often easier than separately extracting year and month.

---

# 29. Subqueries

A subquery is a query inside another query.

Use one when you need to:

> calculate something first, then use that result in another calculation.

Example:

```sql
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

The inner query calculates the average price.

The outer query finds products above that average.

---

# 30. Subquery in `WHERE`

A common pattern:

```sql
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

Use operators such as:

```text
=
>
<
>=
<=
```

when the subquery returns one value.

---

# 31. Subquery with `IN`

If the subquery returns several values, `IN` is often appropriate.

```sql
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);
```

Think:

```text
One value       → =, >, <, etc.
Several values  → IN
```

---

# 32. Subquery in `FROM`

A subquery can act like an intermediate table.

Example: average spending per customer.

```sql
SELECT AVG(customer_spend)
FROM (
    SELECT
        o.customer_id,
        SUM(o.quantity * p.price) AS customer_spend
    FROM orders AS o
    JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
) AS customer_totals;
```

Conceptually:

```text
orders
  ↓
total spending per customer
  ↓
average customer spending
```

A subquery in `FROM` should be given an alias:

```sql
) AS customer_totals;
```

---

# 33. Why Subqueries Help with Aggregation

Suppose you want:

> the average amount spent per customer.

There are two levels:

```text
individual orders
      ↓
SUM per customer
      ↓
AVG across customers
```

You generally cannot just write:

```sql
AVG(SUM(...))
```

at the same query level.

Instead, use a subquery or CTE.

---

# 34. CTEs

CTE stands for:

> Common Table Expression

A CTE creates a named intermediate query result.

Basic syntax:

```sql
WITH cte_name AS (
    SELECT ...
)

SELECT ...
FROM cte_name;
```

Example:

```sql
WITH customer_totals AS (
    SELECT
        o.customer_id,
        SUM(o.quantity * p.price) AS customer_spend
    FROM orders AS o
    JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
)

SELECT *
FROM customer_totals;
```

Think of the CTE as:

> create an intermediate result called `customer_totals`, then query it.

---

# 35. CTEs Are Temporary Query Results

A CTE does not permanently create a database table.

This works:

```sql
WITH customer_totals AS (
    ...
)

SELECT *
FROM customer_totals;
```

But after that statement finishes, this will not work by itself:

```sql
SELECT *
FROM customer_totals;
```

---

# 36. Subquery vs CTE

Use a subquery when the logic is short:

```sql
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

Use a CTE when the analysis is easier to understand in stages:

```sql
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(...) AS total_spent
    FROM ...
    GROUP BY customer_id
)

SELECT *
FROM customer_spending;
```

A useful rule:

```text
Simple calculation  → subquery
Multi-step analysis → CTE
```

---

# 37. Multiple CTEs

You can define more than one CTE.

```sql
WITH first_cte AS (
    ...
),

second_cte AS (
    ...
)

SELECT *
FROM second_cte;
```

A later CTE can use an earlier one.

Example:

```sql
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY customer_id
),

large_customers AS (
    SELECT *
    FROM customer_totals
    WHERE total_quantity > 10
)

SELECT *
FROM large_customers;
```

Use this when your analysis naturally has several stages.

---

# 38. Very Useful CTE + Subquery Pattern

Find customers whose total spending is above the average customer:

```sql
WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(o.quantity * p.price) AS total_spent
    FROM orders AS o
    JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
)

SELECT *
FROM customer_spending
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
)
ORDER BY total_spent DESC;
```

This is a very useful analytical pattern.

---

# 39. Window Functions

A window function performs a calculation across multiple rows **without collapsing those rows**.

This is the main difference from `GROUP BY`.

`GROUP BY`:

```text
many customer rows
      ↓
one row per city
```

Window function:

```text
keep each customer row
+
add a city-level calculation
```

---

# 40. Basic Window Function Syntax

A window function uses:

```sql
FUNCTION(column) OVER (...)
```

Example:

```sql
AVG(total_spent) OVER ()
```

`OVER()` tells SQL to calculate the aggregate as a window function while keeping the original rows.

---

# 41. `OVER()`

An empty window:

```sql
AVG(total_spent) OVER ()
```

means:

> calculate the average across all rows.

Example:

```sql
SELECT
    customer_id,
    total_spent,
    AVG(total_spent) OVER () AS overall_average
FROM customer_spending;
```

Every row remains in the output.

---

# 42. `PARTITION BY`

Use `PARTITION BY` to calculate separately within groups.

```sql
SELECT
    customer_id,
    city,
    total_spent,
    AVG(total_spent) OVER (
        PARTITION BY city
    ) AS city_average
FROM customer_spending;
```

This calculates a separate average for each city without removing the individual customer rows.

Think:

```text
GROUP BY       → groups rows and collapses them
PARTITION BY   → groups rows for a window calculation but keeps them
```

---

# 43. `ROW_NUMBER()`

`ROW_NUMBER()` numbers rows.

```sql
SELECT
    customer_id,
    total_spent,
    ROW_NUMBER() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_spending;
```

Highest spender gets `1`, next gets `2`, and so on.

---

# 44. Ranking Within Groups

Use `PARTITION BY` with `ROW_NUMBER()` to restart the ranking for each group.

```sql
SELECT
    customer_id,
    city,
    total_spent,
    ROW_NUMBER() OVER (
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS city_rank
FROM customer_spending;
```

Useful for:

- highest-spending customer in each city
- top three products in each category
- highest-revenue salesperson in each region

---

# 45. `ROW_NUMBER`, `RANK`, and `DENSE_RANK`

You only need the basic distinction.

Suppose values are:

```text
800
500
500
300
```

`ROW_NUMBER()`:

```text
800 → 1
500 → 2
500 → 3
300 → 4
```

`RANK()`:

```text
800 → 1
500 → 2
500 → 2
300 → 4
```

`DENSE_RANK()`:

```text
800 → 1
500 → 2
500 → 2
300 → 3
```

Remember:

```text
ROW_NUMBER → every row gets a unique number
RANK       → ties share a rank and leave gaps
DENSE_RANK → ties share a rank without gaps
```

---

# 46. Running Totals

A common use of window functions is a running total.

```sql
SELECT
    order_date,
    revenue,
    SUM(revenue) OVER (
        ORDER BY order_date
    ) AS running_revenue
FROM daily_sales;
```

Conceptually:

```text
100  → 100
150  → 250
200  → 450
```

---

# 47. Filtering Window Function Results

You normally cannot use a window-function alias directly in `WHERE`.

This usually does not work:

```sql
SELECT
    customer_id,
    ROW_NUMBER() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_spending
WHERE spending_rank <= 5;
```

Instead, use a CTE:

```sql
WITH ranked_customers AS (
    SELECT
        customer_id,
        total_spent,
        ROW_NUMBER() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank
    FROM customer_spending
)

SELECT *
FROM ranked_customers
WHERE spending_rank <= 5;
```

This is an important pattern.

---

# 48. Top N Per Group

A very useful window-function pattern:

```sql
WITH ranked_products AS (
    SELECT
        product_id,
        category,
        revenue,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS category_rank
    FROM product_sales
)

SELECT *
FROM ranked_products
WHERE category_rank <= 3;
```

This finds the top three products in each category.

---

# 49. Basic Data Types

The main PostgreSQL data types you need at this stage are:

## Integers

```sql
INT
```

For whole numbers:

```text
customer_id
quantity
year
```

## Decimal numbers

```sql
NUMERIC
```

or:

```sql
DECIMAL
```

Useful for exact values such as money.

Example:

```sql
price NUMERIC(10, 2)
```

## Floating-point numbers

```sql
REAL
DOUBLE PRECISION
```

Useful where approximate decimal values are acceptable.

## Text

```sql
TEXT
```

or:

```sql
VARCHAR(n)
```

For beginner projects, `TEXT` is often perfectly fine.

## Dates

```sql
DATE
TIMESTAMP
```

## Boolean

```sql
BOOLEAN
```

Values:

```text
TRUE
FALSE
```

---

# 50. Creating a Table

Basic example:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name TEXT,
    city TEXT,
    country TEXT
);
```

Another table:

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price NUMERIC(10, 2)
);
```

Orders:

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE
);
```

---

# 51. Primary Keys

A primary key uniquely identifies each row.

Example:

```sql
customer_id INT PRIMARY KEY
```

A primary key must be unique.

Example:

```text
customer_id
-----------
1
2
3
4
```

You should not have two customers with the same `customer_id`.

---

# 52. Foreign Keys

A foreign key connects one table to another.

Example:

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
```

This establishes:

```text
orders.customer_id
       ↓
customers.customer_id
```

and:

```text
orders.product_id
       ↓
products.product_id
```

A table can have multiple foreign keys.

---

# 53. Primary Key vs Foreign Key

Think:

```text
Primary key
→ uniquely identifies a row in its own table

Foreign key
→ points to a row in another table
```

Example:

```text
customers.customer_id  ← primary key

orders.customer_id     ← foreign key
```

---

# 54. Basic Normalization Idea

You only need the basic concept at this stage.

Instead of repeating customer information in every order:

```text
order_id | customer_name | customer_city | product_name | price
```

split the data into related tables:

```text
customers
orders
products
```

and connect them using IDs.

This avoids unnecessary repetition and makes updates more reliable.

You do not need to memorize detailed normalization forms yet.

---

# 55. Dropping a Table

Delete a table:

```sql
DROP TABLE customers;
```

Safer:

```sql
DROP TABLE IF EXISTS customers;
```

This avoids an error if the table does not exist.

If PostgreSQL prints:

```text
NOTICE: table "customers" does not exist, skipping
```

after `DROP TABLE IF EXISTS`, this is normal.

---

# 56. Importing CSV Data

For beginner PostgreSQL projects, a common workflow is:

1. Create your table with the correct columns and data types.
2. Import the CSV using pgAdmin's Import/Export tool.
3. Check the imported data with a query.

Example:

```sql
SELECT *
FROM orders
LIMIT 10;
```

You can also check row count:

```sql
SELECT COUNT(*)
FROM orders;
```

For portfolio projects, it is fine to explain the import steps in the README rather than putting the CSV import itself into `setup.sql`.

---

# 57. CSV Import Problems

A common error is:

```text
unterminated CSV quoted field
```

This usually means the CSV contains a broken quoted value, such as an opening quotation mark without a valid closing quotation mark.

For beginner projects, if a dataset has severe formatting/import problems, choosing a cleaner dataset is often more sensible than spending a large amount of time manually repairing it.

---

# 58. Useful File Structure for a Beginner SQL Project

A simple project structure:

```text
project-name/
│
├── README.md
├── data/
│   └── dataset.csv
│
├── sql/
│   ├── setup.sql
│   ├── exploration.sql
│   └── analysis.sql
│
└── results/
```

## `setup.sql`

Contains table creation:

```sql
CREATE TABLE ...
```

and constraints where appropriate.

## `exploration.sql`

Contains basic checks such as:

```sql
SELECT *
FROM table_name
LIMIT 10;

SELECT COUNT(*)
FROM table_name;

SELECT DISTINCT category
FROM table_name;
```

## `analysis.sql`

Contains the actual business/data questions you answer.

Examples:

```text
Revenue by city
Revenue by month
Top products
Average customer spending
Customers above average spending
```

---

# 59. Useful Exploratory Queries

Inspect data:

```sql
SELECT *
FROM table_name
LIMIT 10;
```

Count rows:

```sql
SELECT COUNT(*)
FROM table_name;
```

Find unique categories:

```sql
SELECT DISTINCT category
FROM products;
```

Check missing values:

```sql
SELECT COUNT(*)
FROM customers
WHERE city IS NULL;
```

Check minimum and maximum:

```sql
SELECT
    MIN(price),
    MAX(price)
FROM products;
```

Check average:

```sql
SELECT AVG(price)
FROM products;
```

---

# 60. Common Analysis Patterns

## Total revenue

```sql
SELECT
    SUM(o.quantity * p.price) AS total_revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id;
```

## Revenue per city

```sql
SELECT
    c.city,
    SUM(o.quantity * p.price) AS revenue
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY c.city
ORDER BY revenue DESC;
```

## Revenue per month

```sql
SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.quantity * p.price) AS revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY month
ORDER BY month;
```

## Spending per customer

```sql
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;
```

## Average spending per customer

```sql
SELECT AVG(customer_spend) AS avg_customer_spend
FROM (
    SELECT
        o.customer_id,
        SUM(o.quantity * p.price) AS customer_spend
    FROM orders AS o
    JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
) AS customer_totals;
```

## Customers spending above average

```sql
WITH customer_spending AS (
    SELECT
        o.customer_id,
        SUM(o.quantity * p.price) AS total_spent
    FROM orders AS o
    JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
)

SELECT *
FROM customer_spending
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
)
ORDER BY total_spent DESC;
```

---

# 61. Common Beginner Mistakes

## Using `IS` instead of `=`

Wrong:

```sql
WHERE country IS 'Australia'
```

Correct:

```sql
WHERE country = 'Australia'
```

Use `IS` for:

```sql
IS NULL
IS NOT NULL
```

---

## Forgetting `GROUP BY`

Wrong:

```sql
SELECT
    city,
    SUM(revenue)
FROM sales;
```

Correct:

```sql
SELECT
    city,
    SUM(revenue)
FROM sales
GROUP BY city;
```

---

## Using `WHERE` with an aggregate

Wrong:

```sql
SELECT
    city,
    COUNT(*)
FROM customers
GROUP BY city
WHERE COUNT(*) > 10;
```

Correct:

```sql
SELECT
    city,
    COUNT(*)
FROM customers
GROUP BY city
HAVING COUNT(*) > 10;
```

---

## Joining without an `ON` condition

Be careful with:

```sql
FROM customers
JOIN orders
```

without:

```sql
ON customers.customer_id = orders.customer_id
```

This can produce many incorrect combinations of rows.

---

## Forgetting that joins can duplicate rows

If one customer has five orders, joining `customers` to `orders` can produce five rows for that customer.

This is expected.

Always think about what **one row represents** after a join.

---

## Filtering on a `SELECT` alias in `WHERE`

This usually does not work:

```sql
SELECT
    quantity * price AS revenue
FROM orders
WHERE revenue > 100;
```

Use the original calculation, a subquery, or a CTE.

---

## Using `=` with a subquery returning many rows

This is only valid if the subquery returns one value:

```sql
WHERE price > (
    SELECT AVG(price)
    FROM products
)
```

If it returns several values, use something such as `IN`.

---

# 62. A Good Way to Build Queries

Do not write a complicated query all at once.

Build it in stages.

For example, if you want revenue per city:

## Step 1: inspect orders

```sql
SELECT *
FROM orders
LIMIT 10;
```

## Step 2: join products

```sql
SELECT *
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id;
```

## Step 3: calculate revenue

```sql
SELECT
    o.*,
    p.price,
    o.quantity * p.price AS revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id;
```

## Step 4: join customers

```sql
SELECT
    c.city,
    o.quantity * p.price AS revenue
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products AS p
    ON o.product_id = p.product_id;
```

## Step 5: group by city

```sql
SELECT
    c.city,
    SUM(o.quantity * p.price) AS revenue
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY c.city;
```

This makes errors much easier to find.

---

# 63. Think About the Meaning of One Row

One of the most useful habits in SQL is to ask:

> What does one row represent at this point in my query?

Examples:

Before grouping:

```text
one row = one order
```

After:

```sql
GROUP BY customer_id
```

one row becomes:

```text
one customer
```

After:

```sql
GROUP BY city
```

one row becomes:

```text
one city
```

Subqueries and CTEs are especially useful when you need to move from one level to another.

Example:

```text
one row per order
      ↓
GROUP BY customer
      ↓
one row per customer
      ↓
average
      ↓
one overall customer average
```

---

# 64. SQL Concepts to Prioritize Right Now

You should be comfortable with:

## Core querying

```text
SELECT
FROM
DISTINCT
AS
```

## Filtering

```text
WHERE
AND
OR
NOT
IN
BETWEEN
LIKE / ILIKE
IS NULL
```

## Sorting

```text
ORDER BY
LIMIT
```

## Aggregation

```text
COUNT
SUM
AVG
MIN
MAX
GROUP BY
HAVING
```

## Joining

```text
INNER JOIN
LEFT JOIN
```

## Analysis tools

```text
CASE
COALESCE
EXTRACT
DATE_TRUNC
```

## Multi-stage analysis

```text
subqueries
CTEs
```

## Window functions

```text
OVER()
PARTITION BY
ROW_NUMBER()
RANK()
DENSE_RANK()
running SUM()
```

## Database structure

```text
CREATE TABLE
basic data types
PRIMARY KEY
FOREIGN KEY
DROP TABLE IF EXISTS
```

---

# 65. Topics You Do Not Need to Prioritize Yet

You can safely leave these until later:

```text
recursive CTEs
stored procedures
triggers
indexes in depth
query execution plans
database administration
transactions in depth
views/materialized views
advanced window frames
advanced recursive queries
advanced normalization theory
partitioned tables
database security/permissions
complex performance optimization
```

Learn these when you encounter a real reason to use them.

---

# 66. Compact Syntax Reference

## Basic query

```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1 DESC
LIMIT 10;
```

## Aggregation

```sql
SELECT
    category,
    SUM(value) AS total
FROM table_name
GROUP BY category
HAVING SUM(value) > 100
ORDER BY total DESC;
```

## Join

```sql
SELECT
    a.column1,
    b.column2
FROM table_a AS a
JOIN table_b AS b
    ON a.id = b.id;
```

## Left join

```sql
SELECT *
FROM table_a AS a
LEFT JOIN table_b AS b
    ON a.id = b.id;
```

## Subquery

```sql
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

## CTE

```sql
WITH result AS (
    SELECT ...
    FROM ...
)

SELECT *
FROM result;
```

## Window average

```sql
AVG(value) OVER (
    PARTITION BY category
)
```

## Ranking

```sql
ROW_NUMBER() OVER (
    PARTITION BY category
    ORDER BY value DESC
)
```

## Running total

```sql
SUM(value) OVER (
    ORDER BY date_column
)
```

## Conditional column

```sql
CASE
    WHEN condition THEN value
    ELSE value
END
```

## Null replacement

```sql
COALESCE(column_name, replacement)
```

## Extract date part

```sql
EXTRACT(MONTH FROM date_column)
```

## Group dates by month

```sql
DATE_TRUNC('month', date_column)
```

---

# 67. Final Mental Model

Most beginner SQL analysis can be thought of as:

```text
1. Choose tables
        ↓
2. JOIN related data
        ↓
3. WHERE filters individual rows
        ↓
4. GROUP BY changes the level of analysis
        ↓
5. Aggregate with SUM / AVG / COUNT etc.
        ↓
6. HAVING filters groups
        ↓
7. Window functions add comparisons/rankings without collapsing rows
        ↓
8. ORDER BY sorts the result
```

When the problem needs several separate stages:

```text
Stage 1
   ↓
Stage 2
   ↓
Stage 3
```

use:

```text
subqueries
or
CTEs
```

The most important question to keep asking is:

> **What does one row represent at this point in my query?**

If you can answer that, most SQL analysis becomes much easier to reason about.
