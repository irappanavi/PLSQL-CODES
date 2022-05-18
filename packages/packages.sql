--Packages.
create or replace package pkg_proc as
v_cnt int;
procedure sp_p1;
function fn_f1 return int;
end;
/

CREATE OR REPLACE PACKAGE BODY pkg_proc as

procedure sp_pvt;
function fn_pvt return number;
v_cnt1 number;
---PUBLIC PROC
PROCEDURE sp_p1 as
BEGIN
dbms_output.put_line('asdfg');
sp_pvt;
v_cnt1:=fn_pvt;
dbms_output.put_line(v_cnt1);
end;
--PUBLIC FNS
FUNCTION fn_f1 RETURN int as
begin
select count(*) into v_cnt
from emp;
return v_cnt;
end;
--PRIVATE PROC
procedure sp_pvt as
begin
dbms_output.put_line('Private Procedure');
end;
---PRIVATE FNS
function fn_pvt return number as
begin
select count(*) into v_cnt1
from emp;
return v_cnt1;
end;
end;
/
exec pkg_proc.sp_pvt;
exec pkg_proc.sp_p1;
select pkg_proc.fn_pvt from dual;
/

---PACKAGE OVERLOAD
create or replace package pkg_over_load as
procedure sp_p1;
procedure sp_p1(p_no int);
procedure sp_p1(p_no int,p_no1 int);
procedure sp_p1(p_no float);
end;
/

