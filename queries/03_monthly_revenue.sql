/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
How does monthly revenue trend over time?
*/

SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM
    payment
GROUP BY
    DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY
    month;

/*
Bonus Business Question:
How did monthly revenue change compared to the previous month?
*/

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(payment_date, '%Y-%m') AS month,
        SUM(amount) AS total_revenue
    FROM
        payment
    GROUP BY
        DATE_FORMAT(payment_date, '%Y-%m')
),
monthly_change AS (
    SELECT 
        month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM
        monthly_revenue
)
SELECT 
    month,
    total_revenue,
    previous_month_revenue,
    ROUND((total_revenue - previous_month_revenue) * 100 / previous_month_revenue, 2) AS revenue_change_pct
FROM 
    monthly_change
ORDER BY
    month;

/*
Bonus Business Question(2):
Which months performed above the average monthly revenue?
*/
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(payment_date, '%Y-%m') AS month,
        SUM(amount) AS total_revenue
    FROM
        payment
    GROUP BY 
        DATE_FORMAT(payment_date, '%Y-%m')
),
average_revenue AS (
    SELECT 
        AVG(total_revenue) AS avg_revenue
    FROM 
        monthly_revenue
)
SELECT 
    mr.month,
    mr.total_revenue
FROM
    monthly_revenue mr
CROSS JOIN 
    average_revenue ar
WHERE 
    mr.total_revenue > ar.avg_revenue
ORDER BY
    mr.total_revenue DESC;