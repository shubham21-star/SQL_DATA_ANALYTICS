# Create the database
CREATE DATABASE company_db;
USE company_db;

-- Create employees table
CREATE TABLE employees (
    emp_id      INT PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    department  VARCHAR(50),
    job_title   VARCHAR(50),
    salary      DECIMAL(10, 2),
    hire_date   DATE,
    city        VARCHAR(50),
    is_active   BOOLEAN DEFAULT TRUE
);

-- Insert sample data
INSERT INTO employees (first_name, last_name, department, job_title, salary, hire_date, city, is_active) VALUES
('Alice',   'sharma',   'Engineering',  'Senior Developer',   95000, '2019-03-15', 'Mumbai',     TRUE),
('Bob',     'Mehta',    'Marketing',    'Marketing Manager',  72000, '2020-07-01', 'Delhi',      TRUE),
('Carol',   'Singh',    'Engineering',  'Junior Developer',   55000, '2022-01-10', 'Bangalore',  TRUE),
('David',   'Patel',    'HR',           'HR Manager',         68000, '2018-11-20', 'Mumbai',     TRUE),
('Eva',     'Nair',     'Engineering',  'Senior Developer',   95000, '2020-05-05', 'Chennai',    TRUE),
('Frank',   'Gupta',    'Marketing',    'Marketing Analyst',  48000, '2023-03-22', 'Delhi',      FALSE),
('Grace',   'Verma',    'Finance',      'Accountant',         62000, '2021-08-14', 'Pune',       TRUE),
('Henry',   'Joshi',    'Finance',      'Finance Manager',    85000, '2017-06-30', 'Mumbai',     TRUE),
('Isla',    'Rao',      'HR',           'HR Executive',       45000, '2023-01-15', 'Bangalore',  TRUE),
('Jack',    'Kumar',    'Engineering',  'Tech Lead',         110000, '2016-09-10', 'Hyderabad',  TRUE),
('Karen',   'Das',      'Marketing',    'Marketing Manager',  72000, '2019-12-01', 'Chennai',    FALSE),
('Leo',     'Bose',     'Engineering',  'Junior Developer',   55000, '2022-07-18', 'Pune',       TRUE),
('Mia',     'Pillai',   'Finance',      'Accountant',         62000, '2020-04-25', 'Delhi',      TRUE),
('Nathan',  'Iyer',     'Engineering',  'Senior Developer',   92000, '2018-02-28', 'Mumbai',     TRUE),
('Olivia',  'Reddy',    'HR',           'HR Manager',         68000, '2021-10-05', 'Hyderabad',  TRUE);

#like operator

#employee names whose names start with A
select *
from employees 
where first_name like "A%"; 

#employee names whose names start with a
select *
from employees 
where first_name like "a%"; 

#fetch the manager from the database

select * from employees
where job_title like "%manager%";

#is null - null handling 
#fetch the employees where city is not null

select * from employees
where city is not null;

#unique / distinct
select distinct
department
from employees;

#unique city
select distinct
department
city from employees;

#unique job title
select distinct job_title from employees;

#fetch unique department and city 
select distinct department  , city
from employees;

#Aggregation
#count of departments 
select count(distinct department ) as total_departments
from employees;

#sort by salary
select first_name, salary
from employees
order by salary desc;

#Ascending
select first_name, salary
from employees
order by salary;

#sorting + patter matching 
#last name stars with alphabatical order

select first_name, last_name, department
from employees
order by last_name asc;

# sort by department first, then salary desc
select first_name, last_name, department, salary
from employees
order by department asc, salary desc;

# sort - employees sort by old to new (oldest first)
select first_name, last_name
from employees
order by hire_date;

#limit
select * from employees limit 5;

#get top 3 higest paid employees
select first_name, last_name,salary
from employees 
order by salary desc
limit 3;

#get the most recently hired employee
select first_name, last_name
from employees
order by hire_date desc
limit 1;

#get the most recently hired employee
select first_name, last_name, salary
from employees
order by salary
limit 5;

#aggregation 

#total number os employees
select count(*) as total_employees
from employees; #count of ali the rows

# count active employees
select count(*) as active_employees
from employees
where is_active = true;

# total salary expensive 
select sum(salary) as total_salary
from employees;

# full the highest salary of an employees
select max(salary) as highest_salary 
from employees;

#lowest salary
select min(salary) as lowest_salary 
from employees;

# average salary avg ()
select department,avg(salary) as average_salary
from employees group by department;

#group by
#syntax

#select columns, agg ()
#from table
#

# 1. number of employees per department
select department, count(*) as no_emp_dept_wise
from employees
group by department;

#average salary per department
select department, avg(salary) as avg_salary
from employees
group by department;

# highest salary / lowest salary per department
SELECT department, MAX(salary) as avg_expense
FROM employees
GROUP BY department;

# lowest salary per department
select department , max(salary) as highest_salary,
min(salary) as lowest_salary;

#total salary in each department
select department, sum(salary) as total_sal_dept
from employees
group by department;

# multiple columns in group by department, city
select department, city, count(*) as employee_count
from employees
group by department, city;

# filter function group by - having!!!

#pul the department with more than 4 employees

select department, count(*) as total_emp4
from employees
group by department
having count(*) > 4;

select department,count(department) as total_employee4 
from employees
group by department 
having total_employee4> 4;

#pull the data of department earn more than avg salary 
select department, avg(salary) as avg_sal
from employees 
group by department 
having avg_sal > 70000;

#where  + group by

#pull the active employees in each department 
select department, count(*) as active_emp
from employees 
where is_active = true
group by department;

#where  + group by

#pull the active employees in each department  and it should be >2
select department, count(*) as active_emp
from employees
where is_active=true 
group by department
having active_emp >2;

-------------------------------------------------------

#advance having
#departement  where toatl salary > 200000

select department, sum(salary) as total_salary
from employees
group by department 
having sum(salary) > 200000;

#first- grouping happens deparment wise -> sum of salary -> applying filter on group
#multiple aggregation logic
#department where avg salary > 70000 and employee count >2

select department, count(*) as toatl_emp, avg(salary) as avg_salary
from employees
group by department
having count(*) >2 
and
avg(salary) >70000; #having can apply multiple condition on multiple aggregation

#cities where total expensive > 150000
select city, sum(salary)
from employees
group by city
having sum(salary)>150000;

#department having more than 1 job title
select department, count(distinct job_title) as unique_role
from employees
group by department
having unique_role >1;

#business case study -  HR data analyst, management wants insights

#find active employees hired after 20202 department wise

select department, count(*) as active_emp
from employees
where is_active = true
and hire_date > '2020-01-01'
group by department;

# find active employees hired after 20202 department wise with recent  hire > 1
select department, count(*) as active_emp
from employees
where is_active = true
and hire_date > '2020-01-01'
group by department
having count(*)>1;

#where department has average salary between 60000 & 90000
select department, avg(salary)
from employees
group by department
having avg(salary) between 60000 and 90000;