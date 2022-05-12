create or replace trigger trg_cust_audit
after insert or update or delete on customer
declare
v_evt varchar2(20);
begin
if inserting then
v_evt:='insertion';
elsif updating then
v_evt:='updation';
else
v_evt:='deletion';
end if;
insert into cust_audit values(seq_audit.nextval,v_evt,sysdate);
end;
/
create or replace trigger trg_check_city
before insert  on customer
for each row
begin
if (:new.city!='bangalore') then
raise_application_error(-20001,'out of banganlore are not allowed');
end if;
end;
/
select * from customer;

create table cust_audit
(cust_audit_id int,
cust_audit_evt varchar2(20),
audit_dt date);
insert into cust_audit values(101,'insert',sysdate);
/
create sequence seq_audit;
select * from cust_audit;
exec trg_cust_audit;
/
create or replace trigger trg_sal
before update on emp
for each row
begin
if(:new.sal<:old.sal) then
Raise_application_error(-20001,'salary is lesser than old salary');
end if;
end;
/
update emp
set sal=500
where ename='SMITH';

select * from emp;
/
create or replace trigger trg_timing
before insert  on customer_retail
declare
v_evt varchar2(20);
begin
    if to_char(sysdate,'HH24') not between 9 and 11 or to_char(sysdate,'dy')in ('sat','sun') then
    Raise_application_error(-20002,'this is not business hour or day');
end if;
end;
/
insert into customer_retail values(1110,'min','ashoka','bangalore',848548448,'idjd@gmail.com');


 select to_char(sysdate,'hh:mi')
 from dual;
exec trg_timing;
