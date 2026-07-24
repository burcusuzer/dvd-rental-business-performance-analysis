/*
View: vw_monthly_revenue

Purpose:
Provides executive-level KPIs for the Power BI dashboard.
Used for KPI cards including revenue, rentals, customers,
and average revenue per customer.
*/

CREATE OR REPLACE VIEW vw_monthly_revenue AS

SELECT
    YEAR(payment_date) AS rental_year,
    MONTH(payment_date) AS rental_month,
    DATE_FORMAT(payment_date, '%Y-%m') AS month_year,
    COUNT(payment_id) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payment
GROUP BY
    YEAR(payment_date),
    MONTH(payment_date),
    DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY
    rental_year,
    rental_month;