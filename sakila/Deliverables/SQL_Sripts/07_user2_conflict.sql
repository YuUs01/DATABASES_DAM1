USE sakila;

-- User 2's Transaction
START TRANSACTION;

-- User 2: Read the record (assume version = 1)
SELECT product_name, stock_quantity, version FROM products WHERE product_id = 1;

-- User 2: Attempt to update the record (version = 1)
UPDATE products
SET stock_quantity = 20, version = version + 1
WHERE product_id = 1 AND version = 1;

-- If User 1 committed before, the version is now 2, and User 2's update will fail
COMMIT;
