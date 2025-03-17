USE sakila;

INSERT INTO actor (first_name, last_name, last_update)
VALUES ("Mike", "Nini", NOW());
 
 -- This command is used to let us update without any restrictions (only used in safe spaces)
SET SQL_SAFE_UPDATES = 0;

-- This command is used to change the value "last_name" where the first name is the same as the one we would like to change
UPDATE actor
SET last_name = 'Calico'
WHERE first_name = 'Mike';

-- This command deletes all the data from the actor table if the conditions are met
DELETE 	FROM actor
WHERE last_name = 'Calico';	