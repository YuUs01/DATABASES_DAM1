USE world;

-- COMMAND TO CREATE A VIEW SHOWING CITIES WITH POPULATION OVER 1 MILLION
CREATE VIEW high_population_cities AS
SELECT name, countrycode, population FROM city 
WHERE population > 1000000;

-- COMMAND TO CREATE A VIEW THAT SHOWS COUNTRIES WITH LANGUAGES EXCLUDING ENGLISH
CREATE VIEW countries_with_languages AS
SELECT country.Name AS country_name, countrylanguage.Language 
FROM country 
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Language <> 'English';

-- COMMAND TO CREATE A NEW USER WITH SPECIFIC PRIVILEGES
CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'password';

-- GRANTING READ ACCESS TO CITY AND COUNTRY TABLES
GRANT SELECT ON world.city TO 'db_user'@'localhost';
GRANT SELECT ON world.country TO 'db_user'@'localhost';

-- GRANTING WRITE ACCESS TO CITY TABLE
GRANT INSERT, UPDATE ON world.city TO 'db_user'@'localhost';

-- REVOKING WRITE ACCESS TO COUNTRY TABLE
REVOKE INSERT, UPDATE ON world.country FROM 'db_user'@'localhost';

-- GRANTING FULL ACCESS TO HIGH_POPULATION_CITIES VIEW
GRANT SELECT ON world.high_population_cities TO 'db_user'@'localhost';
