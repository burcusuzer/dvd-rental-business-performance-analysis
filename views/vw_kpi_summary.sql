/*
View: vw_kpi_summary

Purpose:
Provides executive-level KPIs for the Power BI dashboard.
Used for KPI cards including revenue, rentals, customers,
and average revenue per customer.
*/

CREATE OR REPLACE VIEW vw_kpi_summary AS

SELECT
    SUM(p.amount) AS total_revenue,
    COUNT(r.rental_id) AS total_rentals,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(SUM(p.amount) / COUNT(DISTINCT c.customer_id), 2) AS average_revenue_per_customer
FROM payment p
JOIN rental r
    ON p.rental_id = r.rental_id
JOIN customer c
    ON p.customer_id = c.customer_id;

