# Expressions

Expressions allow us to write more complex logic on column values in a query by using mathematical and string functions to transform values upon query execution. Using **AS** aliases expressions to make them easier to interpret and to reference in the output.

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
