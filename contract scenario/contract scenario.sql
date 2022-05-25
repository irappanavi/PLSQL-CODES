create or replace procedure sp_contract as
cursor c is select * from cont_tab;
cursor target_t is select * from expd_rcv_tab;
v_cnt int;
no_of_mnths int;
last_date date;
exist exception;
begin

for i in c loop
    no_of_mnths:=months_between(i.cont_e_date,i.cont_s_date);
    last_date:=add_months(i.cont_s_date,no_of_mnths);
    
    
        select count(*) into v_cnt
        from expd_rcv_tab
        where exp_rec_date between i.cont_s_date and i.cont_e_date
        and contract_id =i.contract_id;
            if v_cnt=0 then
    
        
                if i.cpt_id=100 then
                 while i.cont_s_date<last_date loop
                insert into expd_rcv_tab values(sq_contract.nextval,i.cont_s_date,i.contract_id,(i.cont_amt/no_of_mnths));
                        i.cont_s_date:=add_months(i.cont_s_date,1);
                    end loop;
        
                elsif i.cpt_id=101 then
                    while i.cont_s_date<i.cont_e_date loop
                        insert into expd_rcv_tab values(sq_contract.nextval,i.cont_s_date,i.contract_id,(i.cont_amt/(no_of_mnths/3)));
                        i.cont_s_date:=add_months(i.cont_s_date,3);
                    end loop;
        
                elsif i.cpt_id=102 then
                    while i.cont_s_date<last_date loop
                    insert into expd_rcv_tab values(sq_contract.nextval,i.cont_s_date,i.contract_id,i.cont_amt/(no_of_mnths/6));
                        i.cont_s_date:=add_months(i.cont_s_date,6);
                    end loop;
        
                    elsif i.cpt_id=103 then
                    while i.cont_s_date<last_date loop
                    insert into expd_rcv_tab values(sq_contract.nextval,i.cont_s_date,i.contract_id,i.cont_amt/(no_of_mnths/12));
                        i.cont_s_date:=add_months(i.cont_s_date,12);
                    end loop;
                end if;
             else
            raise exist;
            end if;
        end loop;
    commit;
exception
when exist then
dbms_output.put_line('The contract details are already populated');
when others then
dbms_output.put_line(sqlcode||'-'||sqlerrm);
end;
/
exec sp_contract;
/

select * from expd_rcv_tab;
select * from cont_tab;
select * from con_pay_terms;

truncate table expd_rcv_tab;


--Table source
create table cont_tab(
contract_id number(20),
contract_type varchar2(40),
cont_s_date date,
cont_e_date date,
cpt_id number(20),
cont_amt number(20),
ins_date date,
upd_date date);

insert into cont_tab values(12345,'government','10-jan-10','10-jan-11',101,700000,'10-jan-10',null);
insert into cont_tab values(12879,'government','03-feb-11','15-feb-12',102,489938,'03-feb-11',null);
insert into cont_tab values(12987,'government','15-feb-11','20-feb-13',103,200000,'15-feb-11',null);
insert into cont_tab values(12346,'government','01-sep-12','10-feb-13',100,400000,'01-Sep-12','10-apr-13');


select * from cont_tab;
truncate table cont_tab;

create table expd_rcv_tab
(exp_rec_id number(6),
exp_rec_date date,
contract_id number(6),
amount number(6));

create table con_pay_terms(cpt_id number(20),freq_of_pmt varchar2(30));

insert into con_pay_terms values(100,'monthly');
insert into con_pay_terms values(101,'quarterly');
insert into con_pay_terms values(102,'half yearly');
insert into con_pay_terms values(103,'yearly');
/
create sequence sq_contract;
/
create or replace procedure sp_leapyear(p_date date) as
p_year number:=to_char(p_date,'yyyy');
begin
    if mod(p_year,4)=0 then
    dbms_output.put_line('it is leap year');
    else
    dbms_output.put_line('it is not leap year');
    end if;
end;
 /
 
exec sp_leapyear('12-mar-2020');
/
--display no of vowels and consonants in a given string
declare
v_cnt int:=0;
p_cnt int:=0;
p_string varchar2(20):=&s;
begin
for i in 1..length(p_string) loop
if substr(p_string,i,1) in ('a','e','i','o','u') then
v_cnt:=v_cnt+1;
else
p_cnt:=p_cnt+1;
end if;
end loop;
dbms_output.put_line('no of vowels'|| v_cnt);
dbms_output.put_line('no of consonants'|| p_cnt);
end;
/
--write a procedure which takes product name and print a message if it made sales today or not
create or replace procedure sp_prod_sales(prod_name varchar2) as
v_cnt int;
begin
    select count(*) into v_cnt
    from sales_retail s ,product_retail p
    where p.prod_id=s.prod_id and sales_date=sysdate;
        if v_cnt=0 then
        dbms_output.put_line('not made sales');
        else
      dbms_output.put_line(' made sales');
     end if;
end;
    
/
exec sp_prod_sales('tv');
