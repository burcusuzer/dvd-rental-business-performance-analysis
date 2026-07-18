/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
What is the average spending per customer?
*/

WITH customer_spending AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_spent
    FROM
        customer c
    JOIN payment p
        ON
        c.customer_id = p.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT
    customer_id,
    customer_name,
    total_spent,
    ROUND(AVG(total_spent) OVER (), 2) AS average_customer_spending
FROM
    customer_spending
ORDER BY
    total_spent DESC;

/*
Bonus Business Question:
Which customers spend above the average customer spending?
*/

WITH customer_spending AS (
    SELECT
            c.customer_id,
            CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
            SUM(p.amount) AS total_spent
    FROM
        customer c
    JOIN payment p
            ON
        c.customer_id = p.customer_id
    GROUP BY
            c.customer_id,
            c.first_name,
            c.last_name
),

avg_spending AS (
    SELECT
        customer_id,
        customer_name,
        total_spent,
        ROUND(AVG(total_spent) OVER (), 2) AS average_customer_spending
    FROM
        customer_spending
)

SELECT 
    customer_id,
    customer_name,
    total_spent,
    average_customer_spending
FROM
    avg_spending
WHERE
    total_spent > average_customer_spending
ORDER BY
    total_spent DESC;