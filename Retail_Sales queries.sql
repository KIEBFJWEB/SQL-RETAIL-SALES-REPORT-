```sql
CREATE DATABASE Mysql_p1;

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
```

-- Data Explore 
-- How many sales we have ? 
select count(*) from sales_report; 
-- How many unique customer we have ?
select count(distinct customer_id) from sales_report;

select count(distinct category) from sales_report;

-- Data Analysis & Business Key problems & Answers.

--1. **Write a SQL query to retrieve all columns for sales made on 2022-11-05?
select * 
from sales_report 
where sales_date = '2022-11-05';

--2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
SELECT *
FROM sales_report 
WHERE category = 'Clothing' 
  AND DATE_FORMAT(sales_date, '%Y-%m') = '2022-11' 
  and quantity >= 4;
  
--3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
select category , 
sum(total_sales) as Net_sales  
from sales_report
group by category ;

--4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
SELECT round(AVG(age),2) as AVG_AGE 
 FROM sales_report
WHERE
category = 'beauty';

--5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
select * from sales_report
where Total_sales>1000;

--6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
select category,gender,count(transaction_id) from sales_report
group by gender , category
order by category asc;

--7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
select 
year,
month, Avg_sales
from (
select 
 extract(year from sales_date) as year,
 extract( month from sales_date) as month, 
round( avg(Total_sales),2) as avg_sales  ,
rank() over(partition by extract(year from sales_date) order by avg(total_sales) desc) as RANKk 
from sales_report
group by 1,2) as t1 
where rankk = 1;

-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id , sum(Total_sales) 
from sales_report
group by customer_id
order by 2 desc limit 5 ;

--9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
select count(distinct customer_id) as count_of_Uniique_Customer, category  from sales_report
group by 2;

-- 10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
with Hourly_sales 
as (
select * 
,case 
when extract(hour from sales_time )<12 then 'morning'
when extract(hour from sales_time) between 12 and 17 then 'afternoon'
else 'evening' 
end as Shift
from sales_report
)
select shift,
count(*) as Total_orders from hourly_sales 
 group by shift;

--End of Project!!!




 
