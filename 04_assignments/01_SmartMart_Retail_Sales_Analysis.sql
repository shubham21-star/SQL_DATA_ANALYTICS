# Project: SmartMart Retail Sales Analysis
# Name: Shubham Kumar
# Course: B.tech CSE (D.A)
# Description: Practice assignment covering select, where, group by, 
#joins and business queries

# create database
create database smartmart_db;

# use database
use smartmart_db;

# create customers table
create table customers (
    customer_id int primary key,
    customer_name varchar(50),
    city varchar(50),
    age int
);

# create products table
create table products (
    product_id int primary key,
    product_name varchar(100),
    category varchar(50),
    price decimal(10,2)
);

# create sales table
create table sales (
    order_id int primary key,
    customer_id int,
    product_id int,
    quantity int,
    order_date date
);

# insert customers
insert into customers values
(1,'Rahul Sharma','Delhi',28),
(2,'Priya Verma','Mumbai',32),
(3,'Amit Singh','Bangalore',25),
(4,'Neha Kapoor','Delhi',29),
(5,'Rohit Mehta','Pune',35),
(6,'Anjali Gupta','Mumbai',27),
(7,'Karan Patel','Ahmedabad',31),
(8,'Sneha Reddy','Hyderabad',26);

# insert products
insert into products values
(101,'Laptop','Electronics',80000),
(102,'Smartphone','Electronics',40000),
(103,'Headphones','Electronics',2000),
(104,'T-Shirt','Clothing',800),
(105,'Jeans','Clothing',2000),
(106,'Microwave','Home Appliances',7000),
(107,'Refrigerator','Home Appliances',30000),
(108,'Air Conditioner','Home Appliances',45000);

# insert sales
insert into sales values
(1001,1,101,1,'2024-01-10'),
(1002,2,102,2,'2024-01-11'),
(1003,3,104,3,'2024-01-12'),
(1004,4,105,2,'2024-01-12'),
(1005,5,103,4,'2024-01-13'),
(1006,6,106,1,'2024-01-14'),
(1007,7,108,1,'2024-01-14'),
(1008,8,102,1,'2024-01-15'),
(1009,1,103,2,'2024-01-16'),
(1010,2,104,5,'2024-01-17'),
(1011,3,105,1,'2024-01-18'),
(1012,4,101,1,'2024-01-19');

-----------------------------------------------------

-----------------------------------------------------
# Level 1 – Basic SELECT

# Q1. display all customers
select * 
from customers;

# Q2. show only customer_name and city
select customer_name, city 
from customers;

# Q3. display all products in electronics category
select * 
from products 
where category = 'Electronics';

# Q4. show products with price greater than 10000
select * 
from products 
where price > 10000;

# Q5. display unique categories
select distinct category 
from products;

-----------------------------------------------------
# Level 2 – WHERE Conditions

# Q6. show customers who live in delhi
select * 
from customers 
where city = 'Delhi';

# Q7. show customers with age greater than 30
select * 
from customers 
where age > 30;

# Q8. display products with price between 2000 and 50000
select * 
from products 
where price between 2000 and 50000;

# Q9. find orders placed after 2024-01-12
select * 
from sales 
where order_date > '2024-01-12';

# Q10. display sales where quantity > 2
select * 
from sales 
where quantity > 2;

-----------------------------------------------------
# Level 3 – Sorting & Limiting

# Q11. display products sorted by price (highest first)
select * 
from products 
order by price desc;

# Q12. show top 3 most expensive products
select * 
from products 
order by price desc limit 3;

# Q13. display customers sorted by age ascending
select * 
from customers 
order by age;

# Q14. show latest 5 orders
select * 
from sales 
order by order_date desc limit 5;

-----------------------------------------------------
# Level 4 – NULL Handling

# Update a row to create null value
update customers
set city = null
where customer_id = 8;

# Q15. find customers where city is null
select * 
from customers 
where city is null;

# Q16. find customers where city is not null
select * 
from customers 
where city is not null;

-----------------------------------------------------
# Level 5 – Aggregations

# Q17. find total number of customers
select count(*) as total_customers 
from customers;

# Q18. find average product price
select avg(price) as avg_price 
from products;

# Q19. find maximum product price
select max(price) as max_price 
from products;

# Q20. find total quantity sold
select sum(quantity) as total_quantity 
from sales;

-----------------------------------------------------
# Level 6 – GROUP BY

# Q21. find number of products in each category
select category, count(*) as total_products
from products
group by category;

# Q22. find total sales quantity by product_id
select product_id, sum(quantity) as total_quantity
from sales
group by product_id;

# Q23. find average price by category
select category, avg(price) as avg_price
from products
group by category;

-----------------------------------------------------
# Level 7 – HAVING Clause

# Q24. find categories where average price > 10000
select category, avg(price)
from products
group by category
having avg(price) > 10000;

# Q25. find products where total quantity sold > 3
select product_id, sum(quantity)
from sales
group by product_id
having sum(quantity) > 3;

# Q26. find categories having more than 2 products
select category, count(*)
from products
group by category
having count(*) > 2;

-----------------------------------------------------
# Business Questions

# Q27. which category generates the most sales volume
select p.category, sum(s.quantity) as total_sales
from sales s
join products p
on s.product_id = p.product_id
group by p.category
order by total_sales desc
limit 1;

# Q28. which product sells the most units
select p.product_name, sum(s.quantity) as total_units
from sales s
join products p
on s.product_id = p.product_id
group by p.product_name
order by total_units desc
limit 1;

# Q29. which city has the most customers
select city, count(*) as total_customers
from customers
group by city
order by total_customers desc
limit 1;

# Q30. which product has the highest price
select product_name, max(price)
from products;