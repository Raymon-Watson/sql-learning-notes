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

### Syntax

```sql
SELECT column_name1, 
       window_function(column_name2) 
       OVER ([PARTITION BY column_name3] [ORDER BY column_name4]) AS new_column
FROM table_name;
```

### Examples

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


A particularly useful method that one can use window functions for are **running totals**. This uses ORDER BY within the window function to create a simple running total that could be used to calculate total revenue over subsequent months (simply modified to create a running average).
```sql
SELECT
    order_date,
    revenue,
    SUM(revenue) OVER (
        ORDER BY order_date
    ) AS running_revenue
FROM daily_sales;
```




# Utility
There are a number of useful functions and methods we can use in combination with window functions.

## PARTITION BY

PARTITION BY divides the rows into groups for the window calculation.

### Examples

Here, PARTITION BY city means we are calculating the average separately for each city. This is similar to GROUP By, but again without removing the individual rows.
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





## ROW_NUMBER()

Obviously, ROW_NUMBER() numbers rows, assigning a unique, sequential integer to each row in a query result. 

### Syntax

```sql
SELECT
    column_name,
    ROW_NUMBER() OVER (ORDER BY column_name DESC) AS row_num
FROM table_name;
```

### Examples
```sql
SELECT
    customer_id,
    total_spent,
    ROW_NUMBER() OVER (
        ORDER BY total_spent DESC
    ) AS row_number
FROM customers;
```
Results in
|customer_id | total_spent | row_number|
|-|-|-|
3           | 800         | 1
1           | 500         | 2
4           | 400         | 3
2           | 300         | 4


## RANK() and DENSE_RANK()

RANK() does a similar thing to ROW_NUMBER() introduced above, but gives the same rank to values with the same number. DENSE_RANK() does the same thing as RANK(), but not skipping numbers that are repeated.

This difference is easily seen in an example:

**ROW_NUMBER()**
800 → 1\
500 → 2\
500 → 3\
300 → 4

**RANK()**
800 → 1\
500 → 2\
500 → 2\
300 → 4

**DENSE_RANK()**
800 → 1\
500 → 2\
500 → 2\
300 → 3

