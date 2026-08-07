-- ===========================================
-- SELECT Example
-- Purpose:
-- Demonstrate various uses of selecting and
-- filtering data in PostgreSQL
-- ===========================================


-- 1. Remove tables if they already exist.
-- This is generally good practice for starting a new 
-- project, as we don't want to encounter errors from
-- trying to create a table that we created previously.

-- Right now I am creating the tables, but in future I
-- will probably start by importing the data.

DROP TABLE IF EXISTS cities;

-- 2. Create countries table.
-- This will contain information about the cities in
-- North America, largely taken from SQLBolt

CREATE TABLE cities (
  City varchar(255) PRIMARY KEY,
  Country varchar(255) NOT NULL,
  Population int,
  Latitude float(24),
  Longitude float(24)
);

-- 3. Insert data into table.

INSERT INTO cities (
  City,
  Country,
  Population,
  Latitude,
  Longitude
)
Values
  ('Guadalajara', 'Mexico', 1500800, 20.659699, -103.349609),
  ('Toronto', 'Canada', 2795060, 43.653226, -79.383184),
  ('Houston', 'United States', 2195914, 29.760427, -95.369803),
  ('New York', 'United States', 8405837, 40.712784, -74.005941),
  ('Philadelphia', 'United States', 1553165, 39.952584, -75.165222),
  ('Havana', 'Cuba', 2106146, 23.05407, -82.345189),
  ('Mexico City', 'Mexico', 8555500, 19.432608, -99.133208),
  ('Phoenix', 'United States', 1513367, 33.448377, -112.074037),
  ('Los Angeles', 'United States', 3884307, 34.052234, -118.243685),
  ('Montreal', 'Canada', 1717767, 45.501689, -73.567256);

-- 4. View all data

SELECT * FROM cities;



-- 5. Various SELECT Examples


-- Order cities by population highest to lowest, listing only their name and pop.

SELECT city, population FROM cities
ORDER BY population DESC;

-- Order cities in USA West to East

SELECT * FROM cities
WHERE Country = 'United States';

-- NOTE: SQLite is capable of using IS to compare strings, but postgres requires =.

-- Find the 2nd and 3rd highest population cities in USA, highest to lowest

SELECT * FROM cities
WHERE country = 'United States'
ORDER BY population DESC
LIMIT 2 OFFSET 1;

-- Find all cities in USA West of Houston, west to east

SELECT * FROM cities
WHERE country = 'United States'
	AND longitude < -96
ORDER BY longitude ASC;




  
