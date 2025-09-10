DROP TABLE departments CASCADE CONSTRAINTS;
DROP TABLE employees CASCADE CONSTRAINTS;

-- Q1.
CREATE TABLE employees (
    emp_id INT PRIMARY KEY, -- PRIMARY KEY: automatically enforces not null + unique
    emp_name VARCHAR2(50) NOT NULL, -- NOT NULL ensures every employee has a name
    salary NUMBER CONSTRAINT chk_salary CHECK (salary > 20000),
    dept_id INT 
);

-- Q2.
ALTER TABLE employees
RENAME COLUMN emp_name TO full_name;

-- Q3.
ALTER TABLE employees
DROP CONSTRAINT chk_salary;

INSERT INTO employees (emp_id, full_name, salary, dept_id)
VALUES (1, 'Test Employee', 5000, NULL);

-- Q4.
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR2(30) UNIQUE
);

INSERT INTO departments (dept_id, dept_name) VALUES (1, 'HR');
INSERT INTO departments (dept_id, dept_name) VALUES (2, 'Finance');
INSERT INTO departments (dept_id, dept_name) VALUES (3, 'IT');

-- Q5.
ALTER TABLE employees
ADD CONSTRAINT fk_dept FOREIGN KEY (dept_id)
REFERENCES departments(dept_id);

-- Q6.
ALTER TABLE employees
ADD bonus NUMBER(6,2) DEFAULT 1000;

-- Q7.
ALTER TABLE employees
ADD (
    city VARCHAR2(30) DEFAULT 'Karachi',
    age NUMBER CONSTRAINT chk_age CHECK (age > 18)
);

-- Q8
DELETE FROM employees
WHERE emp_id IN (1, 3);

-- Q9
ALTER TABLE employees
MODIFY (
    full_name VARCHAR2(20),
    city VARCHAR2(20)
);


-- Q10
ALTER TABLE employees
ADD email VARCHAR2(50);

ALTER TABLE employees
ADD CONSTRAINT emp_email_unique UNIQUE (email);

