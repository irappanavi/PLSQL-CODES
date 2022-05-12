declare
cursor cur_details is select * from customer_retail;
v_rec customer_retail%rowtype;
begin
open cur_details;
loop
fetch cur_details into v_rec;
exit when cur_details%notfound;
dbms_output.put_line(v_rec.cust_name||','||v_rec.cust_email);
end loop;
close cur_details;
end;
/
declare
cursor cur_emp_grade is select ename,sal from emp;
v_ename emp.ename%type;
v_sal emp.sal%type;
begin
open cur_emp_grade;
loop
fetch cur_emp_grade into v_ename,v_sal;
exit when cur_emp_grade%notfound;
if v_sal>2500 then
dbms_output.put_line(v_ename||','||v_sal||','||'A grade');
elsif v_sal>1500 then
dbms_output.put_line(v_ename||','||v_sal||','||'B grade');
elsif v_sal>1000 then
dbms_output.put_line(v_ename||','||v_sal||','||'C grade');
else
dbms_output.put_line(v_ename||','||v_sal||','||'D grade');
end if;
end loop;
close cur_emp_grade;
end;
/
declare 
cursor cur_emp_details is select * from emp;
begin
for i in cur_emp_details loop
dbms_output.put_line(i.ename||','||i.sal||','||i.job);
end loop;
end;
/
declare 
cursor cur_emp_details(p_deptno number) is select * from emp where deptno=p_deptno;
begin
for i in cur_emp_details(20) loop
dbms_output.put_line(i.ename||','||i.sal||','||i.job||','||i.deptno);
end loop;
end;
/
declare
cursor cur_prod_details is  select * from (select p_name ,count(sales_id) as count_sales ,dense_rank() over (order by count(sales_id)desc)rnk
                                             from product_retail p,sales_retail s
                                             where p.prod_id=s.prod_id
                                             group by p_name)a
                                             
                                             where a.rnk<=10;
 begin 
 for i in cur_prod_details loop
 dbms_output.put_line(i.p_name || ','||i.count_sales);
 end loop;
 end;
 /
create or replace procedure sp_top_products as
cursor cur_prod_details is  select * from (select p_name ,count(sales_id) as count_sales ,dense_rank() over (order by count(sales_id)desc)rnk
                                             from product_retail p,sales_retail s
                                             where p.prod_id=s.prod_id
                                             group by p_name)a
                                             
                                             where a.rnk<=10;
 begin 
 for i in cur_prod_details loop
 dbms_output.put_line(i.p_name || ','||i.count_sales);
 end loop;
 end;
/
create or replace procedure sp_guest_records as
cursor cur_guest_records is select name,phone,city,pro_flg from guests;
v_count varchar2(20);
v_name varchar2(20);
v_phone number(20);
v_city varchar2(20);

begin
for i in cur_guest_records loop
select count(*) into v_count
from customer_guest
where c_nm=i.name and c_phone=i.phone and c_city=i.city;

if v_count=1 then

select c_nm,c_phone,c_city into v_name,v_phone,v_city
from customer_guest
where c_nm=i.name and c_phone=i.phone and c_city=i.city;

dbms_output.put_line(i.name||','||i.phone||','||i.city);
delete from guests
where name=v_name and phone=v_phone and city=v_city;
dbms_output.put_line('row is deleted');

elsif i.pro_flg is null then

insert into call values(seq_guests.nextval,i.name,i.phone,i.city);
dbms_output.put_line('row is inserted');

update guests
set pro_flg='y';
dbms_output.put_line('row is updated');
end if;
end loop;
end;
/
create sequence seq_guests
start with 1
increment by 1
minvalue 1
maxvalue 100
nocycle;
/
exec sp_guest_records;

select *
from call;

drop sequence seq_guests;


