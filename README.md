# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_retail_project`

This project is intended to showcase SQL skills and techniques commonly employed by data analysts to explore, clean, and analyze retail sales data. It includes setting up a retail sales database, conducting exploratory data analysis (EDA), and addressing specific business questions through SQL queries. This project is perfect for beginners in data analysis who wish to establish a strong foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Build and populate a database with the provided retail sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Apply SQL to address specific business questions and extract valuable insights from the sales data.


## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_retail_project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
Create Database sql_retail_project;

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

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from retail_sales
where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select * from retail_sales
where 
	category= 'Clothing' and 
	quantity >= 4 and
	to_char(sale_date,'yyyy-mm')='2022-11'
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category, sum(total_sale) as net_sale ,count(*) as total_orders from retail_sales
group by 1;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select 
	ROUND(AVG(age),2) as avg_age
from retail_sales
where category='Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from retail_sales
where total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category,gender,count(*) from retail_sales
group by category,gender 
order by 1
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT year, month, avg_sales
FROM
	(
        select 
		extract(year from sale_date) as year,
		extract(month from sale_date) as month, 
		avg(total_sale) as avg_sales ,
		RANK() over(partition by extract(year from sale_date) order by avg(total_sale) desc) AS RANK
	from retail_sales
	group by 1,2
    ) AS T1
where rank=1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by 2 desc
limit 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select  category, count(distinct customer_id) as unique_customers
from retail_sales
group by 1
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset represents customers from diverse age groups, with sales spread across various categories like Clothing and Beauty.
- **High-Value Transactions**: A number of transactions exceeded 1000 in total sale amount, suggesting premium purchases.
- **Sales Trends**: A monthly breakdown reveals fluctuations in sales, highlighting peak seasons.
- **Customer Insights**: The analysis highlights the highest-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A comprehensive report summarizing total sales, customer demographics, and performance across different categories.
- **Trend Analysis**: Insights into sales fluctuations over various months and shifts.
- **Customer Insights**: Reports detailing top customers and the number of unique customers per category.

## Conclusion

This project provides a thorough introduction to SQL for data analysts, encompassing database setup, data cleaning, exploratory data analysis, and SQL queries tailored to business needs. The insights gained from this project can support business decision-making by offering a deeper understanding of sales trends, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `sql_retail.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Shivani Parekh

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Connect with me here:

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/shivani-parekh-/)

Thank you for your support, and I look forward to connecting with you!
