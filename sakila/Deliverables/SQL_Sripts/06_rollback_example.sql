USE sakila;

START TRANSACTION;

-- Insert a rental record (Step 1)
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (NOW(), 9999, 10, DATE_ADD(NOW(), INTERVAL 7 DAY), 1);

-- Check if the movie is in stock (Step 2)
SELECT COUNT(*) AS inventory_count
FROM inventory
WHERE inventory_id = 9999;

-- As the retrieved data = 0, we have to commit a rollback.

ROLLBACK;