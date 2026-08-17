# Subqueries and CTE's

## Subqueries

A subquery is simply a SQL query placed inside another SQL query. This is useful when we want to take an aggregate of a value not present in the original data, in such a case the subquery would calculate the new value, then aggregation of this value can be done on the subquery. The general method is: *first make the result table, then query that result.*

This is also useful when we want to condition on a value from the table. Recall the sqlBolt exercise where we want to find all the cities west of Chicago, one could use the subquery to calculate the longitudinal value of Chicago, and then query this value.


### Syntax

It is good practice to give the subquery a name, though this is not always strictly necessary (as in postgresql).

```sql
SELECT ...
FROM (
  SELECT ...
  FROM ...
) AS subquery_name
```

### Example
If we have a typical relational table setup of *customers*, *orders*, and *products*, and want to find the average amount spent by each customer. We first can calculate the spending per customer as a subquery, and then take the aggregate, which here would be AVG:

```sql
SELECT AVG(customer_spend)
FROM (
    SELECT
        customer_id,
        SUM(quantity * price) AS customer_spend
    FROM orders
    INNER JOIN products
        ON orders.product_id = products.product_id
    GROUP BY customer_id
) AS customer_totals;
```


Suppose we want to find all products whose price is greater than the average:
```sql
SELECT * FROM products
WHERE price > (
  SELECT AVG(price)
  FROM products
) AS avg_price;
```

Another useful method is to use subqueries to check whether a value is present anywhere in another set of values. In particular, if we want to find the set of customers who have made a purchase, we could use:
```sql
SELECT * FROM customers
WHERE customer_id IN (
  SELECT customer_id
  FROM orders
);
```
(Can likewise use NOT IN to check for customers who *haven't* made orders).


## CTE's (Common Table Expressions)

A CTE allows you to define a named query result before your main query. This does a similar thing to subqueries, the benefit of this method is readability. The general method is: create a temporary result with a particular name, and then perform your query from this result. One can also easily perform multiple CTE's in one overall query in a much easier fashion. Also, since we give the CTE a name, we can utilize it more than once in the following query, making it much easier to handle.

The CTE does basically the same job as the subquery, but instead of first defining the outer query and then the inner which the outer query depends on, the CTE is much more straightforward, naming an intermediate query and then using this in the main query.

**Rule of thumb:** Use a subquery for short and simple logical questions. Use a CTE when the query is more complex, having several logical stages.

### Syntax

```sql
WITH cte_name AS (
  SELECT ...
)
SELECT ...
FROM cte_name;
```

### Examples

```sql
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS customer_spend
    FROM orders
    JOIN products
        ON orders.product_id = products.product_id
    GROUP BY customer_id
)
SELECT AVG(customer_spend)
FROM customer_totals;
```

Does exactly the same job as:

```sql
SELECT AVG(customer_spend)
FROM (
    SELECT
        customer_id,
        SUM(quantity * price) AS customer_spend
    FROM orders
    JOIN products
        ON orders.product_id = products.product_id
    GROUP BY customer_id
) AS customer_totals;
```



