---prime number
declare 
a int:=50;
b int;
begin

for i in 2..a/2 loop
if mod(a,i)=0 then
b:=1;
exit;
end if;
end loop;

if b=1 then
dbms_output.put_line('it is non prime number');
else 
dbms_output.put_line('it is prime number');
end if;
end;
/
---number is negative or positive
 declare 
 a int :=&a;
 begin 
 if sign(a)=-1 then 
 dbms_output.put_line( 'it is negative');
 elsif sign(a)=1 then 
 dbms_output.put_line('it is positive');
 else 
 dbms_output.put_line('it is not');
 end if ;
 end;
 /
create or replace procedure sp_cust_grade(p_mon-yy varchar2,p_cust_name varchar2) as
v_cnt int;
begin
select count(sales_id) into v_cnt
from customer c,sales s
where c.cust_id=s.cust_id and cust_name=p_cust_name and to_char(sales_date,'mon-yy')=P-mon_yy;
if v_cnt>8 then
dbms_output_put_line('grade a');
if v_cnt>5 then
dbms_output_put_line('grade b');
if v_cnt> then
dbms_output_put_line('grade b');

/