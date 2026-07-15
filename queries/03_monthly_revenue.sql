/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
How has monthly revenue changed over time?
*/

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS revenue
FROM
    payment
GROUP BY month
ORDER BY month;
