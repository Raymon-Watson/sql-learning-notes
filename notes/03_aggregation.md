# Expressions

Expressions allow us to write more complex logic on column values in a query by using mathematical and string functions to transform values upon query execution. Using **AS** aliases expressions to make them easier to interpret and to reference in the output.



### Syntax
```sql
SELECT column_expression AS expression_description
FROM table
```

### Examples

```sql
SELECT particle_speed / 2.0 AS half_particle_speed
FROM physics_data
WHERE ABS(particle_position) * 10.0 > 500;
```

```sql
SELECT
  COUNT(*) AS number_of_products,
  AVG(price) AS average_price,
  MIN(price) AS cheapest,
  MAX(price) AS most_expensive
FROM products;
```

**Note:** For this one, we are selecting all the movie data, and also adding a new column using an alias.
```sql
SELECT *, (Domestic_sales + International_sales)/1000000 AS combined_sales_millions FROM movies
INNER JOIN Boxoffice
ON Movies.Id = Boxoffice.Movie_id;
```

# Aggregation

Aggregate expressions (or functions) allow us to summarise information about a group of rows of data. If we have not grouped the expression (more on this below), the aggregate function will run on the whole set of result rows and return a single value (if grouped, then it will return an expression for each group). It is good practice to give an aggregation an alias, as it makes it easier to understand and also utilize in more complicated expressions.

Importantly, each database has its own supported set of mathematical, string, and date functions that can be used in a query, which can be found in their own respective docs. These supported functions are defined by the database management system (DBMS) that one is using, SQL specifies a common language, but databases (such as PostgreSQL, MySQL, SQLite, ...) each implement their own collection of functions that can be used inside expressions.

**List of the most basic expressions that almost every SQL system uses:**
|Category|Function|Purpose|Example|
|-|-|-|-|
|Aggregate| COUNT()|Counts rows/values|COUNT(*)|
|Aggregate| SUM()|Add values|SUM(price)|
|Aggregate| AVG()|Mean|AVG(price)|
|Aggregate| MIN()|Minimum|MIN(price)|
|Aggregate| MAX()|Maximum|MAX(price)|
|String| UPPER()|Uppercase text|UPPER(name)|
|String| LOWER()|Lowercase text|LOWER(name)|
|String| TRIM()|Removes surrounding spaces|TRIM(name)|
|String| SUBSTRING()|Extract part of text|SUBSTRING(name FROM 1 FOR 3)|
|Numeric| ABS()|Absolute value|ABS(profit)|
|Numeric| ROUND()|Round a number|ROUND(price, 2)|
|Numeric| MOD() / number%mod|Modular arithmetic|MOD(number,2)|
|NULL handling| COALESCE()|First non-null value|COALESCE(phone, 'unknown')|

### Syntax 

```sql
SELECT AGG_FUNC(column_or_expression) AS aggregate_descriptions, ...
FROM table
WHERE constraint_expressions;
```

## Grouped aggregate functions

Instead of simply running our aggregate function over all rows, we can appl the aggregate function to individual groups of data within those rows (e.g. counting the number of movies separated by Comedies v.s. Action). This results in aggregated data over each individual group, where the number of aggregated results matches the number of unique groups as defined by the GROUP BY clause.

(Note: This is very similar to how pandas groups by, so we can think of it in the same way.)

### Syntax

```sql
SELECT AGG_FUNC(column_or_expression) AS aggregate_description, ...
FROM table
WHERE constraint_expression
GROUP BY column;
```


### Examples

If we have a list of employees with their role and average year employed, we can find the average years employed for each role as:
```sql
SELECT Role, AVG(Years_employed) AS avg_years_employed
FROM employees
GROUP BY Role;
```

## HAVING

Note that the GROUP BY clause is executed after the WHERE clause. Recall that the WHERE clause filters the rows which are to be grouped. To filter the GROUP BY clause, we must use HAVING, which is used specifically by the GROUP BY clause, and allows us to filter grouped rows from the result set, and are written in the same way as the WHERE clause.

### Syntax

```sql
SELECT group_by_column, AGG_FUNC(column_expression) AS aggregate_result_alias, …
FROM mytable
WHERE condition
GROUP BY column
HAVING group_condition;
```


### Example

Find the total number of years employed by all Engineers 
```sql
SELECT Role, SUM(Years_employed) FROM employees
GROUP BY Role
HAVING Role='Engineer';
```


# Order of Execution




