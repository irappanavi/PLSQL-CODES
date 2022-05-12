
set serveroutput on;
declare 
a int :=0;
b int :=1;
c int :=0;
begin 
dbms_output.put_line(a);
dbms_output.put_line(b);
while c<= 50 loop
c:=a+b;
dbms_output.put_line(c);
a:=b;
b:=c;
end loop;
end;
/
declare 
i int;
begin 
for i in 1..10 loop
if i not in (5,7) then 
dbms_output.put_line (i);
end if;
end loop;
end;
/

declare
a int:=3;
b int:=0;
begin
while b<30 loop
b:=b+a;
dbms_output.put_line(b);
end loop;
end;
/

declare
 a int:=0;
 b int:=1;
 c int:=0;
  begin
  dbms_output.put_line(a);
  dbms_output.put_line(b);
  while c<=100 loop
  c=a+b;
  dbms_output.put_line(c)
  a:=b;
  b:=c;
  end loop;
  end;


