-- ========================================================
-- Project Title : Film Popularity Analysis using Sakila DB
-- Dataset		 : Sakila Sample Database
-- Author		 : Paskah Sitohang
-- Tool		     : MySQL Workbench
-- Date		     : Thursday, 17 July 2025
-- Description   : Analyze film popularity based on rental
--                 frequency and categorize by genre
-- ========================================================

-- STEP 1: Load and Review the Database
use sakila;

-- ========================================================
-- STEP 2: Analyze Film Popularity
-- ========================================================

-- Total Number of Rentals/Film (with Ranking)
SELECT 
    f.title AS film_title,
    COUNT(r.rental_id) AS total_rentals,
    RANK() OVER (ORDER BY COUNT(r.rental_id) DESC) AS film_rank
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title;
-- Total Number of Rentals/Genre (with Ranking)
SELECT 
    c.name AS genre,
    COUNT(r.rental_id) AS total_rentals,
    RANK() OVER (ORDER BY COUNT(r.rental_id) DESC) AS genre_rank
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- ========================================================
-- STEP 3: Evaluate Customer Behavior
-- ========================================================
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(r.rental_id) AS total_rentals,
    SUM(p.amount) AS total_revenue,
    
    -- Customer segmentation based on total spending
    CASE 
        WHEN SUM(p.amount) >= 200 THEN 'High Spender'
        WHEN SUM(p.amount) >= 100 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS spending_segment

FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC;

-- ========================================================
-- STEP 4: Analyze Rental Trends
-- ========================================================
SELECT 
    YEAR(r.rental_date) AS rental_year,
    MONTH(r.rental_date) AS rental_month,
    COUNT(r.rental_id) AS total_rentals,
    SUM(p.amount) AS total_revenue
FROM rental r
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY YEAR(r.rental_date), MONTH(r.rental_date)
ORDER BY rental_year, rental_month;

-- ========================================================
-- STEP 5: Calculate Revenue
-- ========================================================

-- Total Revenue/Film (with Ranking)
SELECT 
    f.title AS film_title,
    SUM(p.amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS film_rank
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title;

-- Total Revenue/Genre (with Ranking)
SELECT 
    c.name AS genre,
    SUM(p.amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS genre_rank
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Total Revenue/Store (with Ranking)
SELECT 
    s.store_id,
    CONCAT(c.city, ', ', co.country) AS store_location,
    SUM(p.amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS store_rank
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
GROUP BY s.store_id, store_location;

-- Total Revenue/Staff (with Ranking)
SELECT 
    st.staff_id,
    CONCAT(st.first_name, ' ', st.last_name) AS staff_name,
    SUM(p.amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS staff_rank
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
GROUP BY st.staff_id, staff_name;

-- ========================================================
-- STEP 6: Assess Late Returns
-- ========================================================
SELECT 
    r.rental_id,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    f.title AS film_title,
    f.rental_duration,
    DATEDIFF(r.return_date, r.rental_date) AS actual_days_rented,
    
    -- Calculate delays
    CASE 
        WHEN DATEDIFF(r.return_date, r.rental_date) > f.rental_duration 
        THEN DATEDIFF(r.return_date, r.rental_date) - f.rental_duration
        ELSE 0
    END AS days_late,
    
    -- Estimated penalty loss ($1/day late)
    CASE 
        WHEN DATEDIFF(r.return_date, r.rental_date) > f.rental_duration 
        THEN (DATEDIFF(r.return_date, r.rental_date) - f.rental_duration) * 1.00
        ELSE 0.00
    END AS estimated_late_fee_loss

FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
  AND DATEDIFF(r.return_date, r.rental_date) > f.rental_duration
ORDER BY estimated_late_fee_loss DESC;

-- Aggregate/Customer
SELECT 
    SUM(
        CASE 
            WHEN DATEDIFF(r.return_date, r.rental_date) > f.rental_duration 
            THEN (DATEDIFF(r.return_date, r.rental_date) - f.rental_duration)
            ELSE 0
        END
    ) AS total_days_late,
    SUM(
        CASE 
            WHEN DATEDIFF(r.return_date, r.rental_date) > f.rental_duration 
            THEN (DATEDIFF(r.return_date, r.rental_date) - f.rental_duration) * 1.00
            ELSE 0.00
        END
    ) AS total_estimated_loss
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL;
-- ========================================================
-- END OF PROJECT 1
-- ========================================================
