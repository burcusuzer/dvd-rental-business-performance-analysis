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
        ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)), 1) AS average_rental_days,
        f.rental_duration AS allowed_rental_days
    FROM
        film f
    JOIN 
        inventory i
        ON f.film_id = i.film_id 
    JOIN 
        rental r
        ON i.inventory_id = r.inventory_id 
    WHERE 
        r.return_date IS NOT NULL
    GROUP BY 
        f.film_id, 
        f.title,
        f.rental_duration
)
SELECT 
    film_id,
    film_title,
    total_rentals,
    average_rental_days,
    allowed_rental_days
FROM 
    rental_metrics
ORDER BY
    average_rental_days DESC;

/*
Bonus Business Question:
Which films have the highest late return rate compared to their allowed rental duration?
*/

WITH late_return_metrics AS (
SELECT 
    f.film_id,
    f.title AS film_title,
    COUNT(*) AS total_rentals,
   f.rental_duration AS allowed_rental_days,
    SUM(
        CASE
            WHEN DATEDIFF(r.return_date, r.rental_date) > f.rental_duration THEN 1
            ELSE 0
        END
    ) AS late_returns
FROM
    film f
JOIN
    inventory i
    ON f.film_id = i.film_id 
JOIN rental r
    ON i.inventory_id = r.inventory_id
WHERE 
    r.return_date IS NOT NULL    
GROUP BY 
    f.film_id, 
    f.title,
    f.rental_duration
)
SELECT 
    film_id,
    film_title,
    allowed_rental_days,
    late_returns,
    ROUND(late_returns * 100 / total_rentals, 2) AS late_return_rate_pct
FROM 
    late_return_metrics
ORDER BY 
    late_return_rate_pct DESC;

/*
Bonus Business Question (2):
Among late returns, which films have the highest average delay beyond the allowed rental duration?
*/

WITH late_return_metrics AS (
    SELECT
        f.film_id,
        f.title AS film_title,
        f.rental_duration AS allowed_rental_days,
        COUNT(*) AS late_returns,
        ROUND(AVG(DATEDIFF(r.return_date, r.rental_date) - f.rental_duration),2) AS average_delay_days
    FROM
        film f
    JOIN inventory i
        ON f.film_id = i.film_id
    JOIN rental r
        ON i.inventory_id = r.inventory_id
    WHERE
        r.return_date IS NOT NULL
        AND DATEDIFF(r.return_date, r.rental_date) > f.rental_duration
    GROUP BY
        f.film_id,
        f.title,
        f.rental_duration
)
SELECT
    film_id,
    film_title,
    allowed_rental_days,
    late_returns,
    average_delay_days
FROM
    late_return_metrics
ORDER BY
    average_delay_days DESC;