USE world;

-- COMMAND TO RETRIEVE THE TOP 10 CITIES WITH HIGHEST POPULATION
SELECT Name FROM city ORDER BY Population DESC LIMIT 10;

-- COMMAND TO ANALYZE THE QUERY PERFORMANCE USING EXPLAIN
EXPLAIN SELECT Name FROM city ORDER BY Population DESC LIMIT 10;

-- COMMAND TO CREATE AN INDEX ON POPULATION FOR OPTIMIZATION
CREATE INDEX idx_population ON city(Population);

-- COMMAND TO SEARCH CITIES WITH POPULATION > 1M AND NAME STARTING WITH 'A'
SELECT Name FROM city WHERE Population > 1000000 AND Name LIKE 'A%';
