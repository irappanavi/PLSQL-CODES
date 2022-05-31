create table input	
(specification_mix varchar(80),	
actual_value int)	;

insert into input values	('Ash 12345 Mix',12);
insert into input values	('Moisture 1234 TY',13);
insert into input values	('Protein 12A	',10);
insert into input values	('Ash ABC 124',11);
insert into input values	('Moisture Winter Wheat',14);



	
create table output_tbl	
(specification_mix varchar(50),	
Actual_val int,	
Ash_val int,	
moisture_val int,	
protein_val int);

Ash 12345 Mix		12
Moisture 1234 TY		13
Protein 12A		10
Ash ABC 124		11
Moisture Winter Wheat		14

drop table input	;
/
select case when specification_mix in ('Ash 12345 Mix','Ash ABC 124') then actual_value 
                                     else 0
                                    end ash_val
                 from  input;          
/
select case when specification_mix in ('Moisture 1234 TY','Moisture Winter Wheat') then actual_value 
                                     else 0
                                    end moisture_val
                 from  input;          
/
select case when specification_mix in ('Protein 12A	') then actual_value 
                                     else 0
                                    end protein_val
                 from  input; 
select * from input;
select * from output_tbl	;
/

create or replace procedure sp_moist as
      cursor c_moist is select specification_mix,actual_value
                        from input;
      v_count number(5);
      v_a number:=0;
       v_b number:=0;
       v_c number:=0;
     
begin
    for i in c_moist loop
      select count(*) into v_count
      from output_tbl
      where specification_mix=i.specification_mix
      and actual_val=i.actual_value;
        if v_count=0 then
          if i.specification_mix like 'Ash%' then
             insert into output_tbl values(i.specification_mix,i.actual_value,i.actual_value,v_b,v_c);
         elsif i.specification_mix like 'Moisture%' then
             insert into output_tbl values(i.specification_mix,i.actual_value,v_a,i.actual_value,v_c);
        elsif i.specification_mix like 'Protein%' then
             insert into output_tbl values(i.specification_mix,i.actual_value,v_a,v_b,i.actual_value);
        else
           dbms_output.put_line('do not insert');
          end if;
        end if;
    end loop;
exception
when others then
dbms_output.put_line(sqlcode||'-'||sqlerrm);
end;
/
exec sp_moist;
/
truncate table output_tbl;
/
select * from output_tbl;
/

create or replace procedure sp_moisture as


    begin
      
      
      insert into output_tbl (select specification_mix,actual_value,
                                     case when specification_mix in ('Ash 12345 Mix','Ash ABC 124') then actual_value 
                                                                          else 0
                                                       end ash_val,
                                     case when specification_mix in ('Moisture 1234 TY','Moisture Winter Wheat') then actual_value 
                                                                     else 0
                                                           end moisture_val,
                                      case when specification_mix in ('Protein 12A	') then actual_value 
                                                         else 0
                                                 end protein_val
                                     from input); 
  
exception
when others then
dbms_output.put_line(sqlcode||'-'||sqlerrm);
end;
/
exec sp_moisture;
set SERVEROUTPUT ON;
/

select * from input;
select * from output_tbl ;
/


