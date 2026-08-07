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

DROP TABLE IF EXSITS cities;

-- 2. Create countries table.
-- This will contain information about the cities in
-- North America, largely taken from SQLBolt

CREATE TABLE cities (
  City varchar(255) PRIMARY KEY,
  Country varchar(255) NOT NULL,
  Population int,
  Latitude float(24),
  Longitude float(24)
)

-- 3. Insert data into table.

INSERT INTO cities (
  City,
  Country,
  Population,
  Latitude,
  Longitude
)
Values
  ('Guadalajara', 'Mexico', 1500800, 20.659699, -103.349609)
  ('Toronto', 'Canada', 2795060, 43.653226, -79.383184)
  ('Houston', 'United States', 2195914, 29.760427, -95.369803)
  ('New York', 'United States', 8405837, 40.712784, -74.005941)
  ('Philadelphia', 'United States', 1553165, 39.952584, -75.165222)
  ('Havana', 'Cuba', 2106146, 23.05407, 23.05407, -82.345189)
  ('Mexico City', 'Mexico', 8555500, 19.432608, -99.133208)
  ('Phoenix', 'United States', 1513367, 33.448377, -112.074037)
  ('Los Angeles', 'United States', 3884307, 34.052234, -118.243685)
  ('Montreal', 'Canada', 1717767, 45.501689, -73.567256)

-- 4. View all data

SELECT * FROM cities


  
