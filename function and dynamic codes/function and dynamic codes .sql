create or replace  function fn_holiday(p_date date) return number as
v_cnt number(20);
begin   
    select count(*) into v_cnt
    from holiday 
    where dt_date=p_date;
  if v_cnt=0 and to_char(p_date,'dy')='sun' then
  return 1;
  elsif to_char(p_date,'dy')='sat' then
  return 2;
  else return 0;
 end if;
 end;
 /
 select fn_holiday('22-may-2022'),fn_holiday('21-may-2022'),fn_holiday('20-may-2022') from dual;
/
select * from customer;

-- Write a procedure to add columns to the existing customer table by passing column name and datatype.

create or replace procedure sp_dynamic(p_column_name varchar2,p_datatype varchar2)as
    v_str varchar2(200);

begin
    v_str:='alter table customer add '||p_column_name||' '|| p_datatype;
    
        --dbms_output.put_line(v_str);              
    execute immediate v_str;
end;    
 /   
exec sp_dynamic('c_country','varchar2(20)');
/
    set serveroutput on;
/
--Write a procedure by passing the location at run time and create ‘office_<location>’ table
--With the columns office_<location>_id,office_<location>_name,office_city.

create or replace procedure sp_loc(p_location varchar2) as
    v_str varchar2(200);
begin
    v_str:='create table office_'||p_location||'(office_'||p_location||'_id number(5)'||','
           ||'office_'||p_location||'_name varchar2(20)'||','||'office_city varchar2(20))';
           dbms_output.put_line(v_str);
          --  execute immediate v_str; 
end;           
/
exec sp_loc('bangalore');
--create table office_bangalore(office_bangalore_id int(5),office_bangalore_name varchar2(20),office_city varchar2(20))

create table office_bangalore(office_bangalore_id number(5),office_bangalore_name varchar2(20),office_city varchar2(20))
drop table office_bangalore
/
--Write a function to return all the column names by passing table_name at runtime.
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
/