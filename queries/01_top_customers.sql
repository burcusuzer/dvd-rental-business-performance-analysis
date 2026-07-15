/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Who are the top 10 customers by total revenue?

*/

SELECT 
    cu.customer_id,
    cu.first_name,
    cu.last_name,
    SUM(p.amount) AS revenue
FROM
    customer cu
        JOIN
    payment p ON cu.customer_id = p.customer_id
GROUP BY cu.customer_id , cu.first_name , cu.last_name
ORDER BY revenue DESC
LIMIT 10;
