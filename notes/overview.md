# General SQL Notes

## What is SQL?
Structured Query Language (SQL) is a language for querying, manipulating, and transforming data from a relational database.

A relational database represents a collection of related tables (a table is a 2D collection of data). Each table is like an excel spreadsheet, or a DataFrame in Pandas, with a fixed number of named columns (attributes) and an arbitrary number of rows of data.

Example Database:

|Id|Store|Purchase_amount|Num_items|
|---|---|---|---|
|1|Woolworths|425.9|18|
|2|Coles|95.99|6|
|3|Woolworths|247.4|12|
|4|Aldi|123.42|10|
|5|Coles|137.39|8|

Such a database might have additional related tables containing, e.g., location of stores, store revenue, number of customers,...

We want to think of questions, and then understand how we can answer these questions using queries. Such questions and queries can help us make better decisions from data analysis.

## PostgresSQL
For these notes I will be using PosgresSQL, a free, open-source relational database management system. It extends the basic SQL language to be safer and more scalable.

**Documentation:** https://www.postgresql.org/docs/
