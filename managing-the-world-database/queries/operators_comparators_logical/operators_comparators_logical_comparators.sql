USE world;

-- COMMAND TO FIND COUNTRIES WITH POPULATION BETWEEN 50 MILLION AND 200 MILLION
SELECT Name FROM country WHERE Population BETWEEN 50000000 AND 200000000;

-- COMMAND TO FIND COUNTRIES WITH POPULATION IN A SPECIFIC RANGE
SELECT Name FROM country WHERE Population IN (20000000, 30000000, 40000000, 50000000);

-- COMMAND TO FIND CITIES WITH POPULATION BETWEEN 1M AND 10M, EXCLUDING ASIAN REGION
SELECT name FROM city 
WHERE population BETWEEN 1000000 AND 10000000 
AND countrycode NOT IN (SELECT Code FROM country WHERE Region = 'Asia');

-- COMMAND TO FIND COUNTRIES WITH POPULATION OVER 100 MILLION OR REGION EUROPE
SELECT Name FROM country WHERE Population > 100000000 OR Region = 'Europe';

-- COMMAND TO FIND CITIES STARTING WITH 'A' BUT NOT ENDING WITH 'N'
SELECT Name FROM city WHERE Name LIKE 'A%' AND Name NOT LIKE '%n';
