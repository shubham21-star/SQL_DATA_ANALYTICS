#create database
create database school;

#use
use school;

#create 
create table students (
id int ,
name varchar(50),
age int,
city varchar(50),
marks float
);

#to get the output
select *
from students;

#insert values into school
insert into students (Name,Age,City,Marks) values
('Shubham','19','Bhopal','99'),
('Amit','21','Delhi','75'),
('Priya','22','Mumbai','85'),
('Rahul','25','Bhopal','96'),
('Sneha','18','Chennai','59'),
('Karan','21','Nagpur','66'),
('Meena','25','Rajesthan','62'),
('Rohit','24','Bhopal','92'),
('Anjali','18','Delhi','82'),
('Pihoo','19','Bhopal','98');

select * 
from students;
alter table students modify id int auto_increment primary key;

#Selecting specific columns
select name,marks
from students;

# select with column alias
select Name as Student_name,
Marks as Total_marks
from students;

# Where - fetching student record stay in Bhopal
select *
from students
where City = 'Bhopal';

#numerical condition
select *
from students
where Marks > 80;

#And (muiltiple condition)
select *
from students
where City = 'Delhi' and age > 20;

#or (muiltiple condition)
select *
from students
where City = 'Delhi' or age > 20;

#Not
select *
from students
where not City = 'Delhi';

#Between - marks between 60-90
select *
from students
where marks between 60  and 90;

#Multiple values - student stay in bhopal, delhi
select *
from students 
where city in ('Bhopal' , 'Delhi');


