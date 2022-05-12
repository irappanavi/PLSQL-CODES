create or replace procedure sp_dynamic(p_tbl_nm varchar2) as
v_str varchar2(500);
v_cnt int;
begin
v_str:='select count(*) from ' ||p_tbl_nm;
execute immediate v_str into v_cnt;
dbms_output.put_line(v_cnt);
end;
/
exec sp_dynamic('customer_retail');

set serveroutput on
/
create or replace procedure sp_dynamic(p_tbl_nm varchar2) as
child_record_found exception;
v_str varchar2(500);
v_cnt int;
pragma exception_init(child_record_found,-2292);
begin
v_str:='delete from ' ||p_tbl_nm;
execute immediate v_str ;
dbms_output.put_line(sql%rowcount||'rows deleted');
exception
when child_record_found then
dbms_output.put_line(sqlcode||','||sqlerrm);
end;