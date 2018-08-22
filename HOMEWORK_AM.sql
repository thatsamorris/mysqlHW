USE sakila;
--1a)
SELECT first_name, last_name FROM actor;
--1b)
SELECT CONCAT(first_name, ' ', last_name) AS Actor_Name FROM actor;
--2a)
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'joe';
--2b)
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';
--2c)
SELECT last_name, first_name FROM actor WHERE last_name LIKE '%LI%';
--2d)
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
--3a)
ALTER TABLE actor ADD middle_name VARCHAR(255) AFTER first_name;
--3b)
ALTER TABLE actor MODIFY middle_name BLOB;
--3c)
ALTER TABLE actor DROP COLUMN middle_name;
--4a)
SELECT last_name, COUNT(last_name) AS name_count FROM actor
GROUP BY last_name;
--4b)
SELECT last_name, COUNT(last_name) AS name_count FROM actor
GROUP BY last_name
HAVING name_count >= 2
--4c)
update actor set first_name='HARPO' where last_name='WILLIAMS' AND first_name='GROUCHO' ;
--4d)
UPDATE actor SET first_name = 'GROUCHO' WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';
--5a)
CREATE TABLE address2 
    ( address_id smallint UNSIGNED NOT NULL AUTO_INCREMENT, address VARCHAR(50), 
     address2 VARCHAR(50), district VARCHAR(20), city_id smallint UNSIGNED,
     postal_code VARCHAR(10), phone VARCHAR(20), location GEOMETRY, last_update TIMESTAMP );
--6a)
SELECT staff.first_name, staff.last_name, address.address
FROM staff JOIN address ON staff.address_id = address.address_id;
--6b)
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS total_sales
FROM staff JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%'
GROUP BY username;
--6c)
SELECT title, COUNT(actor_id) AS actors_in_film
FROM film_actor INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY title;
--6d)
SELECT title, COUNT(inventory.film_id) AS copies
FROM inventory INNER JOIN film ON inventory.film_id = film.film_id
WHERE title = 'Hunchback Impossible'
GROUP BY title;
--6e)
SELECT first_name, last_name, SUM(amount) AS total_paid
FROM payment JOIN customer ON customer.customer_id = payment.customer_id
GROUP BY last_name;
--7a)
 SELECT title 
FROM film 
WHERE language_id IN 
	(SELECT language_id
    FROM language 
    WHERE name = 'English') 
AND title LIKE 'k%' OR title LIKE 'q%';
--7b)
SELECT first_name, last_name
FROM actor
WHERE actor_id IN 
	(SELECT actor_id 
    FROM film_actor
    WHERE film_id IN
		(SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'));
--7c)
select first_name, last_name, email
FROM customer
JOIN address ON customer.address_id=address.address_id
JOIN city ON address.city_id=city.city_id
JOIN country ON city.country_id=country.country_id
WHERE country = 'Canada';
--7d)
SELECT title, name
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';
--7e)
SELECT title, COUNT(rental_id) as 'Times Rented' 
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY title
ORDER BY COUNT(rental_id) DESC;
--7f)
SELECT store.store_id, SUM(amount) AS 'Total sales' FROM store 
JOIN staff on store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store_id;
--7g)
SELECT store_id, address, city, country 
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON c.city_id = a.city_id
JOIN country ON country.country_id = c.country_id;
--7h)
SELECT name, SUM(amount) as 'Gross' FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN inventory i ON i.film_id = fc.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY name
ORDER BY SUM(amount) DESC LIMIT 5;
--8a)
CREATE VIEW TOP_5 AS 
	SELECT name, SUM(amount) as 'Gross' FROM category c
	JOIN film_category fc ON fc.category_id = c.category_id
	JOIN inventory i ON i.film_id = fc.film_id
	JOIN rental r ON r.inventory_id = i.inventory_id
	JOIN payment p ON p.rental_id = r.rental_id
	GROUP BY name
	ORDER BY SUM(amount) DESC LIMIT 5;
--8b)
SELECT * FROM TOP_5;
--8c)
DROP VIEW TOP_5;












    