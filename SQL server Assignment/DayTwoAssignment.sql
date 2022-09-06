use AssignmentDB

--joins
select * from project as p inner join Works_on as w on p.project_no=w.project_no  ---natural join
select job from project as p inner join Works_on as w on p.project_no=w.project_no where p.project_no='p1'--equi jon
select * from project cross join Works_on ---cartesian join
--get emp_no,job  who works in project Gemini
select emp_no,job from Works_on where project_no in(select project_no from project where project_name='Gemini')
--get emplna,empfna of employees working in accounting and research
select empfna,emplna from Employee where deptid in(select Deptid from Department where deptname='Research' or deptname='Accounting')
--get empno who are clerks and from d1 department
select enter_date from Works_on where job='clerk' and emp_no in(select emp from Employee where deptid = 'd1' )
--get the project titles where two or more clerks are working
select p.project_name
from project p, works_on w
where p.project_no = w.project_no
group by w.job, w.project_no,p.project_name
having count (w.job) >=2
--first and last name of manager working in project mercury
select empfna,emplna
from Employee as e left join Works_on as w
on e.emp=w.emp_no join project as p
on w.project_no=p.project_no
where project_name='Mercury'
--get employee numbers living same location and same departemnt     
select distinct(e1.emp) from employee e1 inner join employee e2 on e1.deptid=e2.deptid group by e1.deptid,e1.emp having count(e1.deptid)>1
--get the empfna, emplna who are entered on the same date
select empfna,emplna
from Employee, works_on 
where emp = emp_no
group by empfna,emplna,enter_date
having count (enter_date) >1

--get emp no of marketing dept using join 
select emp
from Employee as e left join Department as d
on e.deptid=d.DeptId
where deptname='Marketing'
--get emp no of marketing dept using corelated subquery
select emp from Employee where deptid in(select deptid from Department where deptname='Marketing' )

--insert new employee in employee table
insert into Employee(emp,empfna,emplna) values(1111,'Julia', 'Long')
--create new table emp_d1_d2
create table emp_d1_d2(emp integer primary key not null,
empfna varchar(25) not null,
emplna varchar(25),
deptid char(10))
--load values from employee table to emp_d1_d2 table where depid are d1 or d2
insert into emp_d1_d2 select *from Employee where deptid='d1' or deptid='d2'
--modify the job of managers to clerks in project p1
update  Works_on set job='Clerk' where project_no='p1' and job ='Manager'
--assign all budgets as null values
update Project set Budget=null
--update budget to manager whose emp id 10120 upto 10%
update project set budget=budget+(budget*0.1)
from project p left join Works_on w
on p.project_no=w.project_no
where w.job='Manager' and w.emp_no=10102
--enter date 12.12.1998 in works_on table where dept sales and project p1    
update Works_on set enter_date='12.12.1998'
from Employee e inner join Works_on w
on e.emp=w.emp_no                         
where w.job='Sales' and w.emp_no=10102                                   


