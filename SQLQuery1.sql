CREATE DATABASE [Retail Sales];
GO

USE [Retail Sales];
GO

--Create Table
Create Table Retail_Table1(

	transactions_id int PRIMARY KEY	,
	sale_date date,
	sale_time Time,
	customer_id	int,
	gender	varchar(15),
	age	int,
	category varchar(15),
	quantiy int,
	price_per_unit float,	
	cogs float,	
	total_sale float
)

select * from Retail_Table_1

select 
	count(*)
from Retail_Table_1


--Checking Null Values

select * from Retail_Table_1
where 
	customer_id  is null
	or
	quantiy is null
	or
	age is null



-- Deleting Null Values

delete from Retail_Table_1
where 
	customer_id  is null
	or
	quantiy is null
	or
	age is null



-- Data Exploration------

--How many Sales record we have?
	select count(*) as total_sale
	from Retail_Table_1

-- How many unique customers we have?
	select count(distinct customer_id) as total_customers
	from Retail_Table_1

--How many categories we have?
	select distinct category as category
	from Retail_Table_1


--Data Analysis & Business Key Problems & Answers

 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

 select * 
 from Retail_Table_1
where sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select *
from Retail_Table_1
where category = 'Clothing'
	AND
FORMAT(sale_date,'yyyy-MM')='2022-11'
	And
quantiy >=4


--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
	category,
	sum(total_sale) as Net_Sale_By_Category,
	count(*) as total_orders
from retail_table_1
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
	avg(age) as average_age
from Retail_Table_1
where category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from Retail_Table_1
where total_sale>1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
	gender,
	category,
	count(transactions_id) as Total_Transactions
from Retail_Table_1
group by gender,category
 

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from 
(
	SELECT 
		DATEPART(YEAR, sale_date) AS Year,
		DATEPART(MONTH, sale_date) AS Month,
		AVG(total_sale) AS Average_Sale,
		rank()over(Partition by DATEPART(YEAR, sale_date)  Order By AVG(total_sale) desc) as Ranks
	FROM Retail_Table_1
	GROUP BY 
		DATEPART(YEAR, sale_date),
		DATEPART(MONTH, sale_date)
	
	) as t1
where Ranks = 1



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select 
	top 5
	customer_id,
	sum(total_sale) as Total_Sales 
from Retail_Table_1
group by customer_id
order by sum(total_sale) desc


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select count(distinct customer_id) as CumtomerId,
category
from Retail_Table_1
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM Retail_Table_1
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;














