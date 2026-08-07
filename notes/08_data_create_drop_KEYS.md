# CREATE TABLE

## What it does

CREATE TABLE is used to create a new table in a database.

## Syntax

**table_name** - specify name of new table.
**column1, colum2, ...** - specify name of columns within the table.
**datatype** - type of data in each column (e.g. varchar, int, date, str, etc.)
**constraint** - (optional) specify rules for data integrity (e.g. primary key, not null, etc.)

```sql
CREATE TABLE table_name (
  column1 datatype constraint,
  column2 datatype constraint,
  column3 datatype constraint,
  ...
);
```
### Example

PRIMARY KEY uniquely identifies each row.

NOT NULL specifies that this row column cannot be empty.

varchar(255) string of maximum length 255 characters.

```sql
CREATE TABLE Persons (
  PersonID int PRIMARY KEY,
  LastName varchar(255) NOT NULL,
  FirstName varchar(255),
  Address varchar(255)
);
```

## Creating a table from an existing table

```sql
CREATE TABLE new_table AS
SELECT column1, column2, ...
FROM existing_table
WHERE ...;
```

### Example

```sql
CREATE TABLE GermanCustomers AS
SELECT * FROM Customers
WHERE Country = 'Germany';
```

# DROP TABLE

## What it does

**Careful** Dropping a table deletes the entire table and all of its context, make sure to use with care.

## Syntax

```sql
DROP TABLE table_name;
```

Can add IF EXISTS to only drop a table if it already exists, this helps prevent errors.

```sql
DROP TABLE IF EXISTS table_name;
```
## TRUNCATE TABLE

Removes all records in a table, keeping the table structure, columns, and constraints.


# KEYS

Keys are attributes (columns) or groups of attributes that uniquely identify rows within a table. They are also importantly used to establish relationships between different tables. They prevent data duplication, enforce referential integrity, and generally significantly optimise query performance.

List of key types:

| Key Type | Uniqueness | Allows Nulls | Maximum Per Table | Purpose |
|---|---|---|---|---|
| PRIMARY KEY  | Unique  |  No |  One |  Uniquely identifies each record in the table |
| FOREIGN KEY  | Dependent  | Yes  | Multiple  |  Links to a PRIMARY KEY in another table to build relationships |
|  UNIQUE KEY | Unique  |  Yes (usually one) | Multiple  |  Ensures column values are distinct without being the main identifier |
|  COMPOSITE KEY | Unique  | Depends  | Multiple  | Uses two or more combined columns to create a unique identifier  |

## PRIMARY KEY

Uniquely identifies each record in a database table. Therefore cannot consists of NULL values. Table may have only one primary key, which can either be a single column or a combination of columns.

### Example

**Primary key on a single column**
```sql
CREATE TABLE Persons (
  ID int PRIMARY KEY,
  LastName varchar(255) NOT NULL,
  FirstName varchar(255),
  Age int
)
```

**Primary key on multiple columns**

```sql
CREATE TABLE Persons (
  ID int,
  LastName varchar(255),
  FirstName varchar(255),
  Age int,
  PRIMARY KEY (ID, LastName)
);
```

## FOREIGN KEY



