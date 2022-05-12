--no data found.
declare
var_empno number(10):=50;
var_ename varchar2(20);
begin
select ename into var_ename
from emp
where deptno=var_empno;
dbms_output.put_line(var_ename);
EXCEPTION
when no_data_found then
dbms_output.put_line('no employee with the employee number'||var_empno);
end;
/

--too_many_rows
declare
var_empno number(20):=20;
v_ename varchar2(20);
begin
select ename into v_ename
from emp
where deptno=var_empno;
dbms_output.put_line(v_ename);
exception 
when too_many_rows then
dbms_output.put_line('trying to select too many rows');
end;
/
--value error
declare 
temp number;
begin
select ename into temp
from emp
where empno=7499;
dbms_output.put_line('the ename is'||temp);
exception
when value_error then
dbms_output.put_line('change the datatype of temp to varchar2');
end;
/
--zero divide
declare
a int(20):=10;
b int(20):=0;
c int;
begin
c:=a/b;
dbms_output.put_line('the result is'||c);
exception
when zero_divide then
dbms_output.put_line('dividing by zero please check the value again');
end;
/
--invalid number
declare
start_dt date:='02-jan-2002';
a int(20):=20;
c int(20);
begin
c:=start_dt+a;
dbms_output.put_line('the result is'||c);
exception
when invalid_number then
dbms_output.put_line('change the number');
end;

