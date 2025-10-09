-- Q1
SELECT e.first_name || ' ' || e.last_name AS employee_name, j.job_title, d.department_name, l.city
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON l.location_id = d.location_id;

-- Q2.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees 
    WHERE department_id = e.department_id
);

-- Q3.
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id = (
    SELECT department_id 
    FROM employees
    WHERE first_name = 'Steven' AND last_name = 'King'
)
AND NOT (e.first_name = 'Steven' AND e.last_name = 'King');

-- Q4.
SELECT d.department_name, e.first_name || ' ' || e.last_name AS employee_name, e.salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(salary) 
    FROM employees
    WHERE department_id = e.department_id   
);

-- Q5.
SELECT *
FROM (
    SELECT l.city AS city, COUNT(e.employee_id) AS total_employees
    FROM employees e
    JOIN departments d 
    ON e.department_id = d.department_id
    JOIN locations l
    ON d.location_id = l.location_id
    GROUP BY l.city
    ORDER BY total_employees DESC
) 
WHERE ROWNUM = 1;

-- Q6.
SELECT d.department_name, m.first_name || ' ' || m.last_name AS manager_name, COUNT(e.employee_id) AS num_employees
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name, m.first_name, m.last_name;

-- Q7.
SELECT e.first_name || ' ' || e.last_name AS employee_name, e.hire_date, m.first_name || ' ' || m.last_name AS manager_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN employees m
ON d.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;

-- Q8.
SELECT j.job_title, ROUND(AVG(e.salary), 2) AS average_salary
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
GROUP BY j.job_title
HAVING AVG(e.salary) > 10000;

-- Q9.
SELECT d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

SELECT d.department_id, d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- Q10.
SELECT first_name || ' ' || last_name AS employee_name, salary, commission_pct
FROM employees
WHERE commission_pct = (
    SELECT MAX(commission_pct) 
    FROM employees
);

