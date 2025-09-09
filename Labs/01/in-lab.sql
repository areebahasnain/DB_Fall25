-- Q1.
SELECT * FROM employees WHERE salary IN (10000, 12000, 15000);

-- Q2.
SELECT * FROM employees WHERE salary IN (10000, 12000, 15000);

-- Q3.
SELECT first_name, salary FROM employees WHERE salary <= 25000;

-- Q4.
SELECT * FROM employees WHERE department_id <> 60;

-- Q5.
SELECT * FROM employees WHERE department_id BETWEEN 60 AND 80;

-- Q6.
SELECT * FROM departments;

-- Q7.
SELECT * FROM employees WHERE first_name = 'Steven';

-- Q8.
SELECT * FROM employees WHERE salary BETWEEN 15000 AND 25000 AND department_id = 80;

-- Q9.
SELECT * FROM employees WHERE salary < ANY (SELECT salary FROM employees WHERE department_id = 100);

-- Q10.
SELECT * FROM employees e WHERE (SELECT COUNT(*) FROM employees WHERE department_id = e.department_id) = 1;
