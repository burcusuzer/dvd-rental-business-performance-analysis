/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Which repeat customers have the highest number of rentals?
*/

WITH repeat_customer_metrics AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(r.rental_id) AS total_rentals
    FROM 
        customer c
    JOIN    
        rental r 
        ON c.customer_id = r.customer_id 
    GROUP BY 
        c.customer_id,
        c.first_name,
        c.last_name
    HAVING 
        COUNT(r.rental_id) > 1
),
ranked_customers AS (
    SELECT 
        DENSE_RANK() OVER (ORDER BY total_rentals DESC) AS customer_rank,
        customer_id,
        customer_name,
        total_rentals
    FROM
        repeat_customer_metrics
)
SELECT 
    customer_rank,
    customer_id,
    customer_name,
    total_rentals
FROM
    ranked_customers
ORDER BY 
    customer_rank;
    
/*
Bonus Business Question:
What percentage of customers are repeat customers?
*/

WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(r.rental_id) AS total_rentals
    FROM 
        customer c
    JOIN    
        rental r 
        ON c.customer_id = r.customer_id 
    GROUP BY 
        c.customer_id,
        c.first_name,
        c.last_name
),
customer_types AS (
    SELECT
        COUNT(*) AS total_customers,
        SUM(
            CASE
                WHEN total_rentals > 1 THEN 1
                ELSE 0
            END
            ) AS repeat_customers
    FROM
        customer_metrics
)
SELECT
    total_customers,
    repeat_customers,
    ROUND(repeat_customers * 100 / total_customers, 2) AS repeat_customer_rate_pct
FROM 
    customer_types;

/*
Bonus Business Question (2):
How are repeat customers distributed by rental frequency?
*/
WITH customer_rentals AS (
    SELECT 
        c.customer_id,
        COUNT(r.rental_id) AS total_rentals
    FROM 
        customer c
    JOIN    
        rental r 
        ON c.customer_id = r.customer_id 
    GROUP BY 
        c.customer_id        
),
rental_ranges AS (
    SELECT  
        customer_id,
        total_rentals,
        CASE 
            WHEN total_rentals < 20 THEN '1-19 Rentals'
            WHEN total_rentals < 30 THEN '20-29 Rentals'
            WHEN total_rentals < 40 THEN '30-39 Rentals'
            ELSE '40+ Rentals'
        END AS rental_range,
        CASE 
            WHEN total_rentals < 20 THEN 1
            WHEN total_rentals < 30 THEN 2
            WHEN total_rentals < 40 THEN 3
            ELSE 4
        END AS rental_range_order
    FROM 
        customer_rentals
)
SELECT
    rental_range,
    COUNT(*) AS customer_count
FROM 
    rental_ranges
GROUP BY 
    rental_range,
    rental_range_order
ORDER BY
    rental_range_order;
        


