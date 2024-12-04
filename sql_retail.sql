
--CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(15),
age	INT,
category VARCHAR(15),
quantiy	INT,
price_per_unit FLOAT,	
cogs	FLOAT,
total_sale FLOAT
);

SELECT * FROM retail_sales;

SELECT * FROM retail_sales
limit 10;

SELECT count(*) FROM retail_sales;

Select * from retail_sales
where transactions_id is NULL;
Select * from retail_sales
where sale_date is NULL;
Select * from retail_sales
where sale_time is NULL;

--Data Cleaning
Select * from retail_sales
where 
	transactions_id is NULL or
	sale_date is NULL or
	sale_time is NULL or
	customer_id is NULL or
	gender is NULL or
	category is NULL or 
	quantity is NULL or
	price_per_unit is null or
	cogs is null or
	total_sale is null;

--DELETE 
DELETE FROM retail_sales 
where 
	transactions_id is NULL or
	sale_date is NULL or
	sale_time is NULL or
	customer_id is NULL or
	gender is NULL or
	category is NULL or 
	quantity is NULL or
	price_per_unit is null or
	cogs is null or
	total_sale is null;


SELECT count(*) FROM retail_sales;

--Data exploration
---How many sales we have?
Select count(*) as total_sales from retail_sales;

---How many unique customers we have?
select count(distinct customer_id) as count_of_unique_customers from retail_sales;

---How many unique categories are there? and what are those unique categories?
select count(distinct category) as count_of_unique_category from retail_sales;

select distinct category from retail_sales;

--Data Analysis and Business key problems and answers

--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05.
--Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
--Q3. Write a SQL query to calculate the total sales (total_sale) for each category.
--Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
--Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
--Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
--Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
--Q8. Write a SQL query to find the top 5 customers based on the highest total sales.
--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
--Q10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).

--Answers:
----Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05.

select * from retail_sales
where sale_date = '2022-11-05';

----Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equals to 4 in the month of Nov-2022.
select * from retail_sales
where 
	category= 'Clothing' and 
	quantity >= 4 and
	to_char(sale_date,'yyyy-mm')='2022-11'

----Q3. Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) from retail_sales
group by category;

select category, sum(total_sale) as net_sale from retail_sales
group by 1;
select category, sum(total_sale) as net_sale ,count(*) as total_orders from retail_sales
group by 1;

----Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
	ROUND(AVG(age),2) as avg_age
from retail_sales
where category='Beauty'

----Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000

----Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category,gender,count(transactions_id) from retail_sales
group by category,gender

select category,gender,count(*) from retail_sales
group by category,gender 
order by 1

----Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

select 
	extract(year from sale_date) as year,
	extract(month from sale_date) as month, 
	avg(total_sale) as avg_sales
from retail_sales
group by 1,2
order by 1,2

--for Find out best selling month in each year.
SELECT year, month, avg_sales
FROM
	(select 
		extract(year from sale_date) as year,
		extract(month from sale_date) as month, 
		avg(total_sale) as avg_sales ,
		RANK() over(partition by extract(year from sale_date) order by avg(total_sale) desc) AS RANK
	from retail_sales
	group by 1,2) AS T1
where rank=1

----Q8. Write a SQL query to find the top 5 customers based on the highest total sales.

select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by 2 desc
limit 5

----Q9. Write a SQL query to find the number of unique customers who purchased items from each category.

select  category, count(distinct customer_id) as unique_customers
from retail_sales
group by 1

----Q10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).

with hourly_sale
as
(
select *,
	case 
		when extract(hour from sale_time) <12 then 'Morning'
		when extract(hour from sale_time) Between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retail_sales
)

select shift,count(*) as total_orders from hourly_sale
group by shift




