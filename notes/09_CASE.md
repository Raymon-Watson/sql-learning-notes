# CAsE

The case statement is essentially sql's equivalent of an if-then statement, evaluating to a new column in your data. Note that the CASE statement is typically contained in the query statement, i.e. in the SELECT section, and we can make other queries both before and after it.


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
