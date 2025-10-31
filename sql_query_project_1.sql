create database sql_project_p2;
Create table retail_sales
 ( 
    transaction_id INT PRIMARY KEY,
    sale_date date,
    sale_time time,
    customer_id INT,
    gender varchar(15),
    age int,
    category varchar(20),
    quantity int,
    price_per_unit float,
    cogs float,
    total_sales float
    );
    
    -- Data Cleaning 
    
    select * from retail_sales
    limit 10 ;
    select 
        count(*)
	from retail_sales;
    
    select * from retail_sales 
    where transaction_id is null;
    
    select * from retail_sales 
    where sale_date is null;
    
    select * from retail_sales
    where 
         transaction_id IS NULL
         OR 
         sale_date IS NULL
         OR 
         sale_time IS NULL
         or 
         gender is null
         or 
         category is null;
    
    --- Data Exploration 
    
    -- How many sales   we have ?
    select count(*) as total_sale from retail_sales;
    
    -- How many customers we have ?
    select count(distinct(Customer_id))as total_customers from retail_sales;
	
    -- How many category we have ?
    select  distinct category from retail_sales;
    
    -- Data Analysis and Buainess key problems ?
    

Q0 write a sql query to retrive all columns for sales on "2022-11-05"		
select * from retail_sales where sale_date="2022-11-05";

Q1  write a sql query to retrive all transactions where the category is Clothing the month Noc 2022

select 
   *
from retail_sales
where category = 'clothing'
   and
		date_format(sale_date, "%Y-%m")='2022-11';

Q2 write a sql query to calculate the total sales (total_sale) for each category  

SELECT 
     category,
     SUM(total_sales) as net_sale,
     COUNT(*) as total_orders
FROM retail_sales
GROUP BY category ;

Q3 write a sql query to find the average age of customers who purchased itens friom the 'Beauty' category ?
SELECT 
    round(AVG(age), 2) as avg_age 
from retail_sales
where category = 'Beauty';

Q4  write a sql query to find all trasactions where the total_sales is greater than 1k?
SELECT * FROM retail_sales
WHERE total_sales > 1000;

Q5  write a sql query to find the total number of transaction (transaction_id) made by each gender in each category ?
 SELECT 
     category,
     gender,
     COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
    category,
    gender
ORDER BY 1;

Q6  write a sql query to calculate the average sale for each month. Find out best selling month in each year ?

SELECT 
      Year,
      month,
      avg_sale
FROM 
(
		Select 
		YEAR(sale_date) as year,
		month(sale_date) as month, 
		round(AVG(total_sales), 2) as avg_sale,
		rank() over(partition by YEAR(sale_date) order by avg(total_sales) DESC) as rnk
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rnk =  1 ;

Q7  write a ssql query to find the top 5 customers based on the highest total sales ?
 
SELECT  
    customer_id,
    SUM(total_sales) as total_sales
FROM retail_sales
GROUP BY 1 
ORDER BY 2 DESC LIMIT 5 ;

Q8  write a sql query to find the number of unique customers who purchased items frm each category ?

SELECT 
    category,
    COUNT(distinct(customer_id)) as cnt_unique_cs
FROM retail_sales
group by 1 ;

Q9 write a sql query to create each shift and number of orders (Example Morning <= 12, Afternoon Between 12 & 17, Evening >17)

SELECT
  case
      WHEN hour(sale_time) < 12 then 'Morning'
      WHEN hour(sale_time) between 12 AND 17 then 'Afternoon'
      ELSE 'Evening'
	END as shift, 
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY shift
ORDER BY FIELD(shift, 'Morning', 'Afternoon','Evening');

-- END OF PROJECT 
