/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Which repeat customers have rented the most films?
*/

WITH customer_metrics AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(r.rental_id) AS total_rentals,
        SUM(p.amount) AS total_spent
    FROM 
        customer c
    JOIN rental r
        ON
        c.customer_id = r.customer_id
    JOIN payment p
        ON
        r.rental_id = p.rental_id
    GROUP BY 
        c.customer_id, 
        c.first_name, 
        c.last_name
)
SELECT
    customer_id,
    customer_name,
    total_rentals,
    total_spent
FROM 
    customer_metrics
WHERE 
    total_rentals > 1
ORDER BY 
    total_rentals DESC,
    total_spent DESC;

/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer
 
Bonus Business Question:
Which repeat customers generated the highest revenue?
*/

WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(r.rental_id) AS total_rentals,
        SUM(p.amount) AS total_spent
    FROM
        customer c
    JOIN rental r
        ON
        c.customer_id = r.customer_id
    JOIN payment p
        ON
        r.rental_id = p.rental_id
    GROUP BY 
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT 
    customer_id,
    customer_name,
    total_rentals,
    total_spent
FROM 
    customer_metrics
WHERE
    total_rentals > 1
ORDER BY
    total_spent DESC;