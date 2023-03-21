USE sakila;

# 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country 
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.address
JOIN country AS co ON c.country_id = co.country_id;     

# 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, CONCAT('$', SUM(p.amount)) AS total_amount
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY store_id
ORDER BY store_id;

# 3. What is the average running time of films by category?
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_runtime
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name;

# 4. Which film categories are longest?
# I suppose it's meant which category is on average the longest...
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_runtime
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_runtime DESC
LIMIT 1;

# 5. Display the most frequently rented movies in descending order.
SELECT f.title, SUM(r.rental_id) AS num_rentals 
FROM film AS f
JOIN inventory as i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY num_rentals DESC;

# 6. List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount) AS gross_revenue 
FROM category AS c
JOIN film_category as fc ON c.category_id = fc.category_id
JOIN inventory as i ON fc.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment as p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC;

# 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, s.store_id
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN store AS s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.title, s.store_id;
# Yes, it is.