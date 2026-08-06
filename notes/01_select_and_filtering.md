# LEFT JOIN

## What it does

A LEFT JOIN keeps every row fromt he table on the left and adds matching information from the table on the right

## General sytax

```sql
SELECT
  a.column_name,
  b.other_column
  FROM table_a AS a
  LEFT JOIN table b AS b
    ON a.id = b.id;
