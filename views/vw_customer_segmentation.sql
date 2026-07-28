/*
View: vw_customer_segmentation
Purpose:
Provides executive-level KPIs for the Power BI dashboard.
Used for KPI cards including revenue, rentals, customers,
and average revenue per customer.
*/

CREATE OR REPLACE VIEW vw_customer_segmentation AS

WITH customer_spending AS (
    SELECT
        c.customer_id,
        ROUND(SUM(p.amount), 2) AS total_spent
    FROM customer c
    JOIN payment p
        ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id
),
customer_segments AS (
    SELECT
        customer_id,
        total_spent,
        NTILE(4) OVER (ORDER BY total_spent DESC) AS spending_quartile
    FROM customer_spending
)
SELECT
    CASE spending_quartile
        WHEN 1 THEN 'Top Spenders'
        WHEN 2 THEN 'High Spenders'
        WHEN 3 THEN 'Medium Spenders'
        WHEN 4 THEN 'Low Spenders'
    END AS spending_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_spent), 2) AS avg_spending,
    ROUND(SUM(total_spent), 2) AS segment_revenue,
    ROUND(
        SUM(total_spent) * 100
        / SUM(SUM(total_spent)) OVER (),
        2
    ) AS revenue_share_pct
FROM customer_segments
GROUP BY
    spending_quartile
ORDER BY
    spending_quartile;