# Window functions

A window functions performs calculation across multiple rows without collapsing those rows into groups (like GROUP BY does). These are commonly used for aggregates, rankings, and running totals. One uses the **OVER** clause to define the "window" of rows for the calculation.


Suppose we have

| customer_id | city       | total_spent |
|-|-|-|
1           | Brisbane   | 500|
2           | Brisbane   | 300
3           | Sydney     | 800
4           | Sydney     | 400

If we were to use GROUP BY city, we would get

|city       | avg_spent|
|-|-|
Brisbane   | 400
Sydney     | 600

where the original customers have disappeared. A window function lets us keep the customers *and* calculate the city average:
| customer_id | city       | total_spent | city_avg|
|-|-|-|-|
1           | Brisbane   | 500         | 400
2           | Brisbane   | 300         | 400
3           | Sydney     | 800         | 600
4           | Sydney     | 400         | 600

## Syntax

```sql
SELECT column_name1, 
       window_function(column_name2) 
       OVER ([PARTITION BY column_name3] [ORDER BY column_name4]) AS new_column
FROM table_name;
```

## Examples

The window function that creates the table above would look something like;
```sql
SELECT
    customer_id,
    city,
    total_spent,
    AVG(total_spent) OVER (
        PARTITION BY city
    ) AS city_average
FROM customers;
```

Whereas, the GROUP BY that collapses the rows would look like:
```sql
SELECT
    city,
    AVG(total_spent)
FROM customers
GROUP BY city;
```


We can use OVER() with empty brackets to calculate over all of the rows:

```sql
SELECT
    customer_id,
    total_spent,
    AVG(total_spent) OVER () AS overall_average
FROM customers;
```
would give an additional column where every row contains an additional column showing the overall average, which would contain the same value in every row.



