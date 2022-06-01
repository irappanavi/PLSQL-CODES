
/
set serveroutput on;
/
declare 
v_cities varchar2(100);
v_position number(20);
v_city1 varchar2(100);
v_city2 varchar2(100);
v_city3 varchar2(100);
begin
    v_cities:='bangalore,mysore,hubli';
 
     v_position:=instr(v_cities,',');
     v_city1:=substr(v_cities,1,v_position-1);
     v_city2:=substr(v_cities,v_position+1,instr(v_cities,',',1,2)-instr(v_cities,',',+1)-1);
     v_city3:=substr(v_cities,instr(v_cities,',',1,2)+1,instr(v_cities,',',-1));
     
     dbms_output.put_line('city1  is: '||v_city1);
     dbms_output.put_line('city2  is: '||v_city2);
     dbms_output.put_line('city3  is: '||v_city3);
  
end;  
/     
declare 
v_cities varchar2(100):='&v_cities';
v_position number(20);
v_substr varchar2 (100);
n number(10):=1;
last_city varchar2(20);
v_city_cnt number(20):=0;
begin
    
    for i in 1..length(v_cities) loop
    
    v_position:=instr(v_cities,',',1,i);
    v_substr:=substr(v_cities,n,v_position-n);
    n:=v_position+i;
    exit when v_substr is null;
    dbms_output.put_line(v_substr);
    v_city_cnt:=v_city_cnt+1;
    end loop;
        last_city:=substr(v_cities,(instr(v_cities,',',-1,1)+1));
        dbms_output.put_line(last_city);
        dbms_output.put_line('no of cities:'||(v_city_cnt+1));
end;
/
