## Pizza Sales Dataset

use pizza_sales;

select * from sales;

-- Total Revenue:

select sum(total_price) from sales;

-- Average order value:

select round(sum(total_price) / count(distinct(order_id)), 2) as AVG_Order_value from sales;

-- Total pizza sold:

select sum(quantity) as sold from sales;

-- Total Orders:

select count(distinct(order_id)) as total_order from sales;

-- Average pizza per order:

select round(sum(quantity) / count(distinct order_id), 2) as avg_pizza_per_order from sales;

-- Hourly trend for total pizzas sold

select hour(order_time) as order_hour, sum(quantity) as quantity from sales group by order_hour, quantity order by order_hour;


-- weekly trend for total orders

# Default date formate in MYSQL is YYYY-MM-DD

update sales
set order_date = str_to_date(order_date, "%d-%m-%Y");

alter table sales modify order_date date;

desc sales;

select weekofyear(order_date) as week_number, year(order_date) as order_year, count(distinct(order_id)) as total_order 
from sales 
group by week_number, order_date;

# Percentage of sale by pizza category

select pizza_category, sum(total_price) * 100 / (select sum(total_price) from sales) as Avg_Sale from sales group by pizza_category;

select pizza_category, round(sum(total_price), 2) as total_price, sum(total_price) * 100 / (select sum(total_price) from sales) as Avg_sale
from sales 
group by pizza_category;

select pizza_category, sum(total_price), sum(total_price) * 100 / (select sum(total_price) from sales where month(order_date) = 1) as Avg_sale
from sales 
where month(order_date) = 1
group by pizza_category;


# percentage of sale by pizza size

select pizza_size, sum(total_price) * 100 / (select sum(total_price) from sales) as Avg_sale 
from sales
group by pizza_size;

select pizza_size, round(sum(total_price), 2), round(sum(total_price) * 100 / (select sum(total_price) from sales), 2) as Avg_sale
from sales
group by pizza_size;

select pizza_size, order_date, round(sum(total_price), 2) as total_price, sum(total_price) * 100 / (select sum(total_price) from sales where quarter(order_date)=1) as Avg_sale 
from sales
where quarter(order_date)=1
group by pizza_size,order_date, total_price;

# Total pizzas sold by pizza category:

select pizza_id, pizza_name, pizza_category from sales; 

# Top 5 best sellers by revenue, Total quantity and total orders

select pizza_name, sum(total_price) as top_revenue 
from sales
group by pizza_name
order by top_revenue desc
limit 5;

select pizza_name, sum(total_price) as top_revenue 
from sales
group by pizza_name
order by top_revenue asc
limit 5;

select pizza_name, count(distinct(order_id)) as total_order 
from sales 
group by pizza_name 
order by total_order desc
limit 5;