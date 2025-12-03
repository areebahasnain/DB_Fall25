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
