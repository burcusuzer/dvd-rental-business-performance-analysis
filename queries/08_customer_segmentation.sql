/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
How are customers distributed across spending segments?
*/

WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_spent
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
customer_segments AS (
    SELECT 
        customer_id,
        customer_name,
        total_spent,
        NTILE(4) OVER (ORDER BY total_spent DESC) AS spending_quartile
    FROM 
        customer_metrics
)
SELECT 
    customer_id,
    customer_name,
    total_spent,
    CASE 
        WHEN spending_quartile = 1 THEN 'Top Spenders'
        WHEN spending_quartile = 2 THEN 'High Spenders'
        WHEN spending_quartile = 3 THEN 'Medium Spenders'
        ELSE 'Low Spenders'
    END AS spending_segment
    FROM 
        customer_segments
    ORDER BY 
        total_spent DESC;

/*
Bonus Business Question:
How many customers belong to each spending segment?
*/

WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        SUM(p.amount) AS total_spent
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
customer_segments AS (
    SELECT 
        customer_id,
        total_spent,
        NTILE(4) OVER (ORDER BY total_spent DESC) AS spending_quartile
    FROM 
        customer_metrics
)
SELECT 
    spending_quartile,
    CASE 
        WHEN spending_quartile = 1 THEN 'Top Spenders'
        WHEN spending_quartile = 2 THEN 'High Spenders'
        WHEN spending_quartile = 3 THEN 'Medium Spenders'
        ELSE 'Low Spenders'
    END AS spending_segment,    
    COUNT(*) AS customer_count
FROM 
    customer_segments
GROUP BY
    spending_quartile
ORDER BY
    spending_quartile;

/*
Bonus Business Question (2):
How does each spending segment compare in terms of average customer spending and contribution to total revenue?
*/

WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        SUM(p.amount) AS total_spent
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
customer_segments AS (
    SELECT 
        customer_id,
        total_spent,
        NTILE(4) OVER (ORDER BY total_spent DESC) AS spending_quartile
    FROM 
        customer_metrics
),
segment_metrics AS (
    SELECT 
        spending_quartile,
        CASE 
            WHEN spending_quartile = 1 THEN 'Top Spenders'
            WHEN spending_quartile = 2 THEN 'High Spenders'
            WHEN spending_quartile = 3 THEN 'Medium Spenders'
            ELSE 'Low Spenders'
        END AS spending_segment,    
        COUNT(*) AS customer_count,
        SUM(total_spent) AS total_revenue,
        ROUND(AVG(total_spent), 2) AS average_spending
    FROM 
        customer_segments
    GROUP BY
        spending_quartile
)
SELECT 
    spending_quartile,
    spending_segment,
    customer_count,
    total_revenue,
    average_spending,
    ROUND(total_revenue * 100 / SUM(total_revenue) OVER (), 2) AS revenue_share_pct
FROM 
    segment_metrics
ORDER BY
    spending_quartile;

    
    
    