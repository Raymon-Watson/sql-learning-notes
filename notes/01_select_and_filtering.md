# SELECT Queries

SELECT is used to retrieve data from a SQL database by declaring the data that we are looking for and stating how we are filtering or transforming it before it is returned.

**Note:** it is not required to write all keywords in capitals, but it helps readability.

## Basic SELECT

This is the method for retrieving data from a SQL database, colloquially known as queries.

### General syntax

The most basic query would be retrieving a set of columns from our chosen database:

```sql
SELECT column, another_column, ...
FROM mytable;
```

One may retrieve every column from the database using (*):

```sql
SELECT *
FROM mytable;
```

### Examples

Column titles are generally descriptive, so if we had a list of movies on Netflix, then we could get the movie titles using:

```sql
SELECT title FROM movies;
```

Multiple columns can be returned by separating by commas:

```sql
SELECT title, director FROM movies;
```


## SELECT with constraints

Typically, data sets are quite large, and we need some way of filtering this data based on constraints. This can be done by using a WHERE clause, which is applies each row by checking specific column values in order to determine whether the constraint is satisfied. This typically allows query to run faster due to a reduction of returned data.

### General Syntax

The most general case is as follows:

```sql
SELECT column_1, column_2, ...
FROM table
WHERE condition_1
  AND/OR condition_2
  AND/OR ...;
```

**For numerical data, the following operators can be utilized:**

|Operator|Condition|SQL Example|
|---|---|---|
|=, !=, <, <=, >, >= | Numerical operators| num <= 3 ,  num != 4|
| BETWEEN val_1 AND val_2 | Numerical range (inclusive of end points) | Year BETWEEN 1995 AND 1999 |
| NOT BETWEEN val_1 AND val_2 | Numerical exterior range (inclusive of end points) | Year NOT BETWEEN 1995 AND 1999 |
| IN (values) | Number exists in list | Year IN (1995, 2000, 2005, 2010) |
| NOT IN (values) | Number not exist in list | YEAR NOT IN (2001, 2002) |

**For text (string) data, the following operators can be utilized:**

|Operator|Condition|SQL Example|
|---|---|---|
| = | Case sensitive string comparison | Movie_title = "Toy Story" |
| != (or <>) | Case sensitive string inequality comparison | Movie_title != "Toy Story" |
| LIKE | Case insensitive string comparison | Movie_title LIKE "toy Story" |
| NOT LIKE | Case insensitive string inequality comparison | Movie_title NOT LIKE "toy Story" |
| % | Wildcard for strings for arbitrary number of characters | Movie_title LIKE "toy %" |
| _ | Wildcard for single characters | Movie_title NOT LIKE "toy story _" |
| IN (strings) | String exists in a list | Movie_studio IN ("Dreamworks", "Disney") |
| NOT IN (strings) | String does not exist in a list | Movie_studio NOT IN ("Illumination", "Studio Ghibli") |


### Examples





