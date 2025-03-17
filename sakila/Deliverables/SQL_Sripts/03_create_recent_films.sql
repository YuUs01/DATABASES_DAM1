USE sakila;

SELECT * FROM film WHERE release_year > 2005;

CREATE TABLE recent_films AS
SELECT * FROM film WHERE release_year > 2005;


SELECT * FROM recent_films;
