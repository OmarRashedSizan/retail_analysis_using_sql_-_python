drop database retaildb;
create database retaildb;

-- =====>>>>>Data Analysis & Business Key Problems & Answers<<<=====


-- Q.1 Write a SQL query to retrieve all columns for 
-- sales made on '2022-11-05
use retaildb;
select * from retail 
where sale_date ='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions 
-- where the category is 'Clothing' and the quantity 
-- sold is more than 2 in the month of Nov-2022
select *,month(sale_date) as month,year(sale_date)as year from retail where 
category ='Clothing' and month(sale_date)=11 and year(sale_date)=2022
and quantiy >2

-- Q.3 Write a SQL query to calculate the total sales (total_sale)
-- for each category.

select category ,sum(total_sale) from retail r 
group by category; 

/*-- Q.4 Write a SQL query to find the average age of customers 
 * who purchased items from the 'Beauty' category.*/

select round(avg(age),2)  from retail r 
where category ='Beauty';

/*-- Q.5 Write a SQL query to find all transactions where 
 * the total_sale is greater than 1000.*/
select transactions_id from retail r 
where total_sale >1000;

/*-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) 
 * made by each gender in each category.*/

select category ,gender,count(transactions_id) as transactions from retail r 
group by category ,gender;

select * from retail r ;
/*-- Q.7 Write a SQL query to calculate the average sale for each month. 
 *       Find out best selling month in each year*/
select years,month_name,avg_sale from 
(select month_name,avg_sale,years,
dense_rank () over(partition by years order by avg_sale  desc) as rnk
from
(select years,month_name,round(avg(cogs),2) as avg_sale from 
(select date_format(sale_date,'%M')as month_name,
year(sale_date)as years ,cogs from retail )t
group by years,month_name )t2)t3
where rnk=1;


/*-- Q.8 Write a SQL query to find the top 5 customers 
 * based on the highest total sales 
*/
select customer_id,sum(total_sale) as total_sales from retail r
group by 1 order by total_sales desc 
limit 5;

/*-- Q.9 Write a SQL query to find the number of unique customers who 
 *       purchased items from each category.*/
select category,count(distinct (customer_id)) as unique_customer from retail r
group by category;


/*-- Q.10 Write a SQL query to create each shift and number of orders 
 (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
*/
select shift,count(transactions_id) as num_of_order from 
(SELECT *,
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN HOUR(sale_time) > 17 THEN 'Evening'
    END AS shift
FROM retail r)t
group by shift;























