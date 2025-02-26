USE world;

START TRANSACTION;
INSERT INTO city (Name, CountryCode, District, Population) VALUES ('RollbackCity', 'USA', 'TestDistrict', 500000);
SELECT * FROM city WHERE Name = 'RollbackCity';
ROLLBACK;

-- COMMAND TO PERFORM MULTIPLE TRANSACTIONS AND COMMIT IF SUCCESSFUL
START TRANSACTION;
INSERT INTO city (Name, CountryCode, District, Population) VALUES ('NewCity', 'USA', 'TestDistrict', 600000);
UPDATE country SET Population = Population + 600000 WHERE Code = 'USA';
COMMIT;

-- COMMAND TO USE SAVEPOINTS FOR PARTIAL ROLLBACKS
START TRANSACTION;
INSERT INTO city (Name, CountryCode, District, Population) VALUES ('PartialCity', 'USA', 'TestDistrict', 700000);
SAVEPOINT before_update;
UPDATE country SET Population = Population + 700000 WHERE Code = 'USA';
ROLLBACK TO SAVEPOINT before_update;
COMMIT;
