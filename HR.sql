create database HR;
use HR;

create table regions(
	id int identity(1,1) primary key,
	name varchar(100) not null,
)


create table departments(
	id int identity(1,1) primary key,
	name varchar(100) not null,
	manager_id int,
	location_id int
)


create table location(
	id int identity(1,1) primary key,
	address varchar(255),
	postal_code varchar(255),
	city varchar(255),
	country_id int 
)

create table countries(
	id int identity(1,1) primary key,
	name varchar(255),
	region_id int
)

create table job_history(
	id int identity(1,1) primary key,
	start_date datetime,
	end_date datetime,
	job_id varchar(10),
	department_id int
)

create table job(
	id varchar(10) primary key,
	title varchar(255),
	min_salary money,
	max_salary money
)


create table employees(
	id int identity(1,1) primary key,
	first_name varchar(255),
	last_name varchar(255),
	email varchar(255),
	phone varchar(10),
	hire_date datetime,
	job_id varchar(10),
	salarary money,
	commission_pct float,
	department_id int
)


create table job_grades(
	level int,
	lowest_sal money,
	highest_sal money,
)

--2 update id for job_grades

alter table job_grades 
	add id int identity(1,1) primary key

--3 update name table job to jobs
sp_rename 'job', 'jobs'


--4,5 insert data into tables

insert into regions values
('Ha Noi'),
('TP HCM'),
('NGU HANH SON'),


insert into departments values
('HR', 1, 1),
('PB1', 1, 1),
('PB2', 2, 1),
('PB3', 3, 2),
('PB4', 2, 3),
('PB5', 1, 4),


insert into job_history values
('2022-8-16 20:20:20','2022-8-17 22:22:22','AD_PRES',1),
('2022-8-16 19:19:19','2022-8-17 18:40:24','IT_PROG',2),
('2022-8-17 20:20:20','2022-8-18 23:23:21','ST_MAN',1),
('2022-8-18 20:20:20','2022-8-20 21:21:25','AD_PRES',3),


insert into countries values
('VIET NAM',1),
('LAO',1),
('CAMPUCHIA',1),


insert into employees values
('neymar','10','neymar@gmail.com','0816832750','2021-8-20 19:21:25','AD_PRES',4400000, 0.2, 2),
('messi','10','messi10@gmail.com','0816832747','2019-8-20 19:21:25','AD_PRES',40000000, 0.4, 1),
('cr','7','cr7@gmail.com','0816832749','2020-8-20 19:21:25','AD_PRES',3500000, 0.2, 2),
('bc','bd','bcde@gmail.com','0816832749','2022-8-20 21:21:24','AD_PRES',3500000, 0.1, 1),
('Le','Tao','levantao@gmail.com','0816832749','2021-8-20 21:21:25','AD_PRES',3500000, 0.5, 1),
('Em','Yeu','emyeu@gmail.com','0816832799','2020-8-20 20:21:20','ST_MAN',2500000, 0.2, 30),


insert into location values
('NGUYEN VAN LINH', '12345-1234', 'DA NANG', 1),
('HOANG DIEU', '12346-1233', 'DA NANG', 1),
('TON DUC THANG', '12347-1235', 'DA NANG', 1),


insert into jobs values
('AD_PRES','JOB1',9000000,20000000),
('IT_PROG','JOB2',7000000,25000000),
('ST_MAN','JOB3',4000000,10000000),

insert into job_grades values
(1,2000000,20000000),
(2,10000000,30000000),
(3,20000000,40000000)


--6 change email to 'hr@gmail.com' where name='hr' in table departments

update employees 
	set email='hr@gmail.com' 
	where department_id in 
		(select id from departments where name = 'HR')


--7 
--to change job ID of employee which ID is 2, 
--to SH_CLERK if the employee belongs to department, 
--which ID is 30 and the existing job ID does not 
--start with SH

update employees 
	set job_id = 'SH_CLERK' 
	where id = 2 
		and department_id = 30 
		and job_id not like 'SH%'


--8
--Write a SQL statement to increase the salary of 
--employees under the department 40, 90 and 110 
--according to the company rules that, salary will
--be increased by 25% for the department 40, 15% for 
--department 90 and 10% for the department 110 and 
--the rest of the departments will remain same.


update employees 
	set salarary = case department_id
			when 1 then salarary+(salarary*0.25)
			when 2 then salarary+(salarary*0.15)
			when 3 then salarary+(salarary*0.10)
			else salarary
		end

--9
 --Write a SQL statement to increase the minimum and 
 --maximum salary of PU_CLERK by 2000 as well as the 
 --salary for those employees by 20% and commission 
 --percent by .10.

UPDATE jobs,employees
	set 
	jobs.min_salary=jobs.min_salary+2000,
	jobs.max_salary=jobs.max_salary+2000, 
	employees.salary=employees.salary+(employees.salary*.20),
	employees.commission_pct=employees.commission_pct+.10
	where jobs.job_id='PU_CLERK'
	and employees.job_id='PU_CLERK';

 -- 10.
 --Write a SQL statement to change name table localtion to locations.
 
 sp_rename 'localtion', 'locations'

 -- 11 
 --Write a SQL statement to add a column 'region_id' after 'city' to the table locations.
 
 ALTER table locations 
	add region_id int 
	after city

 -- 12
 --Write a SQL statement to drop the column city from the table locations.
 
 alter table locations 
	drop column city

 --13
 --Write a SQL statement to add a primary key for a combination of columns location_id and country_id
 
 alter table locations 
	add primary key(id, country_id)

 --14
 --Write a SQL statement to drop the existing primary from the table locations on a 
 --combination of columns location_id and country_id
 
 alter table locations
	drop CONSTRAINT primary key(id, country_id)

 --15
 --Write a SQL statement to add a foreign key on job_id column of job_history table referencing 
 --to the primary key job_id of jobs table

 alter table job_history 
	add foreign key(job_id) 
		references jobs(id)

 --16
 --Write a SQL statement to add an index named indx_job_id on job_id column in the table job_history
 
 alter table job_history 
	add INDEX inds_job_id(job_id)

 --17
 -- Write a query to get first name from employees table after removing white spaces from both side
 
 select TRIM(first_name) 
	from employees

 --18
 --Write a query to get unique department ID from employee table

 select distinct department_id from employees
 select department_id from employees group by department_id

 --19
 --Write a query to get all employee details from the employee table order by first name, descending

 select * from employees 
	order by first_name 
		desc

 --20
 --Write a query to get the employee ID, names (first_name, last_name), 
 --salary in ascending order of salary.

select id, CONCAT(first_name, last_name) as name, salarary 
	from employees 
		order by salarary desc

--21
--Write a query to get the average salary and number of employees in the employees table

select AVG(salarary) as 'average salary', 
	   count(*) as 'number' 
	from employees

--22
--Write a query to get the number of employees working with the company.

select count(*) as number 
	from employees

--23
--Write a query to get the number of jobs available in the employees table

select count(distinct job_id) 
	as 'job available' 
	from employees

--24
--Write a query get all first name from employees table in upper case

select UPPER(first_name) 
	from employees

--25
--Write a query to get the first 3 characters of first name from employees table.

select SUBSTRING(first_name,3,1) 
	from employees

--26
--Write a query to get the length of the employee names (first_name, last_name) from employees table
--c1
select LEN(first_name+last_name) as 'length' 
	from employees
--c2
select LEN(CONCAT(first_name,last_name)) as 'length' 
	from employees

--27
--Write a query to check if the first_name fields of the employees table contains numbers

SELECT * FROM employees 
	WHERE  first_name like  '%0%' 
		or first_name like  '%1%'
		or first_name like  '%2%'
		or first_name like  '%3%'
		or first_name like  '%4%'
		or first_name like  '%5%'
		or first_name like  '%6%'
		or first_name like  '%7%'
		or first_name like  '%8%'
		or first_name like  '%9%'


--28
--Write a query to select first 10 records from a table.

select top 10 * 
	from job_history

--29
--Write a query to display the name (first_name, last_name) and salary for all employees 
--whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100

select CONCAT(first_name, last_name) as name 
	from employees 
		where salarary 
			between 10000000 and 30000000 
			and (department_id = 30 or department_id =100)


--30 
-- Write a query to display the name (first_name, last_name) and hire date for all employees 
--who were hired in 2020

select CONCAT(first_name, last_name) as name 
	from employees 
		where YEAR(hire_date) = 2020

--31 
--Write a query to display the first_name of all employees who have both "b" and "c" in their 
--first name
--c1
select CONCAT(first_name, last_name) as name
	from employees 
		where first_name like '%b%c%'
--c2
select first_name
	from employees
		where first_name like '%b%'
		  and first_name like '%c%';


--32
--Write a query to display the last name of employees whose names have exactly 6 characters.

select last_name 
	from employees 
		where LEN(last_name) = 6

--33
--Write a query to display the last name of employees having 'e' as the third character.

select last_name 
	from employees 
		group by last_name 
			having SUBSTRING(last_name,3,1) like 'e'

--34
--Write a query to select all record from employees where last name in 'BLAKE', 
--'SCOTT', 'KING' and 'FORD'.
--c1
select * 
	from employees 
		where last_name like '%BLAKE%' 
		   or last_name like '%SCOTT%'
		   or last_name like '%KING%'
           or last_name like '%FORD%'
--c2
select * 
	from employees 
	where last_name 
		   IN ('BLAKE', 'SCOTT', 'KING', 'FORD')

--35
--Write a query to get the maximum salary of an employee working as a Programmer.(IT_PROG)

select max_salary 
	from jobs 
		where id like 'IT_PROG'

--36
--Write a query to get the average salary and number of employees working the department 3

select AVG(salarary) as 'average salary', COUNT(*) 
	from employees 
		where department_id = 3

--37
-- Write a query to get the highest, lowest, sum, and average salary of all employees

select MAX(salarary) as highes, 
	   MIN(salarary) as lowest, 
	   SUM(salarary) as 'sum', 
	   AVG(salarary) as 'avg' 
	   from employees

--38
-- Write a query to get the difference between the highest and lowest salaries

select MAX(salarary) - MIN(salarary) 
	as 'difference' 
	from employees

--39
--Write a query to get the department ID and the total salary payable in each department.

select department_id, 
	   SUM(salarary) 
		as 'total salary payable' 
			from employees 
				group by department_id

--40
--Write a query to get the average salary for all departments employing more than 10 employees.

select AVG(salarary) 
	   as 'average salary' 
		from employees 
			group by department_id 
				having count(department_id) > 10

--41 
--Write a query to find the name (first_name, last_name) and the salary of 
--the employees who have a higher salary than the employee whose last_name='Bull'

select CONCAT(first_name, last_name) 
		as 'name' 
			from employees 
				where salarary > (
					select salarary 
						from employees 
							where last_name like 'Bull')

--42
--Write a query to find the name (first_name, last_name) of all employees who works 
--in the IT department

select CONCAT(first_name, last_name) 
	as 'name' 
		from employees 
			where department_id in(
				select id 
					from departments 
						where name like 'IT' 
					)

--43 
--Write a query to find the name (first_name, last_name), and salary of the employees whose salary 
--is greater than the average salary

select CONCAT(first_name, last_name) 
	as 'name', 
	salarary 
		from employees 
			where salarary >
				(select AVG(salarary) 
					from employees
				)

--44
--Write a query to find the name (first_name, last_name), and salary of the employees 
--who earn the same salary as the minimum salary for all departments

select CONCAT(first_name, last_name) 
	as 'name', 
	salarary 
		from employees 
			where salarary = 
			(select MIN(salarary) 
				from employees
			)

-- 45
--Write a query to display the employee ID, first name, last name, 
--and department names of all employees.

select e.id, first_name, last_name, d.name from employees e 
	left join departments d 
	on e.department_id = d.id 

--46
--Write a query to find the 5th maximum salary in the employees table.

	select * 
		from employees 
			order by salarary desc 
				LIMIT 1,5

--47
--- Write a query to get 3 maximum salaries.

select top 3 * 
	from employees 
		order by salarary desc

--48
--Write a query to find the name (first_name, last name), department ID and name of all the employees

select CONCAT(first_name, last_name) 
	as 'name', 
	department_id, 
	d.name 
		from employees e
			left join departments d 
			on e.department_id = d.id

--49
--Write a query to find the name (first_name, last_name), job, 
--department ID and name of the employees who works in "Da Nang"

select CONCAT(first_name, last_name) 
	as nameEmploy,job_id 
	as job, 
	department_id, 
	d.name 
	as nameDepartment 
		from employees e
			join departments d 
			on e.department_id = d.id 
				join locations l 
				on d.location_id = l.id 
					where l.city like '%Da Nang%'

--50
--Write a query to get the department name and number of employees in the department

select d.name 
	as 'nameDepartment', COUNT(e.id) 
	as number from employees e 
		join departments d 
		on e.department_id = d.id
			group by e.department_id, d.name

--51
--Write a query to get the first name and hire date from employees table where hire date 
--between '2020-01-01' and '1987-06-30

select first_name, hire_date 
	from employees 
		where hire_date 
		between '1987-06-30' and '2020-01-01'

--52
--Write a query to get the years in which more than 10 employees joined.

select YEAR(hire_date) 
	from employees 
		group by YEAR(hire_date) 
			having count(YEAR(hire_date)) > 10

--53
--Write a query to update the portion of the phone_number in the employees table, 
--within the phone number the substring '124' will be replaced by '999'

update employees 
	set phone = replace(phone,'124','999')
		where phone like '%124%'

--54
--Write a query to append '@example.com' to email field

update employees 
	set email = concat(email, '@example.com');





