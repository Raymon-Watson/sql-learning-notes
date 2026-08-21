# CAs=SE

The case statement is essentially sql's equivalent of an if-then statement, evaluating to a new column in your data. Note that the CASE statement is typically contained in the query statement, i.e. in the SELECT section, and we can make other queries both before and after it.

WHEN clauses are logical statements, meaning they can contain AND, OR, or any other boolean operation.

**NOTE:** Since WHERE is evaluated before SELECT, if we want to filter based on the CASE statement, we generally need to include the entire CASE statement in the WHERE clause, and then use it to filter values. One can otherwise use CTE's (see example below).

## Syntax
```sql
CASE
  WHEN condition1 THEN result1
  WHEN condition2 THEN result2
  WHEN conditionN THEN resultN
  ELSE default_result
END;
```

## Examples

If we wanted to define a new column that checks the prices of products, and includes an additional column that tells us whether the cost is high, medium, or low, we would use a CASE statement to define a new column expressing that data.
```sql
SELECT ProductName, Price,
CASE
  WHEN Price < 20 THEN 'Low Cost'
  WHEN Price BETWEEN 20 AND 50 THEN 'Medium Cost'
  ELSE 'High Cost'
END AS PriceCategory
FROM Products;
```



Since we cannot use the CASE statement defined in SELECT to filter via WHERE, as WHERE is evaluated before SELECT, we can filter based on CASE in two ways:

**(1)** Repeat entire CASE clause in WHERE:
```sql
SELECT
    customer_id,
    CASE
        WHEN total_spent > 1000 THEN 'High Value'
        WHEN total_spent > 500 THEN 'Medium Value'
    END AS customer_type
FROM customers
WHERE
    CASE
        WHEN total_spent > 1000 THEN 'High'
        WHEN total_spent > 500 THEN 'Medium'
    END IS NOT NULL;
```
This removes the NULL values defined in the CASE statement. Another, perhaps simpler, way of doing this would be to simply remove the values not considered:
```sql
SELECT
    customer_id,
    CASE
        WHEN total_spent > 1000 THEN 'High Value'
        WHEN total_spent BETWEEN 500 AND 1000 THEN 'Medium Value'
    END AS customer_type
FROM customers
WHERE total_spent > 500;
```
This removes the values we don't want to consider in a simpler manner.

**(2)** Another option would be to use CTE's:
```sql
WITH customer_groups AS (
    SELECT
        customer_id,
        CASE
            WHEN total_spent > 1000 THEN 'High'
            WHEN total_spent > 500 THEN 'Medium'
        END AS customer_type
    FROM customers
)
SELECT *
FROM customer_groups
WHERE customer_type IS NOT NULL;
```
Here, we use the CASE statement to define our new column, but we can then query it and use it in WHERE since it is defined in a CTE.


