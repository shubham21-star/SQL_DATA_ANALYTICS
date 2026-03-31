# create database
create database join_1;
use join_1;

# create tables
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

# insert data
insert into employees values
(1, 'amit', 101, 50000),
(2, 'priya', 102, 60000),
(3, 'rahul', 101, 55000),
(4, 'sneha', 103, 40000),
(5, 'karan', null, 45000);

insert into departments values
(101, 'hr'),
(102, 'it'),
(103, 'finance'),
(104, 'marketing');

# -------------------------------
# inner join
# only matching records
# -------------------------------
select e.emp_name, d.dept_name
from employees e
inner join departments d
on e.dept_id = d.dept_id;

# -------------------------------
# left join
# all employees + matching dept
# -------------------------------
select e.emp_name, d.dept_name
from employees e
left join departments d
on e.dept_id = d.dept_id;

# -------------------------------
# right join
# all departments + employees
# -------------------------------
select e.emp_name, d.dept_name
from employees e
right join departments d
on e.dept_id = d.dept_id;

# -------------------------------
# full join using union
# -------------------------------
select e.emp_name, d.dept_name
from employees e
left join departments d
on e.dept_id = d.dept_id

union

select e.emp_name, d.dept_name
from employees e
right join departments d
on e.dept_id = d.dept_id;

# -------------------------------
# join + where
# employees in it department
# -------------------------------
select e.emp_name, d.dept_name
from employees e
inner join departments d
on e.dept_id = d.dept_id
where d.dept_name = 'it';

# -------------------------------
# join + group by
# count employees in each dept
# -------------------------------
select d.dept_name, count(e.emp_id) as total_emp
from employees e
join departments d
on e.dept_id = d.dept_id
group by d.dept_name;

# -------------------------------
# avg salary in each dept
# -------------------------------
select d.dept_name, avg(e.salary) as avg_salary
from employees e
join departments d
on e.dept_id = d.dept_id
group by d.dept_name;

# -------------------------------
# having condition
# dept with more than 1 employee
# -------------------------------
select d.dept_name, count(e.emp_id) as total_emp
from employees e
join departments d
on e.dept_id = d.dept_id
group by d.dept_name
having count(e.emp_id) > 1;

# =========================================
# self join
# =========================================

create database selfjoin;
use selfjoin;

create table employees (
    emp_id int,
    emp_name varchar(50),
    manager_id int,
    salary int
);

insert into employees values
(1, 'amit', null, 90000),
(2, 'priya', 1, 60000),
(3, 'rahul', 1, 55000),
(4, 'sneha', 2, 40000),
(5, 'karan', 2, 45000),
(6, 'arjun', 3, 50000);

# employee and manager
select e.emp_name as employee, m.emp_name as manager
from employees e
left join employees m
on e.manager_id = m.emp_id;

# only employees having manager
select e.emp_name as employee, m.emp_name as manager
from employees e
inner join employees m
on e.manager_id = m.emp_id;

# count employees under each manager
select m.emp_name as manager, count(e.emp_id) as total_emp
from employees e
join employees m
on e.manager_id = m.emp_id
group by m.emp_name;

# employees earning more than manager
select e.emp_name, e.salary, m.emp_name as manager, m.salary
from employees e
join employees m
on e.manager_id = m.emp_id
where e.salary > m.salary;

# =========================================
# cross join
# =========================================

create database crossjoin;
use crossjoin;

create table employees (
    emp_id int,
    emp_name varchar(50)
);

insert into employees values
(1, 'amit'),
(2, 'priya'),
(3, 'rahul');

create table departments (
    dept_id int,
    dept_name varchar(50)
);

insert into departments values
(101, 'hr'),
(102, 'it');

# cross join (all combinations)
select e.emp_name, d.dept_name
from employees e
cross join departments d;

# unique employee pairs
select e1.emp_name, e2.emp_name
from employees e1
cross join employees e2
where e1.emp_id < e2.emp_id;