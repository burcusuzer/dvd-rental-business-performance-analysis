/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Who are the top 10 customers by lifetime value (CLV)?
*/



WITH customer_metrics AS (
    SELECT  
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(r.rental_id) AS total_rentals,
        SUM(p.amount) AS lifetime_value,
        MIN(r.rental_date) AS first_rental,
        MAX(r.rental_date) AS last_rental
    FROM 
        customer c
    JOIN rental r 
        ON
        c.customer_id = r.customer_id
    JOIN payment p
        ON
        p.rental_id = r.rental_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),

ranked_customers AS (
    SELECT 
        customer_id,
        customer_name,
        total_rentals,
        lifetime_value,
        first_rental,
        last_rental,
        RANK() OVER(ORDER BY lifetime_value DESC) AS customer_rank
    FROM 
        customer_metrics
)

SELECT
    customer_rank,
    customer_id,
    customer_name,
    total_rentals,
    lifetime_value,
    first_rental,
    last_rental
FROM
    ranked_customers
WHERE
    customer_rank <= 10
ORDER BY
    customer_rank;

/*
 Project: DVD Rental Business Performance Analysis
 Author: Burcu Süzer
 
 Bonus Business Question:
 Which customers have a lifetime value above the average customer lifetime value?
 */


WITH customer_metrics AS (
    SELECT  
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(r.rental_id) AS total_rentals,
        SUM(p.amount) AS lifetime_value,
        MIN(r.rental_date) AS first_rental,
        MAX(r.rental_date) AS last_rental
    FROM 
        customer c
    JOIN rental r 
        ON
        c.customer_id = r.customer_id
    JOIN payment p
        ON
        p.rental_id = r.rental_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),

average_lifetime_value AS (
    SELECT 
        AVG(lifetime_value) AS avg_clv
    FROM 
        customer_metrics
)

SELECT 
    cm.customer_id,
    cm.customer_name,
    cm.total_rentals,
    cm.lifetime_value,
    cm.first_rental,
    cm.last_rental
FROM 
    customer_metrics cm
CROSS JOIN 
    average_lifetime_value alv
WHERE
    cm.lifetime_value > alv.avg_clv
ORDER BY
    cm.lifetime_value DESC;