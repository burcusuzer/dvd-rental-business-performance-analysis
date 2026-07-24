/*
View: vw_category_revenue

Purpose:
Provides executive-level KPIs for the Power BI dashboard.
Used for KPI cards including revenue, rentals, customers,
and average revenue per customer.
*/

CREATE OR REPLACE VIEW vw_category_revenue AS

SELECT
    c.name AS category,
    ROUND(SUM(p.amount), 2) AS total_revenue,
    COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN inventory i
    ON fc.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY
    c.category_id,
    c.name
ORDER BY
    total_revenue DESC;