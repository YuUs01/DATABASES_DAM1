USE sakila;

START TRANSACTION;

-- Insert a new rental record
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (NOW(), 5, 10, DATE_ADD(NOW(), INTERVAL 7 DAY), 1);

-- Update the inventory to reflect the rental
UPDATE inventory 
SET last_update = NOW()
WHERE inventory_id = 5;

-- Commit the transaction
COMMIT;
