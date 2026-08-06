# SELECT Queries

## What it does

This is the method for retrieving data from a SQL database, colloquially known as queries.

## General syntax

The most basic query would be retrieving a set of columns from our chosen database:

```sql
SELECT column, another_column, ...
FROM mytable;
```
Column titles are generally descriptive, so if we had a list of movies on Netflix, then we could get the movie titles using

```sql
SELECT title FROM movies;
```

One may likewise retrieve every column from the database using (*):

```sql
SELECT *
FROM mytable;
```
