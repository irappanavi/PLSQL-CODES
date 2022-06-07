desc shop_dimension;

select * from shop_dimension;

create or replace procedure sp_default_dimension as
v_count number(5);
begin

     select count(*) into v_count
     from shop_dimension
     where shop_id=-1;
     
     if v_count=0 then    
     
         insert into shop_dimension(-1,'unknown','unknown','unknown','n',0,0,'unkown',null,null);
         commit;
     else
     dbms_output.put_line('data already exist');
     
exception
 when others
 dbms_output.put_line(sqlcode||sqlerrm);
end; 
/
select * from all_tables
where table_name='EMPLOYEE';
/
CREATE TABLE EMPLOYEE(SELECT * FROM ADITYAN.EMPLOYEE);
/
create or replace function fn_age(v_empno number) return varchar2 as
v_emp_age  varchar2(40);
begin

     select  ( case when trunc(months_between(sysdate,DATE_OF_BIRTH)/12) between 20 and 35 then 'junoir in the copmany'
                   when trunc(months_between(sysdate,DATE_OF_BIRTH)/12) between 35 and 50 then 'mid level in the company'
                   when trunc(months_between(sysdate,DATE_OF_BIRTH)/12) > 50 then 'senior in the company'
                   when trunc(months_between(sysdate,DATE_OF_BIRTH)/12) < 20 then 'unknown' end) into v_emp_age
                   
    from employee
    where emp_id=v_empno;
    return v_emp_age;
exception 
when others then
dbms_output.put_line(sqlcode||'-'||sqlerrm);
 
end;

select * from employee;

/
select fn_age (102) from dual;
/
create or replace function fn_age_group(v_empno number) return varchar2 as
v_age_group varchar2(20);
v_age number(20);
    begin
         select months_between(sysdate,date_of_birth)/12 into v_age
         from employee
         where emp_id=v_empno;
         
             if v_age between 20 and 35 then
             v_age_group:='junior in the company';
             elsif v_age between 35 and 50 then
             v_age_group:='mid in the company';
             elsif v_age > 50 then
             v_age_group:='senior in the company';
             elsif v_age < 20 then
             v_age_group:='unknown';
             end if;
             return v_age_group;
exception
when no_data_found then
return 'empno not valid';
when others then
dbms_output.put_line(sqlcode||'-'||sqlerrm);
end;
             

/
select fn_age_group(1) from dual;

  
/
create table employee as select * from feb22_yashwanth.employee;
/
