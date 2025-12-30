create table retail_sales(
transactions_id int ,
sale_date date,
sale_time time,
customer_id int,
gender varchar(50),
age int ,
category varchar(50),
quantity integer,
price_per_unit int,
cogs float,
total_sale float
);

select * from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null 
or total_sale is null




--  data exploration --


-- how many sales/records we have? --
select count(*) as total_sale from retail_sales

-- how many unique customers we have? --

select count( distinct customer_id) as total_sale from retail_sales

select distinct category from retail_sales

-- data analytical questions to solve --

-- Q1 to retrive all cols for sales on 2022-11-05
select * from retail_sales where sale_date='2022-11-05'

-- Q@ to retrive all transcations for  category 'clothing' and quantity sold is more then 10 in the month of nov 2022--
select *
from retail_sales
where category='Clothing'
and quantity >=4
and sale_date>='2022-11-01'
and sale_date<'2022-12-01'

-- query to calc the total sales for each category--
select sum(total_sale),category
 from retail_sales
 group by category
 
 -- method 2--
select category,
sum(total_sale) as net_sale
from retail_sales
group by category

-- query to find the avg age fo customers who purchased items from the Beauty category--

select category, round (avg(age),2)
from retail_sales
where category='Beauty'

-- query to find all transcations where the total_sale >1000--

select count(transactions_id)
from retail_sales
where total_sale>1000

-- query to find the total number of transcations made by each gender in each catogory--

select category,gender,
count(*) as total
from retail_sales
group by category,
 gender
 order by category;
 
 -- query for avg sale for each month,find out best selling month in each year--
select
year,
month,
sales,
rank() over(
partition by year
order by sales desc
)as rank_no

from(
select
year(sale_date) as year,
month(sale_date) as month,
sum(total_sale) as sales

from retail_sales
group by year(sale_date), month(sale_date)
)t

order by year,rank_no asc;
 
 
 -- query to find the toop 5 customers based on the highest total sale--
 
 select customer_id,sum(total_sale) as sales
 from retail_sales
 group by customer_id
 order by sales desc
 limit 5
 
 -- query to find no. of unique customers who purchased itemsfrom each category--
select count( distinct customer_id), category
from retail_sales
group by category
order by category

 -- query to create each shift and number of orders(eg: morning<=12,afternoon between 12 to 17,evening 12)--
 
select
case
when hour(sale_time)<12 then 'morning'
when hour(sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shift,
count(*) as total_orders
from retail_sales
group by shift
order by shift