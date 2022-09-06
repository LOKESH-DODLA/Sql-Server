
use AssignmentDB;

-- 1
create table customers (
customer_id char(5) not null,
company_name varchar(40) not null,
contact_name varchar(30),
address_home varchar(60),
city char(15),
phone_number char(20),
fax_number char(24));

create table orders (
order_id integer not null,
customer_id char(5) not null,
order_date datetime,
shipped_date datetime,
freight money,
ship_name varchar(40),
ship_address varchar(60),
quantity integer );

-- 2

alter table orders add ship_region integer;

-- 3

alter table orders alter column ship_region char(8);

-- 4

alter table orders drop column ship_region;

-- 5

insert into orders values (
10, 'ord01', getdate(), getdate(), 100.0,
'Windstar', 'ocean', 1);

select * from orders;

--6

-- alter table orders add constrains order_date datetime default getdate() for order_date;

ALTER TABLE orders ADD CONSTRAINT order_date_constraint DEFAULT GETDATE() for order_date;

-- 7

sp_rename 'customers', 'town';


--8

create table department (
dep_id char(10) primary key,
department_name varchar(20) not null,
dep_location varchar(24));

insert into department values('d1', 'Rose', 'Dallas');
insert into department values('d2', 'Acco', 'Seattle');
insert into department values('d3', 'Mar', 'Dallas');

select * from department;


create table employee (
emp_id int primary key,
emp_firstname varchar(15) not null,
emp_lastname varchar(15) not null,
dep_id char(10) foreign key references department(dep_id));

insert into employee (emp_id, emp_firstname, emp_lastname, dep_id) 
select 25348, 'Matthew', 'Smith', 'd3' union
select 10102, 'Ann', 'Jones', 'd3' union 
select 18316, 'John', 'Barrimor', 'd1' union
select 29346, 'James', 'James', 'd2' ;
  
--  due to Forign key error while inserting in work_on table we have again inserting values with new emp_id 

insert into employee(emp_id, emp_firstname, emp_lastname, dep_id)
select 2581, 'Sam', 'Sing', 'd2' union
select 9031, 'Jam', 'Roy', 'd1' ;

insert into employee(emp_id, emp_firstname, emp_lastname, dep_id)
select 28559, 'some', 'one', 'd3';

select * from employee;


create table project (
project_no char(5) primary key,
project_name varchar(15),
project_budget money );


insert into project (project_no, project_name, project_budget)
select 'p1', 'Apollo', 120000 union
select 'p2', 'Gemini', 95000 union 
select 'p3', 'Mercury', 185600 ;

select * from project;

create table work_on (
emp_id int foreign key references employee(emp_id),
project_no char(5) foreign key references project(project_no),
job varchar(15),
enter_date date);

insert into work_on(emp_id, project_no, job, enter_date)
select 10102, 'p1', 'Analyst', '1997.10.1' union 
select 10102, 'p3', 'Manager', '1999.1.1' union
select 25348, 'p2', 'clerk', '1998.2.15';

select * from work_on;

insert into work_on (emp_id, project_no, enter_date)
select 18316, 'p2', '1998.6.1' union
select 29346, 'p2', '1997.12.15' ;

insert into work_on (emp_id, project_no, job, enter_date)
select 2581, 'p3', 'Analyst', '1998.10.15' union 
select 9031, 'p1', 'Manager', '1998.4.15' ;

insert into work_on (emp_id, project_no, enter_date)
select 28559, 'p1', '1998.8.1';


insert into work_on(emp_id, project_no, job, enter_date)
select 28559, 'p2', 'clerk', '1992.2.1' union 
select 9031, 'p3', 'clerk', '1997.11.15' union
select 29346, 'p1', 'clerk', '1998.1.4';


-- Simple Queries 

-- 1

select * from work_on;

-- 2

select emp_id from work_on where job = 'Clerk';

-- 3

select e.emp_id, w.project_no from employee e, work_on w where w.project_no = 'p2' and e.emp_id < 10000;


-- 4

select e.emp_id, year(w.enter_date) as Year from employee e, work_on w where w.emp_id = e.emp_id and year(w.enter_date) != '1998';


-- 5

select e.emp_id, w.project_no, w.job from employee e, work_on w where w.emp_id = e.emp_id and w.job in ('Analyst', 'Manager') and w.project_no = 'p1';

-- 6

-- 6.	Get the enter dates for all employess in project p2 whose jobs have not been determined yet.

select e.emp_id, w.project_no, w.job from employee e, work_on w where w.emp_id = e.emp_id and w.project_no = 'p2' and w.job is NULL;

-- 7

-- 7.	Get the employee numbers and last names of all employees whose first names contain two letter t’s.

select e.emp_id, e.emp_lastname from employee e, work_on w where w.emp_id = e.emp_id and emp_firstname like '%tt%';


-- 8. Get the employee numbers and first names of all employees whose last names have a letter o or a as the second character and end with the letters es.


select e.emp_id, e.emp_firstname from employee e, work_on w where e.emp_id = w.emp_id and e.emp_lastname like '_o%' or e.emp_lastname like '_a%' and e.emp_lastname like '%es';


-- 9.	Get the employee numbers of all employees whose departments are located in Seattle

select e.emp_id from employee e, department d where e.dep_id = d.dep_id and dep_location = 'Seattle';


-- 10.	Find the last and first names of all employess who entered their projects on 04.01.1998


select e.emp_id, e.emp_firstname, e.emp_lastname from employee e, work_on w where e.emp_id = w.emp_id and w.enter_date = '1998.1.4';


-- 11.	Group all departments using their locations.


select d.department_name from department d group by department_name; 


--  12.	Find the biggest employee number.

select Max(emp_id) from employee;


-- 13.	Get the jobs that are done by more than two employees.




-- 14.	Find the employee numbers of all employees who are clerks or work for department d3.

select e.emp_id from employee e, work_on w, department d where w.emp_id = e.emp_id and d.dep_id = e.dep_id and job = 'Clerk' and d.dep_id = 'd3';





-- Assignment Day 2 

use AssignmentDB;


-- 1 a
select emp_id, Job, project_name, project_budget 
from project inner join work_on on 
project.project_no = work_on.project_no;

-- b

-- c
select * from project cross join work_on;

select * from project cross join work_on where project.project_no = work_on.project_no;


select * from project, work_on;

-- 2.	Get the employee numbers and job titles of all employees working on project Gemini

select w.emp_id, w.job from project p, work_on w where p.project_name = 'Gemini';


-- 3.	Get the first and last names of all employees that work for departments Research or Acounting.

select e.emp_firstname, e.emp_lastname from employee e, department d where d.department_name = 'Research' or d.department_name = 'Accounting';


-- 4.	Get the enter dates of all clerks that belong to the department d1.

