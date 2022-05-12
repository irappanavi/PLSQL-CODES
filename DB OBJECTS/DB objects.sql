--Views
create or replace  view vw_cust_sales_cy as
select cust_name,sum(amount) tot_rev_cy
from customer_retail c, sales_retail s
where c.cust_id=s.cust_id
and to_char(sales_date,'yy')=to_char(sysdate,'yy')-1
group by cust_name;

desc user_views;

select *
from vw_cust_sales_cy;

select view_name
from user_views;

select text
from user_views
where view_name='VW_CUST_SALES_CY';

select * from vw_cust_sales_cy;

--Read only view
create or replace view prod as
select prod_id,p_name,cost
from product_retail
with read only;

select * from product_retail;

update prod
set cost=50000
where p_name='tv';

--Check option view
create or replace view vw_emp_dept as
select empno,ename,deptno
from emp
where deptno=10
with check option;

insert into vw_emp_dept values(1112,'arun',30);

--Simple views
create or replace view svw_prod_sale as
select p_name
from product_retail;

select * from vw_prod_sale_up;

--Complex views(Non updatable view)
create or replace view cvw_prod_sale as
select p_name,sum(amount) total_amount
from product_retail p,sales_retail s
where p.prod_id=s.prod_id
group by p_name;

select * from vw_prod_sale;

update svw_prod_sale
set p_name='tv'
where p_name='television';


create index idx_vw on svw_prod_sale(p_name);

--Tables
desc user_tables;

select * from user_tables;

select count(*)from user_tables;

select table_name,column_name from user_tab_columns
where table_name='CUSTOMER_RETAIL';

--Constraints
desc user_constraints;

select * from user_constraints;

select * from user_cons_columns;

select constraint_name,constraint_type
from user_constraints
where table_name='TRANSACTIONS';

--Synonyms
create synonym cust_sales for vw_cust_sales_cy;

create public synonym sy_emp
for hr.emp;

desc user_synonyms;

desc all_synonyms;

select count(synonym_name) from all_synonyms
where synonym_name='SY_EMP';

select * from user_synonyms;

select synonym_name,table_name from user_synonyms;

--Sequences
create sequence seq_prod
start with 1
increment by 1
minvalue 1
maxvalue 1000
cycle
cache 5;

desc user_sequences;

select sequence_name from user_sequences;

--Materialized views
create materialized view mvw_cust_sales as
select cust_name,count(sales_id) no_of_sales,sum(amount) total_revenue
from customer_retail c,sales_retail s
where c.cust_id=s.cust_id
group by cust_name;

desc user_mviews;

select mview_name from user_mviews;
/

Create materialized view mvw_emp
build deferred
refresh complete 
on commit
with primary key
As 
SELECT deptno,sum(sal)
from emp
group by deptno;

select * from emp;

commit;

select * from dept;

insert into emp (empno,ename,deptno)values(20,'san',50);

insert into dept values(50,'prod','can');

select * from mvw_emp;

exec dbms_mview.refresh('mvw_emp');


select * from mvw_emp_bi;

Create materialized view mvw_emp_bi
build immediate
refresh complete 
on commit
with primary key
As 
SELECT deptno,sum(sal)
from emp
group by deptno;
















--Indexes
create index idx_cust on customer_retail(cust_name);

desc user_indexes;

select index_name,index_type,table_name
from user_indexes;

select index_name,index_type,table_name
from user_indexes
where index_name='IDX_COMP_PROD';

--Function based indexes
create index idx_fun_cust on customer_retail(upper(cust_name));

create index idx_comp_prod on product_retail(price,p_name);

drop index idx_comp_prod;