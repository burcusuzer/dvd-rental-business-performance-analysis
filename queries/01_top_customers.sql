/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Who are the top 10 customers by total revenue?
*/

WITH customer_metrics AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer c
    JOIN 
        payment p
        ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),
ranked_customers AS (
    SELECT 
        RANK() OVER (ORDER BY total_revenue DESC) AS customer_rank,
        customer_id,
        customer_name,
        total_revenue
    FROM 
        customer_metrics
)
SELECT
    customer_rank,
    customer_id,
    customer_name,
    total_revenue
FROM
    ranked_customers
WHERE 
    customer_rank <= 10
ORDER BY 
    customer_rank;

/*
Bonus Business Question:
What percentage of the total revenue does each of the top 10 customers contribute?
*/

WITH customer_metrics AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer c
    JOIN 
        payment p
        ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),
ranked_customers AS (
    SELECT 
        RANK() OVER (ORDER BY total_revenue DESC) AS customer_rank,
        customer_id,
        customer_name,
        total_revenue
    FROM 
        customer_metrics
),
revenue_metrics AS (
    SELECT
        SUM(total_revenue) AS overall_revenue
    FROM
        customer_metrics
)
SELECT
    rc.customer_rank,
    rc.customer_id,
    rc.customer_name,
    rc.total_revenue,
    ROUND(rc.total_revenue * 100 / rm.overall_revenue, 2) AS revenue_share_pct
FROM
    ranked_customers rc
CROSS JOIN
    revenue_metrics rm
WHERE
    rc.customer_rank <= 10
ORDER BY
    rc.customer_rank;