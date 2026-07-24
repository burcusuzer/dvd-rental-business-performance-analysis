CREATE OR REPLACE VIEW vw_customer_city_revenue AS

SELECT
    ci.city,
    ROUND(SUM(p.amount),2) AS total_revenue,
    COUNT(r.rental_id) AS total_rentals
FROM payment p
JOIN rental r
    ON p.rental_id = r.rental_id
JOIN customer c
    ON r.customer_id = c.customer_id
JOIN address a
    ON c.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
GROUP BY
    ci.city
ORDER BY
    total_revenue DESC
LIMIT 10;