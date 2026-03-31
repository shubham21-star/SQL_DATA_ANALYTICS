# create database
create database company_subquery;
use company_subquery;

# tables
create table departments (
    dept_id int,
    dept_name varchar(50)
);

create table employees (
    emp_id int,
    emp_name varchar(50),
    dept_id int,
    salary int
);

# insert data
insert into employees values
(1, 'amit', 101, 50000),
(2, 'priya', 102, 60000),
(3, 'rahul', 101, 55000),
(4, 'sneha', 103, 40000),
(5, 'karan', 102, 45000),
(6, 'arjun', 103, 70000),
(7, 'neha', null, 48000);

insert into departments values
(101, 'hr'),
(102, 'it'),
(103, 'finance'),
(104, 'marketing');

# -----------------------------------
# subqueries
# -----------------------------------

# employees earning more than average
select emp_name, salary
from employees
where salary > (select avg(salary) from employees);

# highest paid employee
select emp_name, salary
from employees
where salary = (select max(salary) from employees);

# employees in it department
select emp_name
from employees
where dept_id in (
    select dept_id from departments where dept_name = 'it'
);

# employees not in hr
select emp_name
from employees
where dept_id not in (
    select dept_id from departments where dept_name = 'hr'
);

# -----------------------------------
# window functions
# -----------------------------------

# row number
select emp_name, salary,
row_number() over (order by salary desc) as row_num
from employees;

# rank
select emp_name, salary,
rank() over (order by salary desc) as rnk
from employees;

# dense rank
select emp_name, salary,
dense_rank() over (order by salary desc) as drnk
from employees;

# rank inside each department
select emp_name, dept_id, salary,
rank() over (partition by dept_id order by salary desc) as dept_rank
from employees;

# running total
select emp_name, salary,
sum(salary) over (order by emp_id) as running_total
from employees;

# lag (previous salary)
select emp_name, salary,
lag(salary) over (order by emp_id) as prev_salary
from employees;

# lead (next salary)
select emp_name, salary,
lead(salary) over (order by emp_id) as next_salary
from employees;

# -----------------------------------
# views
# -----------------------------------

create database view1;
use view1;

create table employees (
emp_id int,
emp_name varchar(50),
department varchar(50),
salary int
);

# it employees view
create view it_employees as
select * from employees where department = 'it';

# basic view
create view employee_basic as
select emp_name, department, salary from employees;

# high salary view
create view high_sal as
select * from employees where salary > 70000;

# -----------------------------------
# case statements
# -----------------------------------

# simple case
select emp_name, salary,
case
when salary > 70000 then 'high'
else 'low'
end as level
from employees;

# multiple conditions
select emp_name, salary,
case
when salary > 80000 then 'very high'
when salary between 60000 and 80000 then 'medium'
else 'low'
end as category
from employees;

# -----------------------------------
# cte (common table expression)
# -----------------------------------

# basic cte
with emp_cte as (
    select * from employees
)
select * from emp_cte;

# filter cte
with high_sal as (
    select * from employees where salary > 70000
)
select * from high_sal;

# dept avg salary
with dept_avg as (
    select department, avg(salary) as avg_sal
    from employees
    group by department
)
select * from dept_avg;