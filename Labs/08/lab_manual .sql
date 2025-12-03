SET SERVEROUTPUT ON;

DECLARE
    v_Sec_name VARCHAR(20) := 'Sec_A';
    v_course_name VARCHAR(30) := 'Database Systems Lab';
BEGIN
    dbms_output.put_line('This is ' || v_Sec_name || ' and the course is ' || v_course_name);
END;
/

DECLARE 
    a INTEGER := 10;
    b INTEGER := 20;
    c INTEGER;
    f REAL;
BEGIN
c := a + b;
dbms_output.put_line('Value of c: ' || c);

f := 70.0 / 3.0;
dbms_output.put_line('Value of f: ' || f);
END;
/

--- Outer (global) vs Inner (local) Variables
DECLARE 
    num1 NUMBER := 95; -- outer/global
    num2 NUMBER := 85;
BEGIN
    dbms_output.put_line('Outer num1: ' || num1);
    dbms_output.put_line('Outer num2: ' || num2);
    DECLARE
    num1 NUMBER := 195; -- inner/local
    num2 NUMBER := 185;
    BEGIN
        dbms_output.put_line('Inner num1: ' || num1);
        dbms_output.put_line('Inner num2: ' || num2);
    END;
    dbms_output.put_line('Back to outer num1: ' || num1);
    dbms_output.put_line('Baack to outer num2: ' || num2);
END;
/

--- %TYPE and SELECT ... INTO
DECLARE
    v_emp_id employees.employee_id%TYPE := 100;
    v_id employees.employee_id%TYPE;
    v_fname employees.first_name%TYPE;
    v_lname employees.last_name%TYPE;
    v_dept_name departments.department_name%TYPE;
BEGIN
    SELECT e.employee_id, e.first_name, e.last_name, d.department_name
    INTO v_id, v_fname, v_lname, v_dept_name
    FROM employees e
        INNER JOIN departments d
            ON e.department_id = d.department_id
    WHERE e.employee_id = v_emp_id;

    dbms_output.put_line('EMPLOYEE ID: '      || v_id);
    dbms_output.put_line('First Name: '       || v_fname);
    dbms_output.put_line('Last Name: '        || v_lname);
    dbms_output.put_line('Department Name: '  || v_dept_name);
END;
/

--- IF-ELSE
DECLARE
  v_emp_id employees.employee_id%TYPE := 1100;
  v_count  NUMBER;
BEGIN
  SELECT COUNT(1)
  INTO   v_count
  FROM   employees
  WHERE  employee_id = v_emp_id;

  IF v_count > 0 THEN
    dbms_output.put_line('Record already exists for employee ' || v_emp_id);
  ELSE
    INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
    VALUES (v_emp_id, 'Bruce', 'Austin', 'DAUSTIN7','590.423.4569', DATE '2005-06-25', 'IT_PROG', 6000, 0.2, 100, 60);

    dbms_output.put_line('Record inserted with employee ID: ' || v_emp_id);
  END IF;
END;
/

--- IF-ELSEIF-ELSE
DECLARE
  v_emp_id employees.employee_id%TYPE := 100;
  v_sal    employees.salary%TYPE;
BEGIN
  SELECT salary INTO v_sal
  FROM   employees
  WHERE  employee_id = v_emp_id;

  IF v_sal <= 15000 THEN
    UPDATE employees SET salary = v_sal + 300 WHERE employee_id = v_emp_id;
    dbms_output.put_line('Salary updated by 300. Old: ' || v_sal);
  ELSIF v_sal <= 20000 THEN
    UPDATE employees SET salary = v_sal + 200 WHERE employee_id = v_emp_id;
    dbms_output.put_line('Salary updated by 200. Old: ' || v_sal);
  ELSIF v_sal <= 25000 THEN
    UPDATE employees SET salary = v_sal + 100 WHERE employee_id = v_emp_id;
    dbms_output.put_line('Salary updated by 100. Old: ' || v_sal);
  ELSE
    UPDATE employees SET salary = v_sal + 400 WHERE employee_id = v_emp_id;
    dbms_output.put_line('Salary updated by 400. Old: ' || v_sal);
  END IF;
END;
/

-- CASE on department_id
SET SERVEROUTPUT ON;

DECLARE
  v_emp_id employees.employee_id%TYPE := 100;
  v_sal    employees.salary%TYPE;
  v_dept   employees.department_id%TYPE;
BEGIN
  SELECT salary, department_id
  INTO   v_sal, v_dept
  FROM   employees
  WHERE  employee_id = v_emp_id;

  CASE v_dept
    WHEN 80 THEN
      UPDATE employees SET salary = v_sal + 100 WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 80: +100');
    WHEN 50 THEN
      UPDATE employees SET salary = v_sal + 200 WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 50: +200');
    WHEN 40 THEN
      UPDATE employees SET salary = v_sal + 300 WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 40: +300');
    ELSE
      dbms_output.put_line('No raise rule for this department.');
  END CASE;
END;
/

-- CASE on department_id (compact + cleaner)
--- But it DOES NOT allow dbms_output.put_line, because it’s a value expression, not a block.
DECLARE
    v_emp_id employees.employee_id%TYPE := 100;
    v_sal    employees.salary%TYPE;
    v_dept   employees.department_id%TYPE;
BEGIN
    SELECT salary, department_id
    INTO   v_sal, v_dept
    FROM   employees
    WHERE  employee_id = v_emp_id;

    UPDATE employees
    SET salary = CASE 
        WHEN v_dept = 80 THEN v_sal + 100
        WHEN v_dept = 50 THEN v_sal + 200
        WHEN v_dept = 40 THEN v_sal + 300
        ELSE v_sal
    END
    WHERE employee_id = v_emp_id;
END;
/
    
--- Searched CASE (conditions in WHEN)
DECLARE
  v_emp_id employees.employee_id%TYPE := 100;
  v_sal    employees.salary%TYPE;
  v_dept   employees.department_id%TYPE;
BEGIN
  SELECT salary, department_id
  INTO   v_sal, v_dept
  FROM   employees
  WHERE  employee_id = v_emp_id;

  CASE
    WHEN v_dept = 80 AND v_sal < 20000 THEN
      UPDATE employees SET salary = v_sal + 150 WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 80 & low salary: +150');
    WHEN v_dept = 50 THEN
      UPDATE employees SET salary = v_sal + 100 WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 50: +100');
    ELSE
      dbms_output.put_line('No CASE condition matched');
  END CASE;
END;
/

--- NESTED IF
DECLARE
  v_emp_id employees.employee_id%TYPE := 100;
  v_sal    employees.salary%TYPE;
  v_dept   employees.department_id%TYPE;
  v_comm   employees.commission_pct%TYPE;
BEGIN
  SELECT salary, department_id, commission_pct
  INTO   v_sal, v_dept, v_comm
  FROM   employees
  WHERE  employee_id = v_emp_id;

  IF v_dept = 90 THEN
    IF v_sal BETWEEN 20000 AND 25000 THEN
      UPDATE employees
      SET salary = (v_sal + 100) * (1 + NVL(v_comm,0))
      WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 90, high salary band');
    ELSIF v_sal BETWEEN 15000 AND 20000 THEN
      UPDATE employees
      SET salary = (v_sal + 200) * (1 + NVL(v_comm,0))
      WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 90, mid salary band');
    END IF;
  ELSIF v_dept = 40 THEN
    IF v_sal BETWEEN 10000 AND 15000 THEN
      UPDATE employees
      SET salary = (v_sal + 100) * (1 + NVL(v_comm,0))
      WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 40, high salary band');
    ELSIF v_sal BETWEEN 5000 AND 10000 THEN
      UPDATE employees
      SET salary = (v_sal + 200) * (1 + NVL(v_comm,0))
      WHERE employee_id = v_emp_id;
      dbms_output.put_line('Dept 40, mid salary band');
    END IF;
  ELSE
    dbms_output.put_line('No nested rule for this department.');
  END IF;
END;
/

--- LOOPS
DECLARE
BEGIN
  FOR c IN (
    SELECT employee_id, first_name, salary
    FROM   employees
    WHERE  department_id = 90
  )
  LOOP
    dbms_output.put_line(
      'Salary for employee ' || c.first_name ||
      ' (ID ' || c.employee_id || ') is: ' || c.salary
    );
  END LOOP;
END;
/

--- VIEW
CREATE OR REPLACE VIEW simple_employee_view AS
SELECT employee_id, first_name, last_name, email, salary
FROM   employees
WHERE  department_id = 80;

SELECT * FROM simple_employee_view;

--- Complex VIEW with JOIN
CREATE OR REPLACE VIEW complex_emp_dept_view AS
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name,
       e.salary
FROM   employees e
       JOIN departments d ON e.department_id = d.department_id
WHERE  e.salary > 5000;

SELECT * FROM complex_emp_dept_view;

--- Functions : total salary of a department
CREATE OR REPLACE FUNCTION CalculateSAL (p_dept_id IN NUMBER)
RETURN NUMBER
IS
  v_total_salary NUMBER;
BEGIN
  SELECT SUM(salary)
  INTO   v_total_salary
  FROM   employees
  WHERE  department_id = p_dept_id;

  RETURN v_total_salary;
END;
/

SELECT CalculateSAL(80) AS dept_80_total_salary FROM dual;

--- Procedure (Insert into LOCATIONS)
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE Insert_Data(
  p_street_address IN VARCHAR2,
  p_postal_code    IN VARCHAR2 DEFAULT NULL,
  p_city           IN VARCHAR2,
  p_state_province IN VARCHAR2,
  p_country_id     IN CHAR
)
IS
  v_total_records INT;
  v_location_id   NUMBER;
BEGIN
  SELECT NVL(MAX(location_id), 0)
  INTO   v_location_id
  FROM   locations;

  v_location_id := v_location_id + 1;
  v_total_records := v_location_id;

  INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
  VALUES (v_location_id, p_street_address, p_postal_code, p_city, p_state_province, p_country_id);

  dbms_output.put_line('NEW RECORD INSERTED WITH ID: ' || v_location_id);
  dbms_output.put_line('TOTAL NO OF RECORDS (approx): ' || v_total_records);
END;
/

EXEC Insert_Data('DHA', '1234', 'KARACHI', 'SINDH', 'PK');

-- Explicit Cursor
SET SERVEROUTPUT ON;

DECLARE
  CURSOR cursor_emp IS
    SELECT employee_id, first_name, phone_number, salary
    FROM   employees
    ORDER  BY salary DESC;

  v_row cursor_emp%ROWTYPE;
BEGIN
  OPEN cursor_emp;

  LOOP
    FETCH cursor_emp INTO v_row;
    EXIT WHEN cursor_emp%NOTFOUND;

    dbms_output.put_line(
      'EMPLOYEE ID: '      || v_row.employee_id ||
      ', NAME: '           || v_row.first_name ||
      ', CONTACT: '        || v_row.phone_number ||
      ', SALARY: '         || v_row.salary
    );
  END LOOP;

  CLOSE cursor_emp;
END;
/

