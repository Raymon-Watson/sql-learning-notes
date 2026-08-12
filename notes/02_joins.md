# Joins

Often data is distributed across multiple tables. JOINs take rows from two tables and then decide which rows should be paired together, this is generally done using KEYs, which tell us which rows should be paired, often using an incrementing integer which uniquely identifies the paired rows. Breaking down data and distributing it across tables is done via **normalization**, which we go over at the end of this notebook.

**There are three main types of JOINs:**
- INNER JOIN: returns only rows where there is a match in both tables.
- LEFT JOIN: Keep every row from the left table, even if there isn't a match in the right table. Missing data in the right table will typically be represented by NULL values.
  - Ex: useful for when we want to examine every customer, whether or not they have ever bought anything.
  - Can also be used to show customers who have never bought anything.
- RIGHT JOIN: Keep every row from the right table, even if there isn't a match in the left table. Basically the exact inverse of LEFT JOIN.
  - Ex: can be used to show all items for sale, even if nobody has ever bought a particular item.
  - Obvious utility in finding items that nobody has ever bought.
 
To understand how JOINs work, it is important to understand ON and PRIMARY KEYs.
**ON** tells us what column we are using match our JOINs.
**PRIMARY KEY** is what we typically use to JOIN tables, these must uniquely identify rows. Typically this is done via an incrementing integer, but they can also be strings, hashed values, or other data types, so long as it is unique. 
More on both of these in the following sections.


 
Note: there are a number of other relevant JOINs, but these are less common:
- FULL OUTER JOIN: keeps everything from both tables, regardless of match.
  - Obvious utility when looking for similarities and differences between two datasets, allowing us to check what is only in one dataset.
- CROSS JOIN: Basically a Cartesian product of two tables, matches every single row in left table with every single row in the right table.
- SELF JOIN: Essentially a typical JOIN, but here we are joining a table to itself.



## Inner Join

This allows us to combine row data across two separate tables using a unique key. INNER JOIN matches rows from the first and second table which have the same key, defined through the **ON** constraint, creating a result row with the combined columns from both tables. After the tables are joined, selection may be done, as well as the other clauses that are contained in lesson 1.

Note: INNER JOIN is often simply written JOIN, as it is the most common type of join. For now, I should probably specify the full INNER JOIN, to avoid confusion.

### Syntax

```sql
SELECT column_1, column_2, ...
FROM table_1
INNER JOIN table_2
  ON table_1.id = table_2.id
WHERE condition(s)
ORDER BY column, ... ASC/DESC
LIMIT num_limit OFFSET num_offset
```


## LEFT JOIN



## RIGHT JOIN



# Database Normalization

Distributing data across multiple tables can be done using **normalization**. This process organizes data across tables so that we avoid unnecessary duplication and keep the data consistent. The core idea is that we **store each fact in one sensible place**, and then connect tables using keys.

As an example of this, say we had a table consisting of orders by customers:

| order_id | customer_name | customer_email | product | product_price |
| --- | --- | --- | --- | --- |
| 101 | Alice | alice@email.com | Laptop | 1200 |
| 102 | Alice | alice@email.com | Mouse | 40 |
| 103 | Bob | bob@email.com | Laptop | 1200 |

If we stored all the data in a single table, we could have multiple duplicates when customers bought different items (see Alice repeated). This could cause a problem if Alice updated her email, as we would then have to go through every single email entry belonging to Alice and update them, if we forgot to do this for all entries, then our database would be **inconsistent**.

If we **normalize** the data, we would design separate tables that include the different types of information:

**Customers**
| customer_id | name | email |
| --- | --- | --- |
| 1 | Alice | alice@email.com |
| 2 | Bob | bob@email.com |

**Products**

| product_id | product | price |
| --- | --- | --- |
| 1 | Laptop | 1200 |
| 2 | Mouse | 40 |

**Orders**
| order_id | customer_id | product_id |
| --- | --- | --- |
| 101 | 1 | 1 |
| 102 | 1 | 2 |
| 103 | 2 | 1 |

Now, if we want to look up order information, we look at Orders, and then can join the related tables to obtain the customer information and items bought.

**Why normalize?**
- Update problems: If an email appears in multiple rows, we have to update each one. If we normalize, we only have to update once, without fear of inconsistency.
- Insertion problems: Adding a product before anybody has bought it is very difficult in the first table, as it only records purchased items. In the normalized data, we simply append it to our table, and then update Orders upon purchase.
- Deletion problems: Likewise, if we only had one purchase of an item, and this order is later cancelled, if the product information only exists in this row then deleting it might delete all information about the product.

**Rule of thumb**: if you find yourself entering the same information multiple times, consider whether that information should live in its own table. (Note that this does not mean put every column in its own table, some data naturally lives together).


## Normal forms

Normalization often occurs in levels, in particular 1NF, 2NF, and 3NF:

- **First normal form (1NF):** Each cell should contain a single value, rather than a list.
  - E.g. Don't group Laptop and Mouse order into a single value, these should be separate.
- **Second normal form (2NF):** Information should depend on the whole primary key, not just part of it.
  - This becomes important when you have a composite primary key. Say some students are taking a course and we are using a composite primary key of (student_id, course_id). The student's grade should go with this composite primary key, as it depends on both the student and the course. The student's name only depends on the student_id, so it should probably live in a separate table containing only student information.
- **Third normal form (3NF):** Non-key columns should depend on the key, rather than depending on another non-key column.
  - Say we are listing employees and their departments, and each department has its own department_id, then the employee_id should go with the department, but the department_id is uniquely associated with the department, so we should split off departments to their own table.


