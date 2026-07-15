/*
Project: DVD Rental Business Performance Analysis
Author: Burcu Süzer

Business Question:
Which customer cities generate the highest revenue?
*/

WITH city_metrics
     AS (SELECT ci.city       AS customer_city,
                Sum(p.amount) AS revenue
         FROM   city ci
                JOIN address a
                  ON ci.city_id = a.city_id
                JOIN customer c
                  ON c.address_id = a.address_id
                JOIN payment p
                  ON c.customer_id = p.customer_id
         GROUP  BY ci.city)
SELECT *
FROM   (SELECT *,
               Rank()
                 OVER(
                   ORDER BY revenue DESC) AS ranking
        FROM   city_metrics) ranked
WHERE  ranking = 1; 

/*
Bonus Business Question:
What percentage of total revenue does each customer city generate?
*/

WITH city_metrics
     AS (SELECT ci.city       AS customer_city,
                Sum(p.amount) AS revenue
         FROM   city ci
                JOIN address a
                  ON ci.city_id = a.city_id
                JOIN customer c
                  ON c.address_id = a.address_id
                JOIN payment p
                  ON c.customer_id = p.customer_id
         GROUP  BY ci.city)

select customer_city, revenue, 
	rank()over(order by revenue desc) as ranking,
	round( revenue *100 / sum(revenue) over() ,2) as revenue_share_pct
    from city_metrics
    order by revenue desc;

