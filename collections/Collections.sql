---Bulk collect
create or replace procedure sp_coll as
type e_list is table of emp%rowtype;
emp_list e_list;
begin
select * bulk collect into emp_list 
from emp;
for i in 1.. emp_list .last loop
dbms_output.put_line(emp_list(i).ename||','||emp_list(i).sal);
end loop;
end;
/

delete emp
where sal is null;

exec sp_coll;

commit;
/
--Bulk bind
create or replace procedure sp_bind as
type e_list is table of emp.empno%type;
empno_list e_list:=e_list(7782,7369,7844);
begin
forall i in 1.. empno_list .last
update emp
set sal=sal+10499
where empno=empno_list(i);
end;
/
exec sp_bind;

rollback;

select*from emp;
/

















create table t
(id number(5),
name varchar2(20));


create or replace procedure sp_p1 as
begin
insert into t values(1,'a');
commit;
end;
/

create or replace procedure sp_p2 as
begin
insert into t values(2,'b');
sp_p1;
end;
/

exec sp_p2;

select*from t;
truncate table t;