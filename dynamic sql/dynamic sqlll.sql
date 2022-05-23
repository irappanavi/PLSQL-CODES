-- Pass the month and year and display the total sales of current month and previous month sales.

create or replace procedure sp_dynd(v_mon_year varchar2)as 
    v_cur_month_sales  number(11);
    v_pre_month varchar2(20);
    v_pre_month_sales number(11);

begin
    v_pre_month:=to_char((to_date(v_mon_year,'mon-yy')-1),'mon-yy');    

    select count(sales_id) into v_cur_month_sales
    from sales_retail
    where to_char(sales_date,'mon-yy')= v_mon_year;

    select count(sales_id) into v_pre_month_sales
    from sales_retail
    where to_char(sales_date,'mon-yy')=v_pre_month;
    DBMS_OUTPUT.PUT_LINE(v_cur_month_sales);
    DBMS_OUTPUT.PUT_LINE(v_pre_month_sales);

--select to_char(sales_date,'mon-yy')
--from sales_retail;

end;
/
exec sp_dynd('may-20');
/
set serveroutput on;
/
select * from sales_retail;

/
select count(sales_id) 
    from sales_retail
/
    select count(sales_id) 
    from sales_retail
    where to_char(sales_date,'mon-yy')='may-20';
--    to_char(to_date('may-20','mon-yy'),'mon-yy')-1;

/
select * from user_constraints
where constraint_type in'R';
/
select * from user_tables
where table_name=upper();
/
select count(column_name) from user_tab_columns
where table_name ='EMP';
/
--Pass the month and year and create the transaction table as txn_month_year with the columns txnid, cid, pid, sales_dt, qty and amt.

create or replace procedure sp_transct(v_month_year varchar2) as
    v_month varchar2(200);
begin
    v_month:='create table txn_'||v_month_year ||'(txn_id number(5),c_id number(5),p_id number(5),sales_dt date,
    quantity number(20),amt number(20))';
 --dbms_output.put_line(v_month);
    execute immediate v_month; 
  end;  
/
create table txn_v_month_year (txn_id number(5),c_id number(5),p_id number(5),sales_dt date,quatity number(20),amt number(20));
  /
drop table txn_v_month_year;
/
  exec sp_transct('05-2022');
/
select * from txn_may-22;
/
desc txn_may-22;
/
--Write a procedure by passing the table name and check the table exists or not, if exists display all the column names in that table otherwise handle the exception

create or replace procedure sp_dynamic_count(p_table_nm in varchar2)as
  v_column varchar2(200);
  v_cnt number(20);
  v_t_cnt number(20);
  table_not_found exception;
begin
   select count(*) into v_t_cnt 
   from user_tables where 
  table_name=upper(p_table_nm);
      if v_t_cnt=1 then
    
        v_column :='select count(column_name) from user_tab_columns where table_name=' ||''''||upper(p_table_nm)||'''';
        -- dbms_output.put_line('columns are:'||v_column);
           execute immediate v_column into v_cnt;
             dbms_output.put_line('columns are'||v_cnt);
     else
       raise table_not_found;
     end if;
exception
when table_not_found then
raise_application_error(-20001,'table doesnot exist');
end;
/
exec sp_dynamic_count('sales_retail');
/
--Pass the table_name in a procedure and display the no. of records and no. of columns in that table using dynamic sql.
create or replace procedure sp_cnt_reccolumn(p_table varchar2)as
v_str_rows varchar2(200);
v_count_rows number(20);
v_str_column varchar2(200);
v_count_column number(20);
v_cnt number(20);
begin
select count(*)into v_cnt
from user_tables 
where table_name=upper(p_table);

if v_cnt=1 then
v_str_rows:='select count(*) from '||p_table;
--dbms_output.put_line(v_str_rows);
v_str_column:='select count(column_name) from user_tab_columns where table_name='||''''||upper(p_table)||'''';
--dbms_output.put_line(v_str_column);
execute immediate v_str_rows into v_count_rows;
dbms_output.put_line('the counted rows are :'||v_count_rows);
execute immediate v_str_column into v_count_column;
dbms_output.put_line('columns are :'||v_count_column);
else
dbms_output.put_line('table doesnot exist');
end if;
end;
/
exec sp_cnt_reccolumn('product_retail');