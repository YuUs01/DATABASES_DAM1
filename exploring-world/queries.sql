USE world;

SHOW TABLES;

-- 1 Retrieve all country names and their official languages
SELECT c.Name, cl.Language
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T';

-- 2 List all cities in Germany along with their population
SELECT Name FROM city WHERE CountryCode = (SELECT Code FROM country WHERE Name = 'Germany');

-- 3 Find the five smallest countries by surface area.
SELECT surfaceArea, Name FROM country ORDER BY SurfaceArea ASC LIMIT 5;

-- 4 Find all countries with a population greater than 50 million and sort them in descending order of population.
SELECT population, Name FROM country WHERE population>50000000;

-- 5 Retrieve the average life expectancy per continent
SELECT continent, AVG (LifeExpectancy) As AverageLifeExpectancy FROM country GROUP BY continent;

-- 6 Calculate the total population per region
Select region, SUM(Population) AS TotalPopulation FROM country GROUP BY region;

-- 7 Count the number of cities in each country and sort by the highest count
SELECT country.Name, COUNT(city.Name) AS NumberOfCities
FROM country
JOIN city ON country.Code = city.CountryCode
GROUP BY country.Name
ORDER BY NumberOfCities DESC;

-- 8 Display the top 10 largest cities along with their country name
SELECT city.Name, city.Population, country.SurfaceArea
FROM city
JOIN country ON city.CountryCode = country.Code
ORDER BY country.SurfaceArea DESC;

-- 9 Retrieve the names of all countries that have an official language of French
SELECT c.Name
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.Language = 'French' AND cl.IsOfficial = 'T';

--  10 Find all countries where English is spoken, but it is not the official language.
SELECT c.Name
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.Language = 'English' AND cl.IsOfficial = 'F';

-- 11 Find countries where the population tripled in the past 50 years (if historical data is available).
SELECT c.Name
FROM country c
JOIN population_history ph ON c.Code = ph.CountryCode
WHERE ph.Year = YEAR(CURDATE()) - 50
AND c.Population >= 3 * (SELECT Population FROM population_history WHERE CountryCode = c.Code AND Year = YEAR(CURDATE()) - 50);

-- 12 List the richest and poorest countries in each continent based on GNP (Gross National Product)
SELECT c.Name, c.Continent, c.GNP
FROM country c
WHERE c.GNP = (
    SELECT MAX(GNP)
    FROM country
    WHERE Continent = c.Continent
)
ORDER BY c.Continent;

-- 13 Identify countries with a life expectancy below the global average
SELECT Name, LifeExpectancy
FROM country
WHERE LifeExpectancy < (
    SELECT AVG(LifeExpectancy)
    FROM country
)
ORDER BY LifeExpectancy ASC;

-- 14 Retrieve the capital cities of countries with a population above 100 million
SELECT Name, Capital
FROM country
WHERE Population > 100000000
ORDER BY Population DESC;

-- 15 Find the continent with the highest number of countries.
SELECT Continent, COUNT(*) AS CountryCount
FROM country
GROUP BY Continent
ORDER BY CountryCount DESC
LIMIT 1;