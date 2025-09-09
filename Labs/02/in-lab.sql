-- Q1
select sum(salary) as total_salary from employees;

-- Q2
select avg(salary) as avg_salary from employees;

-- Q3
select manager_id, count(*) as total_employees from employees group by manager_id;

-- Q4
select * from employees where salary = (select min(salary) from employees);

-- Q5
select to_char(sysdate, 'DD-MM-YYYY') as current_date from dual;

-- Q6
select to_char(sysdate, 'DAY MONTH YYYY') as full_date from dual;

-- Q7
select * from employees where trim(to_char(hire_date, 'Day')) = 'Wednesday';

-- Q8
select months_between('01-JAN-2025', '01-OCT-2024') as months_diff from dual;

-- Q9
select employee_id, first_name, months_between(sysdate, hire_date) as months_worked from employees;

-- Q10
select last_name, substr(last_name, 1, 5) as first_five_chars from employees;
