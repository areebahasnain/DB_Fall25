-- Aggregate functions
select count(*) as total_employees from employees;
select count(*) as total_employees, manager_id from employees group by manager_id;
select distinct manager_id from employees;
select manager_id from employees;
select sum(salary) as total_salary from employees;
select min(salary) as min_salary from employees;
select max(salary) as max_salary from employees;
select avg(salary) as avg_salary from employees;

-- Concatenation
select first_name || salary as first_name_and_salary from employees;
select all salary from employees;
select salary from employees;
select salary from employees order by salary asc;
select first_name, hire_date from employees order by first_name asc;
select first_name from employees where first_name like 'A__%';
select first_name from employees where first_name like '%k%';

-- Dual table
select * from dual;

-- Numeric functions
select abs(-90.5) from dual;
select ceil(90.3) from dual;
select ceil(-90.3) from dual;
select floor(90.3) from dual;
select floor(-90.4) from dual;
select trunc(90.23466, 2) from dual;
select round(90.785) from dual;
select greatest(90, 99, 89) from dual;
select least(90, 99, 89) from dual;

-- String functions
select lower('Kinza') from dual;
select first_name, lower(first_name) from employees;
select first_name, upper(first_name) from employees;
select initcap('the soap') from dual;
select length('kinza') from dual;
select first_name, length(first_name) from employees;
select ltrim('   kinza') from dual;   -- removes spaces from left
select rtrim('kinza   ') from dual;   -- removes spaces from right
select substr('kinza khan', 7, 4) from dual;   -- 4 chars from 7th position
select lpad('good', 7, '*') from dual;   -- left-pad with *
select rpad('good', 7, '*') from dual;   -- right-pad with *

-- Date functions
select add_months('16-sep-2000', 2) from dual;
select months_between('16-dec-2024', '16-sep-2024') from dual;
select next_day('4-nov-1999', 'Wednesday') from dual;
select last_day('01-jun-08') from dual;
select new_time('01-jun-08', 'ISL', 'EST') from dual;

-- Conversion functions
select to_char(sysdate, 'DD-MM-YY') from dual;
select to_char(sysdate, 'Day') from dual;
select * from employees where to_char(hire_date, 'Day') = 'Monday   ';
