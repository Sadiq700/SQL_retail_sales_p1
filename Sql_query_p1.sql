-- SQL Retail Sales Analysis - p1

create database sql_project_p1;

-- create table
drop table if exists retail_sales; 
create table retail_sales 
       (
		transactions_id	int primary key,
        sale_date	date,
        sale_time	time,
        customer_id int,
        gender	varchar(15),
        age  int,
        category varchar(15),
        quantiy int,
        price_per_unit float,	
        cogs	float,
        total_sale float
	 );
     select * from retail_sales;
select count(*)
 from retail_sales;
 -- Data Cleaning
      select * from retail_sales
		where 
			transactions_id is null
            or
            sale_date is null
            or 
            sale_time is null
            or
            customer_id is null
            or
            gender is null
            or
            age is null
            or
            category is null
            or
            quantiy is null
            or
            price_per_unit is null
            or
            cogs is null
            or
            total_sale is null;
--            
		delete from retail_sales
			where 
			transactions_id is null
            or
            sale_date is null
            or 
            sale_time is null
            or
            customer_id is null
            or
            gender is null
            or
            age is null
            or
            category is null
            or
            quantiy is null
            or
            price_per_unit is null
            or
            cogs is null
            or
            total_sale is null;
            
-- Data Exploring

-- How many sales we have?
select count(*) as total_sales
from retail_sales;

-- How many unique Customer's we have?
select count(distinct Customer_id) as total_sales
from retail_sales;

-- How many category we have?
select distinct category from retail_sales;

-- Data Analysis & Business key problem & Answers

-- Q.1 Write a SQl query to retrieve all colums from sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where category is 'clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * from retail_sales
where  category = 'clothing' 
and sale_date between  '2022-11-01' and '2022-11-30'
and quantity >= 4;

alter table retail_sales
rename column quantiy to quantity;

-- Q.3 Write a SQL query to calculate the total sales (total_sales) for each category.

select category, sum(total_sale) as net_sale, count(*) as total_orders
from retail_sales
group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased iteams from 'Beauty' category

select round(avg(age),2) avg_age from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQl query to find all transactions where the total_sale is greater than 1000

select transactions_id  from retail_sales
where total_sale > 1000;

-- Q.6 Write SQl query to find total number of transactions (transactions_id) made by each gender in each category

select category, gender, count(transactions_id)
from retail_sales
group by 1, 2
order by 1;

-- Q.7 Write a SQl query to calculate the avaerage sale for each month. Find out the best selling month in each year

select year, month, avg_sale
 from 
 (
select year(sale_date) year, month(sale_date) month, avg(total_sale) avg_sale,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rannnk
from retail_sales
group by 1, 2
) as t1
where rannnk = 1;
-- order by 1, 3 desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sale 

select customer_id, sum(total_sale) sum_of_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQl query to find unique customers who porchased iteams from each category

select * from retail_sales;
select category, count(distinct customer_id)
from retail_sales 
group by 1;

-- Q.10 Write a SQL query to create each shift and number of orders (Example morning <=12, Afternoon between 12 &17, Evening >17)

With hourly_sales
as
(
select *,
	Case
		When hour(sale_time) < 12 then 'Morning'
		When hour(sale_time) between 12 and 17 then 'Afternoon'
	  Else 'Evening'
     End as Shift
       from retail_sales
	) 
    select shift,  count(total_sale)
    from hourly_sales
    group by 1;
    
    -- End of project





















     