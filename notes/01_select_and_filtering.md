# SELECT Queries

SELECT is used to retrieve data from a SQL database by declaring the data that we are looking for and stating how we are filtering or transforming it before it is returned.

**Note:** it is not required to write all keywords in capitals, but it helps readability.

## Basic SELECT

This is the method for retrieving data from a SQL database, colloquially known as queries.

### Syntax

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

### Syntax

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

Numerical:
```sql
SELECT * FROM movies
WHERE Year BETWEEN 1995 AND 2010
  AND Rating >= 7.5
```
String:
```sql
SELECT Title FROM movies
WHERE Director LIKE "Quentin Tar%"
  OR Director = "Clint Eastwo_d"
```

Combined:
```sql
SELECT Book_Title FROM book_data
WHERE Author IN ("Stephen King", "Clive Bark%"
  AND Year BETWEEN 1990 AND 1999
```


## DISTINCT 

Queries may often provide multiple rows with duplicates of your selected data, an example of this would be searching for a movie by a single director which returns multiple movies by that director. We can use the DISTICNT keyword to remove duplicates, returning only the first example.


### Syntax

```sql
SELECT DISTINCT column_1, column_2, ...
FROM table
WHERE condition_1
  AND condition_2...;
```

### Example


```sql
SELECT DISTINCT Year, Director
FROM table
WHERE Year BETWEEN 1960 AND 2000
```


## ORDER BY

Generally, data contained within databases are not ordered neatly. Typically, there is some id associated with each row, which can be effectively randomly assigned. When presenting data, we typically want to order according to some principle, say alphabetically ordering by film titles, or numerically by year of release (or numerically by year of release and then within each year alphabetically by film title).

### Syntax

```sql
SELECT column_1, column_2,...
FROM table
WHERE condition_1
  AND/OR condition_2
ORDER BY column ASC/DESC
```

### Example

```sql
SELECT movie_title
FROM movies
WHERE Year < 2000
ORDER BY Year DESC
```


## LIMIT and OFFSET

Often, when querying, there can be a lot of data returned. For example, if we are looking at cars sold in Queensland, we may want to look at cars of a particular brand, which would return an enormous amount of data. We can LIMIT the number of rows returned, and also OFFSET if we want to start our count for a particular point in the list.

A particular example would be Google searching. We are searching for pages with a particular keyword or phrase, but want to return the first 10 results, so we would LIMIT our result. The next page would contain the next 10, so we would LIMIT and OFFSET.

### Syntax

```sql
SELECT column_1, column_2, ...
FROM table
WHERE condition
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset
```


### Example

```sql
SELECT Movie_title, Director
FROM movies
WHERE Year BETWEEN 1990 AND 2000
LIMIT 10 OFFSET 5
```




