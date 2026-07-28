/*
View: vw_customer_lifetime_value

Purpose:
Provides the top 10 customers ranked by lifetime revenue
for the Customer Analytics dashboard.
*/

CREATE OR REPLACE VIEW vw_customer_lifetime_value AS

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(p.amount), 2) AS lifetime_value
FROM customer c
JOIN payment p
    ON c.customer_id = p.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    lifetime_value DESC
LIMIT 10;