--  Q1.
SELECT e.name AS employee, d.dept_name as department
FROM employees e
CROSS JOIN departments d;

-- Q2.
SELECT d.dept_name, e.name AS employee
FROM departments d
LEFT OUTER JOIN employee e
ON d.dept_name = e.dept_name;

-- Q3.
SELECT e.name as employee, m.name as manager
FROM employees e
LEFT JOIN employees m
ON e.mgr_id = m.emp_id;

-- Q4.
SELECT e.name
FROM emplpoyees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id
WHERE p.emp_id IS NULL;

-- Q5.
SELECT s.name AS student, c.title AS course
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id;

-- Q6.
SELECT c.name AS customer, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- Q7.
SELECT d.dept_name, e.name AS employee
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;

-- Q8.
SELECT t.name AS teacher, s.title AS subject, ts.subject_id AS is_taught
FROM teachers t
CROSS JOIN subjects s
LEFT JOIN teaches ts
ON t.teacher_id = ts.teacher_id AND s.subject_id = ts.subject_id;

-- Q9.
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Q10.
SELECT s.name AS student, t.name AS teacher, c.title AS course
FROM students s
JOIN enrollment e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
JOIN teachers t
ON c.teacher_id = t.teacher_id;


