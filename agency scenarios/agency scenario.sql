create or replace procedure sp_agency as
cursor c_agency is select * from agency_src;
begin

for i in c_agency loop

    insert into agency_tgt values(i.agency,i.program_name,i.fiscal_year,i.original_appr_amount,
                           (select sum(original_appr_amount) from agency_src where program_name=i.program_name),
                           (select sum(original_appr_amount) from agency_src where agency=i.agency),
                           (select sum(original_appr_amount) from agency_src ));
end loop;

exception 
when others then 
dbms_output.put_line(sqlcode||','||sqlerrm);
end;
/
exec sp_agency;
select * from agency_tgt;
create table agency_src
(agency varchar(20),
program_name varchar(20),
fiscal_year int,
original_appr_amount numeric);

create table agency_tgt
(agency varchar(20),
program_name varchar(20),
fiscal_year int,
Original_appr_amount numeric,
program_amount numeric,
agency_amount numeric,
total_amount numeric);

select * from agency_src;
select * from agency_tgt;

insert into agency_src values('Education','High school grant',2005,350000);
insert into agency_src values('Education','Middle school grant',2005,50000);
insert into agency_src values('Education','High school grant',2004,250000);
insert into agency_src values('Dep','Air',2005,50000);
insert into agency_src values('Dep','Air',2004,60000);
insert into agency_src values('Dep','Water',2005,70000);


/
select program_name , sum(original_appr_amount)
from agency_src
where program_name='High school grant' 
group by program_name;

select program_name , sum(original_appr_amount)
from agency_src
where program_name='Middle school grant' 
group by program_name;

select program_name , sum(original_appr_amount)
from agency_src
where program_name='Air' 
group by program_name;

select program_name , sum(original_appr_amount)
from agency_src
where program_name='Water' 
group by program_name;



select agency ,sum(original_appr_amount)
from agency_src
where agency='Education'          
group by agency;

select agency ,sum(original_appr_amount)
from agency_src
where agency='Dep'          
group by agency;

select sum(original_appr_amount)
from agency_src;
/
 
create or replace procedure sp_dept  as
cursor c1 is select dname,deptno
             from dept;
cursor c2 (p_deptno int) is select ename from emp
                            where deptno=p_deptno;
                            
begin
    for i in c1 loop
    dbms_output.put_line('dept_name'||'-'||i.dname);
     for j in c2(i.deptno) loop
     dbms_output.put_line(j.ename);
     end loop;
    end loop;
end;    
/
exec sp_dept;
set serveroutput on;
/
--Write a block which takes deptno, dname and location as one string as input. For Ex: ’10,Sales,New York’ 
--and  Check whether the first value in the argument  which supposed to be a value for deptno is a number or not.
--If the value is a number, display it is a number, else It is not a Number. 

create or replace procedure sp_stg(p_string varchar2) as

begin

    if regexp_like(substr(p_string,1,2),'^[0-9]+$') then
    dbms_output.put_line('it is a number');
    else
    dbms_output.put_line('it is not a number');
    end if;
end;    
/

exec sp_stg('@#,sales,bangalore');
/
--Write a procedure which accepts an email id as input and prints the domain name of that email id (Eg: I/p john@gmail.com. o/p: gmail)

create or replace procedure sp_mail(p_email varchar2) as
v_email varchar2(20);

begin
    select substr(p_email,instr(p_email,'@')+1,instr(p_email,'.')-instr(p_email,'@')-1) into v_email
    from dual;
    
    dbms_output.put_line(v_email);
end;    
/
exec sp_mail('irappanavi225@outlook.com');
/

    
    
