-- Q11.
ALTER TABLE employees
ADD CONSTRAINT unique_bonus UNIQUE (bonus);

-- Insert first employee (works)
INSERT INTO employees (emp_id, full_name, salary, dept_id, bonus)
VALUES (2, 'Alice', 25000, 1, 1500);

-- Insert second employee with same bonus (will fail)
INSERT INTO employees (emp_id, full_name, salary, dept_id, bonus)
VALUES (3, 'Bob', 30000, 2, 1500);

-- Q12.
ALTER TABLE employees
ADD dob DATE;

-- ALTER TABLE employees
-- ADD CONSTRAINT dob_constraint
-- CHECK (dob <= ADD_MONTHS(SYSDATE, -12*18));
-- ❌ This does not work because Oracle does not allow SYSDATE or CURRENT_DATE in CHECK constraints.
-- CHECK constraints must use fixed (deterministic) values, not system dates.

CREATE OR REPLACE TRIGGER trg_check_age
BEFORE INSERT OR UPDATE ON employees  -- when to run
FOR EACH ROW -- check each row individually
BEGIN
    IF :NEW.dob > ADD_MONTHS(SYSDATE, -12*18) THEN  -- calculate age
        RAISE_APPLICATION_ERROR(-20001, 'Employee must be at least 18 years old');
    END IF;
END;
/

-- Q13.
INSERT INTO employees (emp_id, full_name, salary, dept_id, bonus, dob)
VALUES (6, 'Young Employee', 25000, 1, 3000, TO_DATE('2010-09-10','YYYY-MM-DD'));

-- Q14.
ALTER TABLE employees
DROP CONSTRAINT fk_dept;

INSERT INTO employees (emp_id, full_name, salary, dept_id, bonus, dob)
VALUES (7, 'Invalid Employee', 28000, 99, 3500, TO_DATE('2000-05-10','YYYY-MM-DD'));

DELETE FROM employees WHERE dept_id = 99; -- remove invalid row so FK can be re-added

ALTER TABLE employees
ADD CONSTRAINT fk_dept FOREIGN KEY (dept_id)
REFERENCES departments(dept_id);

-- Q15.
ALTER TABLE employees
DROP COLUMN age;

ALTER TABLE employees
DROP COLUMN city;

-- Q16.
SELECT d.dept_id, d.dept_name, e.emp_id, e.full_name, e.salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- Q17.
ALTER TABLE employees
RENAME COLUMN salary TO monthly_salary;

-- Q18.
SELECT d.dept_id, d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);

-- Q19.
TRUNCATE TABLE students; -- faster, cannot be rolled back
-- DELETE FROM students; -- slower, but can be rolled back (undo)

-- Q20.
SELECT dept_id, COUNT(*) AS total_employees
FROM employees
GROUP BY dept_id
HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM employees
    GROUP BY dept_id
);
