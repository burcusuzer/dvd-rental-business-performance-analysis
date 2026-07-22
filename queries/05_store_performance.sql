/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Which store generates the highest revenue?
*/
WITH store_metrics AS (
    SELECT 
        s.store_id, 
        c.city,
        SUM(p.amount) AS total_revenue
    FROM 
        payment p
    JOIN 
        staff st
        ON p.staff_id = st.staff_id
    JOIN 
        store s
        ON st.store_id = s.store_id
    JOIN 
        address a
        ON s.address_id = a.address_id
    JOIN 
        city c 
        ON a.city_id = c.city_id
    GROUP BY
        s.store_id, c.city
),
ranked_stores AS (
    SELECT 
        RANK() OVER (ORDER BY total_revenue DESC) AS store_rank,
        store_id,
        city,
        total_revenue
    FROM 
        store_metrics
)
SELECT 
    store_rank,
    store_id,
    city,
    total_revenue
FROM
    ranked_stores
WHERE
    store_rank = 1;
        
/*
Bonus Analysis 1

Bonus Business Question:
What percentage of the total revenue does each store contribute?
*/

WITH store_metrics AS (
    SELECT 
        s.store_id, 
        c.city,
        SUM(p.amount) AS total_revenue
    FROM 
        payment p
    JOIN
        staff st
        ON p.staff_id = st.staff_id
    JOIN 
        store s
        ON st.store_id = s.store_id
    JOIN 
        address a 
        ON s.address_id = a.address_id
    JOIN 
        city c 
        ON a.city_id = c.city_id
    GROUP BY
        s.store_id, c.city
)
SELECT
    RANK() OVER (ORDER BY total_revenue DESC) AS store_rank,
    store_id,
    city,
    total_revenue,
    ROUND(total_revenue * 100 / SUM(total_revenue) OVER (), 2) AS revenue_share_pct
FROM
    store_metrics
ORDER BY
    store_rank;