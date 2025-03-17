USE sakila;

-- Add foreign key for customer in rental
ALTER TABLE rental
ADD CONSTRAINT fk_rental_customer
FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
ON DELETE CASCADE;

-- Add foreign key for inventory in rental
ALTER TABLE rental
ADD CONSTRAINT fk_rental_inventory
FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id)
ON DELETE CASCADE;

-- Add foreign key for staff in rental
ALTER TABLE rental
ADD CONSTRAINT fk_rental_staff
FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
ON DELETE CASCADE;

-- Add foreign key for customer in payment
ALTER TABLE payment
ADD CONSTRAINT fk_payment_customer
FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
ON DELETE CASCADE;

-- Add foreign key for staff in payment
ALTER TABLE payment
ADD CONSTRAINT fk_payment_staff
FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
ON DELETE CASCADE;

-- Add foreign key for film in inventory
ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_film
FOREIGN KEY (film_id) REFERENCES film (film_id)
ON DELETE CASCADE;

-- Add foreign key for store in inventory
ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_store
FOREIGN KEY (store_id) REFERENCES store (store_id)
ON DELETE CASCADE;

DELIMITER $$

CREATE TRIGGER check_film_exists_before_rental
BEFORE INSERT ON rental
FOR EACH ROW
BEGIN
    DECLARE film_exists INT;
    
    -- Check if the film exists
    SELECT COUNT(*) INTO film_exists
    FROM inventory
    WHERE inventory_id = NEW.inventory_id;
    
    IF film_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Film does not exist in inventory!';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER prevent_deleting_customer_with_rentals
BEFORE DELETE ON customer
FOR EACH ROW
BEGIN
    DECLARE rental_count INT;
    
    -- Check if there are any active rentals for this customer
    SELECT COUNT(*) INTO rental_count
    FROM rental
    WHERE customer_id = OLD.customer_id AND return_date IS NULL;
    
    IF rental_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer has active rentals and cannot be deleted!';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER log_inventory_deletions
AFTER DELETE ON inventory
FOR EACH ROW
BEGIN
    INSERT INTO inventory_log (inventory_id, film_id, store_id, deleted_at)
    VALUES (OLD.inventory_id, OLD.film_id, OLD.store_id, NOW());
END $$

DELIMITER ;

