
select 1,to_char(to_date('12-04-2022','dd-mm-yyyy'),'d')day_week,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'dd')day_month,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'ddd')day_year,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'w')week_month,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'ww')week_year,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'mm')month_no,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'mon')month_short_name,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'month')month_name,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'q')quarter_name,
         case when to_char(to_date('12-04-2022','dd-mm-yyyy'),'mm')  <=6 then 1
         else 2 end semester_no,
         to_char(to_date('12-04-2022','dd-mm-yyyy'),'yyyy')Calender_year,
         to_char(add_months(to_date('12-04-2022','dd-mm-yyyy'),-3),'mm')fiscal_month,
         to_char(add_months(to_date('12-04-2022','dd-mm-yyyy'),-3),'ww')fiscal_week,
         to_char(add_months(to_date('12-04-2022','dd-mm-yyyy'),-3),'q')fiscal_qtr,
         to_char(add_months(to_date('12-03-2022','dd-mm-yyyy'),-3),'yyyy')fiscal_year,
         case when to_char(to_date('12-04-2022','dd-mm-yyyy'),'dy') not in ('sat','sun') then 'Yes'
         else 'No' end Week_day_flag
from dual;
/


create or replace procedure sp_date_dim(v_Date in date) as
first_date date;
last_date date;
v_cnt int;
begin
first_date:=trunc(v_date,'yyyy');
last_date:=add_months(first_date,12);

select count(date_key) into v_cnt
from date_dimension
where calender_year=to_char(v_date,'yyyy');
if v_cnt=0 then
while first_date<last_date loop
insert into date_dimension select
         sq_date_dim.nextval,
         first_date,
         to_char(first_date,'d'),
         to_char(first_date,'dd'),
         to_char(first_date,'ddd'),
         to_char(first_date,'w'),
         to_char(first_date,'ww'),
         to_char(first_date,'mm'),
         to_char(first_date,'mon'),
         to_char(first_date,'month'),
         to_char(first_date,'q'),
         case when to_char(first_date,'mm')  <=6 then 1
         else 2 end,
         to_char(first_date,'yyyy'),
         to_char(add_months(first_date,-3),'mm'),
         to_char(add_months(first_date,-3),'ww'),
         to_char(add_months(first_date,-3),'q'),
         to_char(add_months(first_date,-3),'yyyy'),
         case when to_char(first_date,'dy') not in ('sat','sun') then 'Yes'
         else 'No' end
         from dual;
first_date:=first_date+1;

end loop;
else
dbms_output.put_line('Dates already populated for '||to_char(v_date,'yyyy'));
end if;
Exception
when others then
dbms_output.put_line(sqlcode||'-'||sqlerrm);
end;
/

exec sp_date_dim('13-mar-2025');
set serveroutput on;

/
select * from date_dimension;

truncate table date_dimension;
create sequence sq_date_dim;
/
-- Write a procedure to display the records of employees whose salary is greater than 10000.
create or replace procedure sp_emp as
cursor c_emp is select * from emp where sal>10000;
begin
for i in c_emp loop
dbms_output.put_line(i.ename);
end loop;
end;
/
exec sp_emp;
/
-- Write a procedure to increment the salary of an employee based on his salary
--If salary>20000 increment by 1500
--If salary>10000 increment by 1000
--If salary>5000 increment by 500
--Else ‘no increment’
/
create or replace procedure sp_emp_sal as
cursor cur_sal is select * from emp;
begin
    for i in cur_sal loop
        if i.sal>20000 then
        update emp
        set sal=i.sal+1500;
        elsif i.sal>10000 then
            update emp
            set sal=i.sal+1000;
        elsif i.sal>5000 then
                update emp
                set sal=i.sal+500;
        else
            dbms_output.put_line('No increment');
        end if;
      end loop;
end;      
/
exec sp_emp_sal;

select * from emp;

select * from user_triggers;
/
--Write a procedure to print total salary with respect to department.(deptwise total sal)
create or replace procedure sp_toltal_sal as
cursor cur_total is select deptno,sum(sal) sum_sal
                    from emp
                    group by deptno;
begin
    for i in cur_total loop
    dbms_output.put_line(i.deptno||' '||i.sum_sal);
    end loop;
 end;   
 /
exec sp_toltal_sal;
/
--Write a procedure to print ename, job, mgr and deptno using record type by passing the deptno at runtime.
create or replace procedure sp_prod(p_deptno number)as
cursor cur_pr is select ename,job,mgr,deptno
                 from emp
                 where deptno=p_deptno;
begin
    for i in cur_pr loop
    dbms_output.put_line(i.ename);
    end loop;
end;   
/
select * from emp;
/
exec sp_prod(10);
/

 