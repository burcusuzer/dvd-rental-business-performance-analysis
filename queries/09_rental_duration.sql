/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
What is the average rental duration for each film?
*/

WITH rental_metrics AS (
    SELECT
        f.film_id, 
        f.title AS film_title,
        COUNT(r.rental_id) AS total_rentals,
        ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)), 1) AS average_rental_days
    FROM
        film f
    JOIN inventory i
        ON f.film_id = i.film_id 
    JOIN rental r
        ON i.inventory_id = r.inventory_id 
    WHERE r.return_date IS NOT NULL
    GROUP BY 
        f.film_id, 
        f.title
)
SELECT 
    film_id,
    film_title,
    total_rentals,
    average_rental_days
FROM 
    rental_metrics
ORDER BY
    average_rental_days DESC;

/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer
 
Bonus Business Question:
Which films are returned later than the average rental duration?
*/

WITH rental_metrics AS (
    SELECT
        f.film_id, 
        f.title AS film_title,
        COUNT(r.rental_id) AS total_rentals,
        AVG(DATEDIFF(r.return_date, r.rental_date)) AS average_rental_days
    FROM
        film f
    JOIN inventory i
        ON f.film_id = i.film_id 
    JOIN rental r
        ON i.inventory_id = r.inventory_id 
    WHERE r.return_date IS NOT NULL
    GROUP BY 
        f.film_id, 
        f.title
),
overall_avg_rental_days AS (
    SELECT 
        AVG(average_rental_days) AS overall_avg
    FROM
        rental_metrics
)
SELECT 
    rm.film_id,
    rm.film_title,
    rm.total_rentals,
    ROUND(rm.average_rental_days, 1) AS average_rental_days
FROM
    rental_metrics rm
CROSS JOIN 
    overall_avg_rental_days oa
WHERE 
    rm.average_rental_days > oa.overall_avg
ORDER BY
    rm.average_rental_days DESC;
