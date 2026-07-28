CREATE OR REPLACE VIEW vw_late_return_analysis AS

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
    total_rentals,
    allowed_rental_days,
    late_returns,
    ROUND(late_returns * 100.0 / total_rentals, 2) AS late_return_rate_pct
FROM 
    late_return_metrics
ORDER BY 
    late_return_rate_pct DESC
LIMIT 10;
