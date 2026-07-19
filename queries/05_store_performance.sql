/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Which store generates the highest revenue?
*/
WITH store_metrics AS (
    SELECT 
        c.city, 
        sto.store_id, 
        SUM(p.amount) AS revenue
    FROM payment p
    JOIN staff sta ON
        p.staff_id = sta.staff_id
    JOIN store sto ON
        sta.store_id = sto.store_id
    JOIN address a ON
        sto.address_id = a.address_id
    JOIN city c ON
        a.city_id = c.city_id
    GROUP BY
        c.city, sto.store_id
)
SELECT 
    store_id,
    city,  
    revenue
FROM (
    SELECT 
        city, 
        store_id, 
        revenue, 
        RANK() OVER (ORDER BY revenue DESC) AS ranking
    FROM 
        store_metrics
     ) ranked
WHERE ranking = 1;

/*
Bonus Business Question:
What percentage of total revenue does each store generate?
*/
WITH store_metrics AS (
    SELECT 
        c.city, 
        sto.store_id, 
        SUM(p.amount) AS revenue
    FROM 
        payment p
    JOIN staff sta 
        ON p.staff_id = sta.staff_id
    JOIN store sto 
        ON sta.store_id = sto.store_id
    JOIN address a 
        ON sto.address_id = a.address_id
    JOIN city c 
        ON a.city_id = c.city_id
    GROUP BY
        c.city, sto.store_id
)
SELECT 
    RANK() OVER (ORDER BY revenue DESC) AS store_rank, 
    store_id,
    city, 
    revenue, 
    ROUND (revenue * 100 / Sum(revenue) OVER(),2) store_revenue_pct
FROM 
    store_metrics
ORDER BY
    store_rank;