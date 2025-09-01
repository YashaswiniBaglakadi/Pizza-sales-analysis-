Create database Pizzahut;
use pizzahut;
 create table pizza_Type(
 pizza_type_id varchar(255) Primary key,
 name varchar(255),
 category varchar(255),
 ingredients varchar(255)
 );
  create table Orders(
 order_id varchar(255) Primary key,
 order_date varchar(255),
 order_time varchar(255)

 );
  create table Pizzas(
 pizza_id varchar(255) Primary key,
 pizza_type_id varchar(255),
 size varchar(255),
price varchar(255),
foreign key( pizza_type_id) references pizza_type(pizza_type_id)
 );
 -- 1st question
 Select count(order_id) Orders_placed
 From Orders;
 
 -- 2nd question
SELECT SUM(o.quantity * p.price) AS TotalRevenue 
FROM orders_detail o 
JOIN pizzas p ON o.pizza_id = p.pizza_id; 
-- 3rd question
select p. price, pt.name
from pizzas p
join pizza_type pt on p.pizza_type_id = pt.pizza_type_id
order by price desc
limit 5;
-- 4th Identify the most common pizza size ordered.
SELECT p.size,count(od.orders_deatil_id)
FROM orders_detail od
JOIN pizzas p ON od.pizza_id = p.pizza_id
Group by piz
order by p.size
limit 5;
-- 5th question List the top 5 most ordered pizza types along with their quantities.
SELECT pt.name, COUNT(od.orders_id) AS pizza_count 
FROM pizzas p
 JOIN pizza_type pt ON p.pizza_type_id = pt.pizza_type_id 
 JOIN orders_detail od ON p.pizza_id = od.pizza_id
 GROUP BY pt.name
 ORDER BY pizza_count DESC
 LIMIT 5;
 -- 6th question Determine the distribution of orders by hour of the day.
SELECT hour(order_time, '%H') AS hour_of_day, COUNT(*) AS number_of_orders
 FROM orders 
 GROUP BY hour_of_day 
 ORDER BY number_of_orders DESC;
  -- 6th
SELECT hour(order_time) AS hour_of_day, COUNT(orders.order_id) AS number_of_orders 
FROM orders 
GROUP BY hour_of_day
 ORDER BY number_of_orders DESC
 limit 5;
 -- 7th question calculate the average number of pizzas ordered per day.
select date(o.order_date) , avg(od.quantity)
FROM orders o
join orders_detail od on o.order_id=od.orders_id
group by order_date
;
-- 8th

 SELECT SUM(o.quantity * p.price) AS TotalRevenue,pt.name as type
FROM orders_detail o 
JOIN pizzas p ON o.pizza_id = p.pizza_id
join pizza_type pt on p.pizza_type_id=pt.pizza_type_id
group by o.quantity,p.price,pt.category,pt.name
order by totalRevenue desc
limit 3; 
-- 9th
select DATE(o.order_date) AS order_date, 
SUM(od.quantity * p.price) AS daily_revenue, 
SUM(SUM(od.quantity * p.price))
 OVER (ORDER BY DATE(o.order_date)) AS cumulative_revenue 
 FROM orders_detail od 
 JOIN orders o ON od.orders_id = o.order_id 
 JOIN pizzas p ON od.pizza_id = p.pizza_id
 GROUP BY DATE(o.order_date) 
 ORDER BY DATE(o.order_date)
 limit 5; 
 -- 11 th Determine the top 3 most ordered pizza types based on revenue for each pizza category.
 SELECT SUM(o.quantity * p.price) AS TotalRevenue,pt.category,pt.name
FROM orders_detail o 
JOIN pizzas p ON o.pizza_id = p.pizza_id
join pizza_type pt on p.pizza_type_id=pt.pizza_type_id
group by o.quantity,p.price,pt.category,pt.name
order by totalRevenue desc
limit 3; 
