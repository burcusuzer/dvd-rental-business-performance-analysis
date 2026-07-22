# DVD Rental Business Performance Analysis
A business-oriented SQL portfolio project that analyzes the MySQL Sakila database through 24 analytical queries to uncover customer, revenue, store, and rental insights.

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-025E8C?style=for-the-badge)
![DBeaver](https://img.shields.io/badge/DBeaver-372923?style=for-the-badge)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

## Project Highlights

- 📊 **24 business-focused SQL analyses** across customer, revenue, store, and rental performance
- 💼 **25+ real-world business questions** answered using analytical SQL
- 🧩 Demonstrates advanced SQL techniques including **CTEs, Window Functions, CASE, RANK(), ROW_NUMBER(), NTILE(), LAG(), and Conditional Aggregation**
- 📁 Includes well-structured SQL scripts, CSV outputs, and comprehensive project documentation

## Table of Contents

- [DVD Rental Business Performance Analysis](#dvd-rental-business-performance-analysis)
  - [Project Highlights](#project-highlights)
  - [Table of Contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Business Objectives](#business-objectives)
  - [Dataset](#dataset)
  - [Tools \& Technologies](#tools--technologies)
  - [Project Structure](#project-structure)
  - [SQL Skills Demonstrated](#sql-skills-demonstrated)
    - [SQL Techniques](#sql-techniques)
    - [Business Analytics](#business-analytics)
  - [Business Questions](#business-questions)
    - [Core Analysis](#core-analysis)
    - [Additional Analyses](#additional-analyses)
  - [Sample Results](#sample-results)
    - [01. Top Customers](#01-top-customers)
    - [02. Category Revenue](#02-category-revenue)
    - [03. Monthly Revenue](#03-monthly-revenue)
    - [04. Customer City Revenue](#04-customer-city-revenue)
    - [05. Store Performance](#05-store-performance)
    - [06. Popular Movies](#06-popular-movies)
    - [07. Customer Lifetime Value](#07-customer-lifetime-value)
    - [08. Customer Segmentation](#08-customer-segmentation)
    - [09. Rental Duration](#09-rental-duration)
    - [10. Repeat Customers](#10-repeat-customers)
  - [Key Insights](#key-insights)
  - [Future Improvements](#future-improvements)
  - [Repository Structure](#repository-structure)
  - [About](#about)

## Project Overview

This project analyzes the DVD Rental (Sakila) database to answer real-world business questions related to customer behavior, revenue, store performance, customer segmentation, and rental activity.

Using SQL, this project transforms raw transactional data into meaningful business insights through analytical queries, Common Table Expressions (CTEs), Window Functions, and aggregate calculations.

The goal is to demonstrate practical SQL skills by solving business-oriented problems similar to those encountered by Business Intelligence and Data Analysts.

## Business Objectives

- Identify the highest-value customers based on revenue.
- Analyze revenue trends over time.
- Evaluate store and category performance.
- Measure customer lifetime value (CLV).
- Segment customers according to their spending behavior.
- Analyze rental duration and late return patterns.
- Identify repeat customers and evaluate customer loyalty.
- Support business decision-making using SQL analysis.

## Dataset

This project uses the **Sakila** sample database provided by MySQL, which simulates the operations of a DVD rental business.

The database includes information about customers, films, rentals, payments, stores, staff, inventory, categories, cities, and addresses, making it suitable for practicing business-oriented SQL analysis.

## Tools & Technologies

- SQL
- MySQL
- DBeaver
- Visual Studio Code
- Git
- GitHub

## Project Structure

```text
dvd-rental-business-performance-analysis/
│
├── queries/
│   ├── 01_top_customers.sql
│   ├── 02_category_revenue.sql
│   ├── 03_monthly_revenue.sql
│   ├── 04_customer_city_revenue.sql
│   ├── 05_store_performance.sql
│   ├── 06_popular_movies.sql
│   ├── 07_customer_lifetime_value.sql
│   ├── 08_customer_segmentation.sql
│   ├── 09_rental_duration.sql
│   └── 10_repeat_customers.sql
│
├── results/
│   ├── 01_top_customers.csv
│   ├── 02_category_revenue.csv
│   ├── ...
│   └── 10_repeat_customers.csv
│
└── README.md
```

## SQL Skills Demonstrated

### SQL Techniques
- Complex JOIN operations
- Common Table Expressions (CTEs)
- Aggregate Functions
- Window Functions
  - RANK()
  - ROW_NUMBER()
  - NTILE()
  - LAG()
  - SUM() OVER()
  - AVG() OVER()
- CASE Expressions
- Conditional Aggregation
- Date Functions

### Business Analytics
- Customer Segmentation
- Revenue Analysis
- Business KPI Calculations

## Business Questions

### Core Analysis

| File | Business Question |
|------|-------------------|
| 01 | Who are the top customers by total revenue? |
| 02 | Which film categories generate the highest revenue? |
| 03 | How does monthly revenue trend over time? |
| 04 | Which customer cities generate the highest revenue? |
| 05 | Which store generates the highest revenue? |
| 06 | Which are the top 10 most frequently rented movies? |
| 07 | Who are the top customers by lifetime value (CLV)? |
| 08 | How are customers distributed across spending segments? |
| 09 | What is the average rental duration for each film? |
| 10 | Which repeat customers have the highest number of rentals? |

### Additional Analyses

- Calculate each top customer's contribution to total revenue.
- Measure each category's share of total revenue.
- Compare monthly revenue with the previous month using `LAG()`.
- Identify months that performed above the average monthly revenue.
- Calculate each customer city's contribution to total revenue.
- Measure each store's contribution to total revenue.
- Calculate the percentage of total revenue generated by the top 10 rented movies.
- Identify customers whose lifetime value is above average.
- Analyze customer spending using quartile-based segmentation with `NTILE()`.
- Compare spending segments by average spending and revenue contribution.
- Measure late return rates against allowed rental duration.
- Calculate the average delay beyond the allowed rental duration.
- Calculate the repeat customer rate.
- Analyze repeat customers by rental frequency.

## Sample Results

### 01. Top Customers

- Main Analysis: `results/01_top_customers.csv`
- Revenue Contribution of Top Customers: `results/01_top_customer_revenue_share.csv`

---

### 02. Category Revenue

- Main Analysis: `results/02_category_revenue.csv`
- Revenue Share by Category: `results/02_category_revenue_share.csv`

---

### 03. Monthly Revenue

- Main Analysis: `results/03_monthly_revenue.csv`
- Month-over-Month Revenue Change: `results/03_monthly_revenue_mom_change.csv`
- Above-Average Revenue Months: `results/03_monthly_revenue_above_average.csv`

---

### 04. Customer City Revenue

- Main Analysis: `results/04_customer_city_revenue.csv`
- Revenue Share by Customer City: `results/04_customer_city_revenue_share.csv`

---

### 05. Store Performance

- Main Analysis: `results/05_store_performance.csv`
- Revenue Share by Store: `results/05_store_revenue_share.csv`

---

### 06. Popular Movies

- Main Analysis: `results/06_popular_movies.csv`
- Revenue Contribution of Top 10 Rented Movies: `results/06_top10_movie_revenue_share.csv`

---

### 07. Customer Lifetime Value

- Main Analysis: `results/07_customer_lifetime_value.csv`
- Customers Above Average CLV: `results/07_above_average_clv.csv`

---

### 08. Customer Segmentation

- Customer Spending Segmentation: `results/08_customer_segmentation.csv`
- Customer Distribution by Spending Segment: `results/08_customer_segment_distribution.csv`
- Spending Segment Performance: `results/08_customer_segment_performance.csv`

---

### 09. Rental Duration

- Main Analysis: `results/09_rental_duration.csv`
- Late Return Rate by Film: `results/09_late_return_rate.csv`
- Average Delay Beyond Allowed Rental Duration: `results/09_average_delay.csv`

---

### 10. Repeat Customers

- Main Analysis: `results/10_repeat_customers.csv`
- Repeat Customer Rate: `results/10_repeat_customer_rate.csv`
- Repeat Customer Distribution by Rental Frequency: `results/10_repeat_customer_distribution.csv`

## Key Insights

- 💰 The highest-value customer generated **221.55** in total revenue.
- 🏆 The **Sports** category generated the highest total revenue among all film categories.
- 📈 Monthly revenue peaked in **July 2005**, reaching **28,368.91**.
- 🌍 Customers from **Kowloon and New Kowloon** generated the highest city-level revenue.
- 🏪 **Store 2** generated the highest total revenue.
- 🎬 **BUCKET BROTHERHOOD** was the most frequently rented film with **34 rentals**.
- 👑 The **Top Spenders** customer segment contributed **32.45%** of the total revenue.
- ⏰ Some films experienced a **late return rate exceeding 90%**, highlighting significant differences in customer return behavior.
- 🔁 In the Sakila sample dataset, all customers rented more than once, resulting in a 100% repeat customer rate.

## Future Improvements

- Develop an interactive Power BI dashboard based on the SQL analysis.
- Build KPI dashboards for revenue, customers, and store performance.
- Perform RFM (Recency, Frequency, Monetary) customer segmentation.
- Extend the project using Python (Pandas) for advanced analytics and visualization.

## Repository Structure

- **queries/**: SQL scripts used for each business analysis.
- **results/**: CSV outputs generated from each SQL query.
- **README.md**: Project documentation and summary.

## About

This project was created as part of my data analytics portfolio to demonstrate practical SQL skills by solving real-world business problems using the MySQL Sakila sample database.

I focused not only on writing SQL queries but also on presenting the results through structured analyses, reusable query design, and clear project documentation.