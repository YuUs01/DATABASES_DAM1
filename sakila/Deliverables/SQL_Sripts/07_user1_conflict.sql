USE sakila;

-- Create the products table with a version column for optimistic locking
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    stock_quantity INT,
    version INT DEFAULT 1
);

-- Insert an initial product record
INSERT INTO products (product_id, product_name, stock_quantity, version)
VALUES (1, 'Product A', 10, 1);

-- User 1's Transaction
START TRANSACTION;

-- User 1: Read the record (assume version = 1)
SELECT product_name, stock_quantity, version FROM products WHERE product_id = 1;

-- User 1: Attempt to update the record (version = 1)
UPDATE products
SET stock_quantity = 15, version = version + 1
WHERE product_id = 1 AND version = 1;

-- Commit User 1's transaction
COMMIT;

