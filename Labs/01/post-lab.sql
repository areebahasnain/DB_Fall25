-- Q11.
SELECT * FROM employees WHERE hire_date BETWEEN TO_DATE('01-JAN-2005','DD-MON-YYYY') AND TO_DATE('31-DEC-2006','DD-MON-YYYY');

-- Q12.
SELECT * FROM employees WHERE manager_id IS NULL;

-- Q13.
SELECT * FROM employees WHERE salary < ALL (SELECT salary FROM employees WHERE salary > 8000);

-- Q14.
SELECT * FROM employees WHERE salary > ANY (SELECT salary FROM employees WHERE department_id = 90);

-- Q15.
SELECT * FROM departments WHERE department_id IN (SELECT DISTINCT department_id FROM employees);

-- Q16.
SELECT * FROM departments d WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.department_id);

-- Q17.
SELECT * FROM employees WHERE salary NOT BETWEEN 5000 AND 15000;

-- Q18.
SELECT * FROM employees WHERE department_id IN (10, 20, 30) AND department_id <> 40;

-- Q19.
SELECT * FROM employees WHERE salary < (SELECT MIN(salary) FROM employees WHERE department_id = 50 AND salary IS NOT NULL);

-- Q20.
SELECT * FROM employees WHERE salary > (SELECT MAX(salary) FROM employees WHERE department_id = 90);
