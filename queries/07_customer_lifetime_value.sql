/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Which customers have the highest lifetime value?
*/

WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS lifetime_value
    FROM
        customer c
        JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    ranking,
    customer_id,
    first_name,
    last_name,
    lifetime_value
FROM
    (
        SELECT
            ROW_NUMBER() OVER (
                ORDER BY
                    lifetime_value DESC
            ) AS ranking,
            customer_id,
            first_name,
            last_name,
            lifetime_value
        FROM
            customer_metrics
    ) ranked
WHERE
    ranking <= 10
ORDER BY
    ranking;
/*
 Project: DVD Rental Business Performance Analysis
 Author: Burcu Süzer
 
 Bonus Business Question:
 What percentage of the total revenue does each customer contribute?
 */
WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS lifetime_value
    FROM
        customer c
        JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),
overall_metrics AS (
    SELECT
        SUM(lifetime_value) AS total_lifetime_value
    FROM
        customer_metrics
)
SELECT
    ranking,
    customer_id,
    first_name,
    last_name,
    lifetime_value,
    lifetime_value_pct
FROM
    (
        SELECT
            ROW_NUMBER() OVER (
                ORDER BY
                    c.lifetime_value DESC
            ) AS ranking,
            c.customer_id,
            c.first_name,
            c.last_name,
            c.lifetime_value AS lifetime_value,
            ROUND(
                c.lifetime_value * 100 / o.total_lifetime_value,
                2
            ) AS lifetime_value_pct
        FROM
            customer_metrics c
            CROSS JOIN overall_metrics o
    ) ranked
WHERE
    ranking <= 10
ORDER BY
    ranking;