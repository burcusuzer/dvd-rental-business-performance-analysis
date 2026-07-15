/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Which film categories generate the highest revenue?
*/

WITH category_metrics AS (

SELECT
    c.category_id,
    c.name AS category_name,
    SUM(p.amount) AS revenue

FROM category c
JOIN film_category fc USING(category_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
JOIN payment p USING(rental_id)

GROUP BY c.category_id, c.name

)

SELECT *
FROM (
    SELECT *,
           RANK() OVER (ORDER BY revenue DESC) AS ranking
    FROM category_metrics
) ranked
WHERE ranking = 1;

/*
Bonus Business Question:
What percentage of the total revenue does each category generate?
*/


WITH category_metrics AS (
    SELECT
        c.category_id,
        c.name,
        SUM(p.amount) AS revenue
    FROM category c
    JOIN film_category fc USING (category_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    JOIN payment p USING (rental_id)
    GROUP BY c.category_id, c.name
)

SELECT *,
       ROUND(revenue * 100 / SUM(revenue) OVER (), 2) AS revenue_share_pct
FROM category_metrics
ORDER BY revenue DESC;

