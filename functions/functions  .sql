----1.Write a function to print the factorial of a number.
create or replace function fn_factorial(a number) return number as

n number(10):=1;
begin
for i in 1..a loop
n:=n*i;
end loop;
return n;
end;
/

select fn_factorial(5) from dual;
/
--3. Write a function that takes P,R,T as inputs and returns SI. SI=P*R*T/100

create or replace function fn_cal(p number,r number,t number) return number as

v_cnt number(20,2);

begin
v_cnt:=p*r*t/100;
return v_cnt;
end;
/
set serveroutput on;
/
select fn_cal(10,2,12) from dual;
/
--4.Write a function which takes a date in string format and display whether it is a valid date or not.
/
create or replace function fn_date(p_date varchar2 )return varchar2 as
v_date date ;
begin
v_date:=to_date(p_date,'dd-mon-yyyy');
if v_date = p_date then
return 'valid date';
else 
return 'not a valid date';
end if;
end;
/
select fn_date('15-mar-2020') from dual;
/

 --Write a function which takes a value from the user and check whether the given values is a number or not. If it is a number, return ‘ valid Number’ otherwise ‘invalid number’.
--Phone Number- should have 10 digits, all should be numbers and phno should start with 9 or 8 or 7.

create or replace function fn_phone(p_num number) return varchar2 as
begin 
if length(p_num)=10 and p_num like '9%' or   p_num like '8%'or  p_num like '7%' then
return 'valid phone number';
else
return ' not valid phone number';
end if ;
end;
/
select fn_phone(1223367409) from dual;
/
--9.Create a function that takes date as input and return the no of customers who made sales in that year.
/
create or replace function fun_cust(p_date varchar2) return number as
v_cnt number(10);
begin 
select count(s.cust_id) into v_cnt
from customer_retail c,sales_retail s
where c.cust_id=s.cust_id and to_char(sales_date,'yyyy')=p_date;
return v_cnt;
end;
/
select fun_cust('2020') from dual;
/
--10.Write  a function by passing 2 dates and return the no. of Saturdays between two dates.

create or replace function fn_cnt_sat(p_date VARCHAR2,q_date VARCHAR2) return number as
cnt number:=0;
a_date date:=p_date;
b_date date:=q_date;
   begin
   while a_date <= b_date loop
    if to_char(a_date,'dy')='sat' then
    cnt:=cnt+1;
   end if;
    a_date:=a_date+1;
   end loop;
   return cnt;
        exception 
    when others then 
    return -1;
   end;
/
select fn_cnt_sat('01-may-2022','28-may-2022')from dual;
/

---11.Write a function by passing  2 dates and display the months between 2 dates. Ex jan-15 and jul-15   o/p  Feb-15,Mar-15,Apr-15,May-15,Jun-15.

create or replace function fn_mon(p_date date,q_date date) return  varchar2 as
a_date date:=p_date;
begin
    while a_date < q_date loop
    a_date:=add_months(a_date,1);
    end loop;
    return a_date;
end;
/
select fn_mon('jan-15','jul-15')from dual;
 
/
create or replace function fn_hff(p_name varchar2) return sys_refcursor as
cnt number(20);
v_str varchar2(500);
v_ref sys_refcursor;
begin
open v_ref for select column_name from user_tab_columns where table_name=upper(p_name);
return v_ref;
end;
/

variable b_ref_exe ref cursor
exec :b_ref_exe:=fn_hff('emp');
print :b_ref_exe

desc emp
set serveroutput on

select fn_hff('emp') from dual;

select * from user_source where type='FUNCTION';
/
create or replace procedure sp_dyn(p_tbl_name varchar2) as
v_str varchar2(200);
v_cnt int;
begin
v_str:='select count(column_name) from user_tab_columns where table_name='||''''||upper(p_tbl_name)||'''';
--dbms_output.put_line(v_str);
execute immediate v_str into v_cnt;
dbms_output.put_line('no_of_columns:'||v_cnt);
end;
/
exec sp_dyn('emp')

select count(column_name) from user_tab_columns where table_name='DEPT'

/
--Create a function by passing to  2 strings, if it is a number print the sum of 2 numbers else print the concatenation of 2 strings.

create or replace function fn_string(a varchar2,b varchar2)  return varchar2 as
begin 
    if regexp_like(a,'^[0-9]+$') and regexp_like(b,'^[0-9]+$') then
    return a+b;
    else
    return a||b;
    end if;
end;
/
select fn_string(10,40) from dual;