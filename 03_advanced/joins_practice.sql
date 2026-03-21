create database join_1;
use join_1;
create table employees (
    emp_id int,
    emp_name varchar(50),
    dept_id int,
    salary int
);

create table departments (
    dept_id int,
    dept_name varchar(50)
);

insert into employees values
(1, 'Amit', 101, 50000),
(2, 'Priya', 102, 60000),
(3, 'Rahul', 101, 55000),
(4, 'Sneha', 103, 40000),
(5, 'Karan', NULL, 45000);

insert into departments values
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing');

# types of joins we have 
# inner join - output we will get is = matching records
# show rows where both table have matching dept_id

select e.emp_name, d.dept_name
from employees e
inner join departments d
on e.dept_id = d.dept_id;

# left join -> 
# show all employees + matching department (if exists)

select e.emp_name, d.dept_name
from employees e
left join departments d
on e.dept_id = d.dept_id;

# all dept_name and the employees working in these dept
# show all departments and employees working in them

select d.dept_name, e.emp_name
from departments d
left join employees e
on d.dept_id = e.dept_id;

select e.emp_name, d.dept_name
from employees e
right join departments d
on e.dept_id = d.dept_id;

# join + where
# emp_name whio are working in IT dept
# inner join + where

select e.emp_name, d.dept_name
from employees e
inner join departments d
on e.dept_id = d.dept_id
where d.dept_name = 'IT';