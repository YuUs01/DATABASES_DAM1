USE sakila;

-- Customers who rented in the last 30 days
SELECT DISTINCT customer_id, first_name, last_name, email
FROM customer
WHERE customer_id IN (
    SELECT customer_id FROM rental
    WHERE rental_date >= CURDATE() - INTERVAL 30 DAY
);

-- Most rented film
SELECT film_id, title 
FROM film
WHERE film_id = (
    SELECT film_id FROM inventory
    JOIN rental USING (inventory_id)
    GROUP BY film_id
    ORDER BY COUNT(rental_id) DESC
    LIMIT 1
);

-- Total revenue per store
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
JOIN customer USING (customer_id)
GROUP BY store_id
ORDER BY total_revenue DESC;

