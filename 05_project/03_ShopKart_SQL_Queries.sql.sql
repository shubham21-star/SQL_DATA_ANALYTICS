# PROJECT: SHOPKART E-COMMERCE BUSINESS ANALYTICS
# NAME: Shubham Kumar
# COURSE: B.Tech CSE (D.A)
# DEPARTMENT: SAGE UNIVERSITY, BHOPAL
# DESCRIPTION: Complete SQL case study covering database creation, 
# joins, aggregations, profit analytics and business insights

-----------------------------------------------------

# CREATE DATABASE
create database shopkart_db;

# USE DATABASE
use shopkart_db;

-----------------------------------------------------

# CREATE TABLES

# CUSTOMERS TABLE
create table customers (
    customer_id int primary key,
    customer_name varchar(100),
    gender varchar(10),
    city varchar(50),
    signup_date date
);

# CATEGORIES TABLE
create table categories (
    category_id int primary key,
    category_name varchar(50)
);

# PRODUCTS TABLE
create table products (
    product_id int primary key,
    product_name varchar(100),
    category_id int,
    price decimal(10,2),
    cost decimal(10,2),
    foreign key (category_id) references categories(category_id)
);

# ORDERS TABLE
create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    city varchar(50),
    order_status varchar(20),
    foreign key (customer_id) references customers(customer_id)
);

# ORDER_ITEMS TABLE
create table order_items (
    order_item_id int primary key,
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

-----------------------------------------------------

# INSERT DATA

# CUSTOMERS DATA
insert into customers values
(1,'Rahul Sharma','Male','Delhi','2022-01-10'),
(2,'Priya Mehta','Female','Mumbai','2021-05-20'),
(3,'Amit Patel','Male','Ahmedabad','2023-02-14'),
(4,'Sneha Reddy','Female','Hyderabad','2022-11-01'),
(5,'Karan Verma','Male','Delhi','2020-08-18'),
(6,'Neha Nair','Female','Chennai','2021-09-09'),
(7,'Rohit Gupta','Male','Pune','2023-03-12'),
(8,'Anjali Singh','Female','Bangalore','2022-06-25');

# CATEGORIES DATA
insert into categories values
(1,'Electronics'),
(2,'Fashion'),
(3,'Home Appliances');

# PRODUCTS DATA
insert into products values
(101,'Laptop',1,80000,65000),
(102,'Mobile',1,30000,22000),
(103,'Headphones',1,2000,1200),
(104,'T-Shirt',2,800,300),
(105,'Jeans',2,2000,900),
(106,'Microwave',3,7000,5000),
(107,'Refrigerator',3,30000,24000),
(108,'Air Conditioner',3,45000,35000);

# ORDERS DATA
insert into orders values
(1001,1,'2024-01-10','Delhi','Delivered'),
(1002,2,'2024-01-11','Mumbai','Delivered'),
(1003,3,'2024-01-12','Ahmedabad','Cancelled'),
(1004,4,'2024-01-13','Hyderabad','Delivered'),
(1005,5,'2024-01-15','Delhi','Delivered'),
(1006,6,'2024-01-16','Chennai','Pending'),
(1007,1,'2024-02-02','Delhi','Delivered'),
(1008,7,'2024-02-05','Pune','Delivered'),
(1009,8,'2024-02-08','Bangalore','Delivered'),
(1010,2,'2024-02-10','Mumbai','Cancelled');

# ORDER ITEMS DATA
insert into order_items values
(1,1001,101,1),
(2,1001,103,2),
(3,1002,102,1),
(4,1003,104,3),
(5,1004,106,1),
(6,1005,105,2),
(7,1005,104,1),
(8,1006,102,1),
(9,1007,108,1),
(10,1008,103,3),
(11,1009,107,1),
(12,1010,104,2);

-----------------------------------------------------

# LEVEL 1 – BASIC QUERIES

# Q1 CUSTOMERS FROM DELHI
select * 
from customers 
where city = 'Delhi';

# Q2 LATEST 5 ORDERS
select * 
from orders 
order by order_date desc 
limit 5;

# Q3 TOP 3 EXPENSIVE PRODUCTS
select * 
from products 
order by price desc 
limit 3;

-----------------------------------------------------

# LEVEL 2 – AGGREGATION

# Q4 TOTAL NUMBER OF ORDERS
select count(*) as total_orders 
from orders;

# Q5 TOTAL QUANTITY SOLD PER PRODUCT
select product_id, sum(quantity) as total_quantity
from order_items
group by product_id;

# Q6 CITIES WITH MORE THAN 2 ORDERS
select city, count(*) as total_orders
from orders
group by city
having count(*) > 2;

-----------------------------------------------------

# LEVEL 3 – JOINS

# Q7 CUSTOMER NAME WITH ORDER ID
select c.customer_name, o.order_id
from customers c
join orders o 
on c.customer_id = o.customer_id;

# Q8 PRODUCT NAME IN EACH ORDER
select o.order_id, p.product_name
from orders o
join order_items oi 
on o.order_id = oi.order_id
join products p 
on oi.product_id = p.product_id;

# Q9 TOTAL QUANTITY PER CUSTOMER
select c.customer_name, sum(oi.quantity) as total_quantity
from customers c
join orders o 
on c.customer_id = o.customer_id
join order_items oi 
on o.order_id = oi.order_id
group by c.customer_name;

-----------------------------------------------------

# LEVEL 4 – PROFIT ANALYTICS

# Q10 PROFIT PER PRODUCT
select product_name, (price - cost) as profit_per_unit
from products;

# Q11 CATEGORY-WISE TOTAL PROFIT
select cat.category_name,
sum((p.price - p.cost) * oi.quantity) as total_profit
from order_items oi
join products p 
on oi.product_id = p.product_id
join categories cat 
on p.category_id = cat.category_id
group by cat.category_name;

-----------------------------------------------------

# LEVEL 5 – CUSTOMER INTELLIGENCE

# Q12 CUSTOMERS WITH MORE THAN 1 ORDER
select customer_id, count(*) as total_orders
from orders
group by customer_id
having count(*) > 1;

# Q13 CUSTOMERS ABOVE AVERAGE PURCHASE QUANTITY
select customer_id, sum(quantity) as total_quantity
from orders o
join order_items oi 
on o.order_id = oi.order_id
group by customer_id
having sum(quantity) > (
    select avg(quantity) from order_items
);

-----------------------------------------------------

# LEVEL 6 – BUSINESS INSIGHTS

# Q14 CITY WITH HIGHEST REVENUE
select o.city,
sum(p.price * oi.quantity) as revenue
from orders o
join order_items oi 
on o.order_id = oi.order_id
join products p 
on oi.product_id = p.product_id
group by o.city
order by revenue desc
limit 1;

# Q15 MOST PROFITABLE PRODUCT
select p.product_name,
sum((p.price - p.cost) * oi.quantity) as total_profit
from order_items oi
join products p 
on oi.product_id = p.product_id
group by p.product_name
order by total_profit desc
limit 1;

# Q16 MONTHLY ORDER TREND
select month(order_date) as month,
count(*) as total_orders
from orders
group by month(order_date);

-----------------------------------------------------

# CAPSTONE – BUSINESS ANALYSIS

# TOP 3 CUSTOMERS BY PURCHASE
select c.customer_name, sum(oi.quantity) as total_purchase
from customers c
join orders o 
on c.customer_id = o.customer_id
join order_items oi 
on o.order_id = oi.order_id
group by c.customer_name
order by total_purchase desc
limit 3;

# REVENUE PER CITY
select o.city, sum(p.price * oi.quantity) as revenue
from orders o
join order_items oi 
on o.order_id = oi.order_id
join products p 
on oi.product_id = p.product_id
group by o.city;

# PROFIT PER CATEGORY
select cat.category_name,
sum((p.price - p.cost) * oi.quantity) as profit
from order_items oi
join products p 
on oi.product_id = p.product_id
join categories cat 
on p.category_id = cat.category_id
group by cat.category_name;

# REPEAT CUSTOMERS COUNT
select count(*) as repeat_customers
from (
    select customer_id
    from orders
    group by customer_id
    having count(*) > 1
) as t;

# CANCELLED ORDER PERCENTAGE
select 
(count(case when order_status = 'Cancelled' then 1 end) * 100.0 / count(*)) as cancel_percentage
from orders;

-----------------------------------------------------

# PROJECT COMPLETED
# all required sql queries, analysis, and business insights have been executed successfully.

# author: shubham kumar
# project: shopkart e-commerce analytics
# status: completed