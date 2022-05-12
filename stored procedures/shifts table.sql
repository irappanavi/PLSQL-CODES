
Create table holiday
(holi_id number(10),
Dt_date date,
Reason varchar2(20));

Create table shift_type
(shift_desc varchar2(20),
Start_time varchar2(20),
End_time varchar2(20));

Create table shifts
(shift_id number(10),
Dt_date date,
Start_time varchar2(20),
End_time varchar2(20));

insert into holiday values('101','01-jan-15','New Year')
insert into holiday values('102','16-jan-15','Shankaranthi');
insert into holiday values('103','26-jan-15','republic day');
insert into holiday values('104','18-feb-15','Id day');
insert into holiday values('105','01-may-15','May day');
insert into holiday values('106','15-aug-15','independence day');
insert into holiday values('107','01-nov-15','Karnataka day');

insert into shift_type values('erly_mrng_shift','6:00AM','2:00PM');
insert into shift_type values('afternoon_shift','2:00AM','10:00PM');


create or replace procedure sp_shifts(p_mon_yy varchar2) as
--f_dt varchar2(20):='jan-2022';
first_dt date;
last_dt date;
no_of_days number;

begin
first_dt:=trunc(to_date(p_mon_yy,'mon-yyyy'),'mm');
last_dt:=last_day(first_dt);
--no_of_days:=last_dt-first_dt;
while first_dt<=last_dt loop
insert into shifts(shift_id,dt_date) values (seq_shifts.nextval,first_dt);
first_dt:=first_dt+1;
end loop;
end;
/
exec sp_shifts('jan-2020');
/


create sequence seq_shifts;

/





select * from shifts;
truncate table shifts;