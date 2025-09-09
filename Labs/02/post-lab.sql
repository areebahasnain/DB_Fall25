-- Q11
select lpad(first_name, 15, '*') as padded_name from employees;

-- Q12
select ltrim(' Oracle') as cleaned_string from dual;

-- Q13
select first_name, initcap(first_name) as capitalized_name from employees;

-- Q14
select next_day(date '2022-08-20', 'MONDAY') as next_monday from dual;

-- Q15
select to_char(to_date('25-DEC-2023', 'DD-MON-YYYY'), 'MM-YYYY') as formatted_date from dual;

-- Q16
select distinct salary from employees order by salary asc;

-- Q17
select salary, round(salary, -2) as rounded_salary from employees;

-- Q18
select department_id, count(*) as total_employees
from employees
group by department_id
having count(*) = (
    select max(count(*))
    from employees
    group by department_id
);

-- Q19
select department_id, total_salary
from (
    select department_id, sum(salary) as total_salary
    from employees
    group by department_id
    order by total_salary desc
)
where rownum <= 3;

-- Q20
select department_id, count(*) as total_employees
from employees
group by department_id
having count(*) = (
    select max(count(*))
    from employees
    group by department_id
);
