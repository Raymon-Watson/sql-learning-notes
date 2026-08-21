# Window functions

A window function makes a calculation across multiple rows that are related to the current row, such as
- running totals,
- 7-day moving averages,
- rankings.
This task is quite similar to what you would typically perform by using GROUP BY. However, a window functions performs calculation across multiple rows without collapsing those rows into groups (like GROUP BY does). One uses the **OVER** clause to define the "window" of rows for the calculation.

As a explanatory example, suppose we have:

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


**Importantly**, this allows us to compare data to aggregated data, which wouldn't be possible when using GROUP BY.


## Syntax

```sql
SELECT
    window_function() OVER(
        PARTITION BY partition_expression
        ORDER BY order_expression
        window_frame_extend
    ) AS window_column_alias
FROM table_name;       
```

To reuse the same window with several window functions, define a named window using the WINDOW keyword. This appears in the query after the HAVING section and before the ORDER BY section:
```sql
SELECT
    window_function() OVER(window_name)
FROM table_name
[HAVING ...]
WINDOW window_name AS (
    PARTITION BY partition_expression
    ORDER BY order_expression
    window_frame_extent
)
[ORDER BY ...];
```
Note that the above does the exact same thing as the first window query, but we have defined the window in its own discrete section, making it possible to re-use it in another query.

## Sub-clauses
In the following sections, we go over some useful subclauses that we can use within the OVER clause.

### ORDER BY
ORDER BY changes the basis on which the function assigns numbers to rows. This is essential for when we want to assign sequences to rows (as without it, we would just be ranking the original columnns).

Let us look at an example of ranking prices in a table from high to low:
```sql
SELECT product_name,
    list_price,
    RANK() OVER(ORDER BY list_price DESC) AS rank
FROM products;
```
This will show the product name and list price, along with a rank according to the price of the item from highest to lowest (see DESC). See more details on what exactly RANK() does, below.

### PARTITION BY
We can use PARTITION BY to specify the column over which the aggregation is performed. It is useful to compare PARTITION BY and GROUP BY:
- Just like GROUP BY, the OVER subclause splits the rows into as many partitions as there are unique values in a column,
- GROUP BY aggregates all rows, however the result of a window function using PARTITION BY aggregates each partition independently. Importantly, without PARTITION BY the result is only a single partition.

As an example, let us look first at using GROUP BY to calculate the average price of some product per year using the following:
```sql
SELECT year, AVG(list_price) AS avg_price
FROM products
GROUP BY year;
```
This gives:
|year|avg_price|
|-|-|
|2016|1000|
|2017|1200|
|2018|1300|

However, we often want to compare each product's price with the average price from that year. This can be done by using a window function and PARTITION BY year:
```sql
SELECT year,
    product_name,
    list_price,
    AVG(list_price) OVER(PARTITION BY model_year) AS avg_price
FROM products;
```
This will give us:
|year|product_name|list_price|avg_price|
|-|-|-|-|
|2016|sunscreen|1000|1000|
|2017|tennis shoes|1000|1200|
|2017|tennis racket|1400|1200|
|2018|headband|1300|1300|

Note that the avg_price column gives the same values, but now they are spread over each individual item. Also note that, since there are two products in 2017, the list price of both are shown, which combine to the average price shown in the final column.


### Window frame extent

A window frame is the selected set of rows in the partition over which the aggregation will occur (i.e. the set of rows that are somehow related to the current row).

The window frame is defined by a lower and upper bound relative to the current row. The lowest possible bound is the first row, since we cannot go back before that, and is known as UNBOUNDED PRECEDING. Likewise, the highest row is the last row, UNBOUNDED FOLLOWING.

For example, if we only want to get 5 rows before the current row, then we specify the range using 5 PRECEDING.


### Aggregation

Aggregate functions can be simply used with window functions in the same way that they are used for GROUP BY, but instead we define them before. As an explanatory example, let's write some code to find the average, maximum, and minimum discount for each product:

```sql
SELECT
    order_id,
    product_id,
    discount,
    AVG(discount) OVER(PARTITION BY product_id) AS avg_discount,
    MIN(discount) OVER(PARTITION BY product_id) AS avg_discount,
    MAX(discount) OVER(PARTITION BY product_id) AS avg_discount
FROM order_items;
```

### LEAD and LAG







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

## Sliding Windows

A particularly useful type of window function are the sliding windows, which will allow us to compare data from one row with a previous row.
