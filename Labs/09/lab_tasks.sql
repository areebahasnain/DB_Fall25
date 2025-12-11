-- Q1
create table students (
  id int primary key,
  name varchar2(200)
);

create or replace trigger trg_students_name_upper
before insert on students
for each row
begin
  :new.name := upper(:new.name);
end;
/ --

insert into students values (1, 'areeba hasnain');

-- Q2
create table employees (
  id int primary key,
  name varchar2(200),
  salary int
);

create or replace trigger trg_emp_block_weekend_delete
before delete on employees
for each row
begin
  if to_char(sysdate, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') in ('SAT','SUN') then
    raise_application_error(-20001, 'Deletion blocked: Weekend restrictions apply');
  end if;
end;
/ --

insert into employees values (1, 'emp a', 100000);

-- Q3
drop table employees;

create table employees (
  id int primary key,
  name varchar2(200),
  salary int
);

create sequence log_salary_audit_seq start with 1 increment by 1 nocache;

create table log_salary_audit (
  audit_id int primary key,
  emp_id int,
  old_salary int,
  new_salary int,
  changed_at date
);

create or replace trigger trg_emp_salary_audit
after update of salary on employees
for each row
begin
  insert into log_salary_audit
  values (log_salary_audit_seq.nextval, :old.id, :old.salary, :new.salary, sysdate);
end;
/

insert into employees values (1, 'emp b', 20000);
update employees set salary = 25000 where id = 1;

-- Q4
create table products (
  id int primary key,
  name varchar2(200),
  price int
);

create or replace trigger trg_products_price_check
before update on products
for each row
begin
  if :new.price < 0 then
    raise_application_error(-20002, 'Error: Product price cannot be negative');
  end if;
end;
/

insert into products values (1, 'p1', 100);
update products set price = 200 where id = 1;

-- Q5
create table courses (
  id int primary key,
  name varchar2(100),
  created_by varchar2(50),
  created_at date
);

create or replace trigger trg_courses_meta_insert
before insert on courses
for each row
begin
  :new.created_by := user;
  :new.created_at := sysdate;
end;
/

insert into courses (id, name) values (1, 'math');

-- Q6
create table emp (
  id int primary key,
  name varchar2(200),
  department_id int
);

create or replace trigger trg_emp_assign_default_dept
before insert on emp
for each row
begin
  if :new.department_id is null then
    :new.department_id := 10;
  end if;
end;
/

insert into emp (id, name) values (1, 'e1');

-- Q7
create table sales (
  id int,
  amount int
);

create or replace trigger trg_sales_calc_totals
for insert on sales
compound trigger

  v_before number;
  v_after  number;

  before statement is
  begin
    select nvl(sum(amount), 0) into v_before from sales;
  end before statement;

  after statement is
  begin
    select nvl(sum(amount), 0) into v_after from sales;

    dbms_output.put_line('Total BEFORE inserts: ' || v_before);
    dbms_output.put_line('Total AFTER inserts: ' || v_after);
  end after statement;

end trg_sales_calc_totals;
/

insert into sales values (1, 120);

-- Q8
create sequence schema_ddl_log_seq start with 1 increment by 1 nocache;

create table schema_ddl_log (
  id int primary key,
  username varchar2(50),
  ddl_type varchar2(20),
  object_name varchar2(100),
  log_time date
);

create or replace trigger trg_schema_ddl_audit
after create or drop on schema
begin
  insert into schema_ddl_log
  values (
    schema_ddl_log_seq.nextval,
    sys_context('userenv','session_user'),
    ora_sysevent || ' operation',
    ora_dict_obj_name,
    sysdate
  );
end;
/

create table ddl_test (x int);
drop table ddl_test;

-- Q9
create table orders (
  id int primary key,
  order_status varchar2(20)
);

create or replace trigger trg_orders_block_shipped_update
before update on orders
for each row
begin
  if :old.order_status = 'SHIPPED' then
    raise_application_error(-20003, 'Update blocked: Order already shipped');
  end if;
end;
/

insert into orders values (1, 'SHIPPED');
update orders set order_status = 'PENDING' where id = 1;

-- Q10
create sequence login_audit_seq start with 1 increment by 1 nocache;

create table login_audit (
  id int primary key,
  username varchar2(50),
  login_time date
);

create or replace trigger trg_logon_audit
after logon on schema
begin
  insert into login_audit
  values (
    login_audit_seq.nextval,
    sys_context('userenv','session_user'),
    sysdate
  );
end;

/
