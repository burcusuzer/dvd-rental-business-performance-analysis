/*
View: vw_store_performance
Purpose:
Provides executive-level KPIs for the Power BI dashboard.
Used for KPI cards including revenue, rentals, customers,
and average revenue per customer.
*/

CREATE OR REPLACE VIEW vw_store_performance AS

SELECT
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue,
    COUNT(r.rental_id) AS total_rentals
FROM store s
JOIN staff st
    ON s.store_id = st.store_id
JOIN payment p
    ON st.staff_id = p.staff_id
JOIN rental r
    ON p.rental_id = r.rental_id
GROUP BY
    s.store_id
ORDER BY
    total_revenue DESC;