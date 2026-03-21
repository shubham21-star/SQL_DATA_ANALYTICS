create database retail_db;

# Database
use retail_db;


#Table

create table orders (
order_id int auto_increment primary key,
customer_name varchar(50),
city varchar(50),
product varchar(50),
category varchar(50),
quantity int,
price float,
order_date date,
payment_mode varchar(30)
);

# Data -

insert into orders (customer_name, city, product, category, quantity, price, order_date, payment_mode) values
('Amit', 'Mumbai', 'Laptop', 'Electronics', 1, 70000, '2024-01-10', 'Credit Card'),
('Priya', 'Delhi', 'Phone', 'Electronics', 2, 30000, '2024-02-15', 'UPI'),
('Rahul', 'Mumbai', 'Shoes', 'Fashion', 3, 2000, '2024-02-18', 'Cash'),
('Sneha', 'Delhi', 'Watch', 'Accessories', 1, 5000, '2024-03-05', 'UPI'),
('Karan', 'Chennai', 'Laptop', 'Electronics', 1, 65000, '2024-03-10', 'Credit Card'),
('Meena', 'Mumbai', 'Bag', 'Fashion', 2, 3000, '2024-03-15', 'Debit Card'),
('Rohit', 'Delhi', 'Phone', 'Electronics', 1, 25000, '2024-04-01', 'Cash'),
('Anjali', 'Chennai', 'Shoes', 'Fashion', 2, 2500, '2024-04-05', 'UPI'),
('Dev', 'Pune', 'Tablet', 'Electronics', 1, 20000, '2024-04-15', 'Credit Card'),
('Sara', 'Mumbai', 'Watch', 'Accessories', 2, 4500, '2024-05-01', 'Debit Card'),
('Nikhil', 'Delhi', 'Laptop', 'Electronics', 1, 72000, '2024-05-10', 'Credit Card'),
('Pooja', 'Pune', 'Bag', 'Fashion', 3, 2800, '2024-05-15', 'UPI'),
('Arjun', 'Chennai', 'Phone', 'Electronics', 2, 32000, '2024-06-01', 'Credit Card'),
('Riya', 'Mumbai', 'Shoes', 'Fashion', 1, 2200, '2024-06-10', 'Cash'),
('Kabir', 'Delhi', 'Tablet', 'Electronics', 1, 21000, '2024-06-15', 'UPI');

# show only customer name, product, and price
select customer_name, product, price
from orders;

#rename column using alias
select customer_name as customer,
product as item,
price as product_price
from orders;

# show order from mumbai
select *
from orders
where city = 'mumbai';

#mangement wants to identify expensive product ourches -order where price > 30000
select *
from orders
where price > 30000;

#customer from delhi and bought electronics
select *
from orders
where city = "Delhi" and category = "Electronics";

# order from Delhi or mumbai
select *
from orders
where city = "Delhi" or city = "mumbai";

select *
from orders
where city in ('delhi', 'mumbai');

# customer not from mumbai
select *
from orders
where city != 'mumbai';

# price between 20000 and 70000
select *
from orders
where price between 20000 and 70000;

# customer whose name start with a
select *
from orders
where customer_name like 'A%';

# product ending with s
select *
from orders
where product like '%s';

# payment modes containing "card" - "%Card%"
select *
from orders
where payment_mode like '%card%';

# sort order by price (highest first)
select *
from orders
order by price desc;

# show top 5 highest price orders
select *
from orders
order by price desc
limit 5;

# show the most recent order
select *
from orders
order by order_date desc
limit 1;

# total number of orders
select count(*) as total_orders
from orders;

# total revenu of orders
select sum(price * quantity) as total_revenue
from orders;

# average product price
select avg(price) as average_price
from orders;

# highest priced product
select max(price) as highest_price
from orders;

# number of orders per city
select city, count(*) as total_orders
from orders
group by city;

# total revenue for each category
select category, sum(price * quantity) as revenue
from orders
group by category;

# average price per category
select category, avg(price) as avg_price
from orders
group by category;

# number of orders for each payment mode
select payment_mode, count(*) as total_orders
from orders
group by payment_mode;

# cities with more than 2 orders
select city, count(*) as total_orders
from orders
group by city
having count(*) > 2;

# categories generating revenue> 50000
select category, sum(price * quantity) as total_revenue
from orders
group by category
having sum(price * quantity) > 50000;

# categories with average price > 25000
select category, avg(price) as avg_price
from orders
group by category
having avg(price) > 25000;

# city generating highest revenue
select city, sum(price * quantity) as total_revenue
from orders
group by city
order by total_revenue desc
limit 1;

# customer who spent the most money
select customer_name, sum(price * quantity) as total_spent
from orders
group by customer_name
order by total_spent desc
limit 1;