/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Which customer cities generate the highest revenue?
*/

WITH city_metrics AS (
    SELECT
        ci.city AS customer_city,
        SUM(p.amount) AS total_revenue
    FROM
        city ci
    JOIN address a 
        ON ci.city_id = a.city_id
    JOIN customer c 
        ON c.address_id = a.address_id
    JOIN payment p
        ON c.customer_id = p.customer_id
    GROUP BY
        ci.city
)
SELECT 
    RANK() OVER (ORDER BY total_revenue DESC) AS city_rank,
    customer_city,
    total_revenue
FROM
    city_metrics
ORDER BY 
    city_rank;

/*
Bonus Business Question:
What percentage of total revenue does each customer city generate?
*/

WITH city_metrics AS (
    SELECT
        ci.city AS customer_city,
        SUM(p.amount) AS total_revenue
    FROM
        city ci
    JOIN address a 
        ON ci.city_id = a.city_id
    JOIN customer c 
        ON c.address_id = a.address_id
    JOIN payment p
        ON c.customer_id = p.customer_id
    GROUP BY
        ci.city
)
SELECT
    RANK() OVER (ORDER BY total_revenue DESC) AS city_rank,
    customer_city,
    total_revenue,
    ROUND(total_revenue * 100 / SUM(total_revenue) OVER (), 2) AS revenue_share_pct
FROM
    city_metrics
ORDER BY
    city_rank;