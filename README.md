# ** Retail Sales Analysis SQL Project **

## Project Overview
This project focuses on analyzing retail sales data using SQL. Invovles techniques typically used by data analysts to explore, clean, and analyze retail sales data. 
The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 
The goal is to extract meaningful business insights such as sales performance, customer interests, category trends, and time-based sales patterns.

## Objectives

1.Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
2.Data Cleaning: Identify and remove any records with missing or null values.
3.Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4.Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

## Tools Used
- SQL (MySQL)
- Git & GitHub
- Retail Sales Dataset

## Project Structure

1. Database Setup
Database Creation: The project starts by creating a database named p1_retail_db.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
```sql
CREATE DATABASE p1_retail_db;

```sql
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

2. Data Exploration & Cleaning

Record Count: Determine the total number of records in the dataset.
```sql
SELECT COUNT(*) FROM retail_sales;
```
Customer Count: Find out how many unique customers are in the dataset.
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```
Category Count: Identify all unique product categories in the dataset.
```sql
SELECT DISTINCT category FROM retail_sales;
```
Null Value Check: Check for any null values in the dataset and delete records with missing data.
```sql
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
```sql
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
##  Dataset Description
The dataset contains retail transaction-level data including:
- Transaction ID
- Sale Date & Time
- Customer Details (Age, Gender, Customer ID)
- Product Category
- Quantity
- Total Sale Amount


##  Business Problems & SQL Analysis

### 1. Retrieve sales made on a specific date
```sql
select * from retail_sales 
where sale_date = '2022-11-05';
```

### 2. Clothing category sales in Nov 2022 with quantity filter
```sql
select * from retail_sales 
where category='Clothing' 
and quantity >= 3 
and month(sale_date)=11 
and year(sale_date)=2022;
```

### 3. Total sales by category
```sql
select category, sum(total_sale) as total_sales  
from retail_sales 
group by category;
```

### 4. Average age of customers interested in Beauty category 
```sql
select round(avg(age),2) as avg_age 
from retail_sales 
where category='Beauty';
```

### 5. High-value transactions (>1000)
```sql
select * from retail_sales 
where total_sale > 1000;
```

### 6. Number of transactions by gender and category
```sql
select gender, category, count(transaction_id) 
from retail_sales 
group by gender, category;
```

### 7. Best selling month in each year
```sql
with cte as (
    select 
        year(sale_date) as Year, 
        month(sale_date) as Month, 
        round(avg(total_sale),2) as avg_sale 
    from retail_sales 
    group by Year, Month
)
select * 
from cte 
where avg_sale = (
    select max(avg_sale) 
    from cte c2 
    where c2.Year = cte.Year
);
```

### 8. Top 5 customers by total sales
```sql
with cte as (
    select 
        customer_id, 
        sum(total_sale) as Total_Sale,
        dense_rank() over (order by sum(total_sale) desc) as dns_rnk
    from retail_sales 
    group by customer_id
)
select customer_id, Total_Sale 
from cte 
where dns_rnk <= 5;
```

### 9. Unique customers per category
```sql
select category, count(distinct customer_id) as unique_customers 
from retail_sales 
group by category;
```

### 10. Orders by shift (Morning, Afternoon, Evening)
```sql
select 
    case 
        when hour(sale_time) < 12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as shift,
    count(*) as number_of_orders
from retail_sales
group by shift;
```


Key Insights
-------------
Identified top-performing product categories
Found high-value customers based on total spending
Analyzed peak sales time periods (shifts)
Discovered monthly sales performance trends
Measured customer distribution across categories

Project demonstrates following Practical SQL skills:
----------------------------------------------------                                 
Aggregations (SUM, COUNT, AVG)
Grouping and filtering data
Window functions (DENSE_RANK)
CTEs (Common Table Expressions)
Business-oriented data analysis
