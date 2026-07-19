/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
How do film categories rank by total revenue?
*/
WITH category_metrics AS 
(
    SELECT
        c.category_id,
        c.name AS category_name,
        SUM(p.amount) AS total_revenue
    FROM
        category c
    JOIN film_category fc
        USING (category_id)
    JOIN inventory i
        USING (film_id)
    JOIN rental r
        USING (inventory_id)
    JOIN payment p
        USING (rental_id)
    GROUP BY
        c.category_id,
        c.name
)
SELECT
    RANK() OVER (ORDER BY total_revenue DESC) AS category_rank,
    category_id,
    category_name,
    total_revenue
FROM 
    category_metrics
ORDER BY
    category_rank;

/*
Bonus Business Question:
What percentage of the total revenue does each category generate?
*/
WITH category_metrics AS (
    SELECT
        c.category_id,
        c.name AS category_name,
        SUM(p.amount) AS total_revenue
    FROM
        category c
    JOIN film_category fc
        USING (category_id)
    JOIN inventory i
        USING (film_id)
    JOIN rental r
        USING (inventory_id)
    JOIN payment p
        USING (rental_id)
    GROUP BY
        c.category_id,
        c.name
),
ranked_categories AS (
    SELECT
        RANK() OVER (ORDER BY total_revenue DESC) AS category_rank,
        category_id,
        category_name,
        total_revenue
    FROM 
        category_metrics
)
SELECT 
    category_rank,
    category_id,
    category_name,
    total_revenue,
    ROUND(total_revenue * 100 / SUM(total_revenue) OVER (), 2) AS revenue_share_pct
FROM    
    ranked_categories
ORDER BY
    category_rank;
