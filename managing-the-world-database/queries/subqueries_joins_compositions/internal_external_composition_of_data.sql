USE world;

-- COMMAND TO FIND COUNTRIES WITH MORE THAN 5 CITIES HAVING POPULATION OVER 1 MILLION
SELECT Name FROM country WHERE Code IN (
    SELECT CountryCode FROM city GROUP BY CountryCode HAVING COUNT(*) > 5
);

-- COMMAND TO FIND COUNTRIES WITH MORE THAN 3 OFFICIAL LANGUAGES
SELECT Name FROM country WHERE Code IN (
    SELECT CountryCode FROM countrylanguage GROUP BY CountryCode HAVING COUNT(*) > 3
);

-- COMMAND TO JOIN CITY, COUNTRY, AND COUNTRYLANGUAGE EXCLUDING ENGLISH
SELECT city.Name, country.Name AS country, countrylanguage.Language 
FROM city 
JOIN country ON city.CountryCode = country.Code 
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Language <> 'English';

-- COMMAND TO FIND TOTAL POPULATION PER COUNTRY USING A DERIVED TABLE
SELECT country.Name, total_population
FROM country
JOIN (
    SELECT CountryCode, SUM(Population) AS total_population
    FROM city GROUP BY CountryCode
) AS city_population ON country.Code = city_population.CountryCode;
