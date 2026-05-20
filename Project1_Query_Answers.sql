-- Data Analysis & Business Key Problems & Answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from retail_sales where category='Clothing' and quantity >= 3 and month(sale_date)=11 and year(sale_date)=2022; 

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as total_sales  from retail_sales group by  category ;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as avg_age from retail_sales where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender, category, count(transaction_id) from retail_sales group by gender, category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
with cte as
(select year(sale_date) as Year, month(sale_date) as Month, round(avg(total_sale),2) as avg_sale from retail_sales group by Year,Month )
select * from cte where avg_sale = (select max(avg_sale) from cte c2 where c2.Year = cte.Year);

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
with cte as
(select customer_id, sum(total_sale) as Totals, dense_rank() over (order by sum(total_sale) desc) as dns_rnk from retail_sales group by customer_id)
 select customer_id, Totals from cte where dns_rnk <= 5 ; 
 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select  count(distinct customer_id), category from retail_sales group by 2 ;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select 
    case when hour(sale_time) < 12 then 'Morning'
         when hour(sale_time) between 12 and 17 then 'Afternoon'
         when hour(sale_time) > 17 then 'Evening'
    end as shift , count(*) as Number_of_Orders from retail_sales
    group by shift;
    
-- End
