CREATE OR REPLACE VIEW vw_customer_kpis AS

SELECT
    ROUND(AVG(customer_total),2) AS average_clv
FROM (
    SELECT
        customer_id,
        SUM(amount) AS customer_total
    FROM payment
    GROUP BY customer_id
) t;