Create table store_product
(s_prod_id number,
S_p_code varchar2(20),
S_p_name varchar(20),
Sku_id number,
Cost number,
Price number
);


insert into store_product values(1101,'A1234','laptop',9456,30000,32000);
insert into store_product values(1102,'A1235','headphone',9457,5000,4000);
insert into store_product values(1103,'A1236','monitor',9458,1000,2000);
insert into store_product values(1104,'A1237','earphone',9459,500,600);
insert into store_product values(1105,'A1238','cpu',9460,6000,7000);

Create table online_product
(o_prod_id number,
prod_name varchar(20),
Sku_id number,
Online_Price number,
discount number,
Online_cost number,
Launch_dt date
);

insert into online_product values(1501,'Dell laptop',9456,35000,1000,40000,'21-jun-19');
insert into online_product values(1502,'headphone',9457,4000,500,3000,'11-mar-19');
insert into online_product values(1503,'Chair',9461,2000,200,1500,'13-jan-19');
insert into online_product values(1504,'Table',9462,8000,1200,7000,'26-feb-19');
insert into online_product values(1505,'Sofa',9463,70000,5000,75000,'09-sep-19');

Create table product_master
(p_id number,
Sku_id number,
P_name varchar(20),
P_cost number, 
Store_price number,
Online_price number,
P_code varchar2(20),
Launch_date date
);

select * from product_master;
select * from online_product;
select * from store_product;

/
create sequence seq_master;

exec pro_master;
/
 
truncate table product_master;
/
create or replace procedure sp_master as
cursor cur_store is select * from store_product;
cursor cur_online is select * from online_product;
v_count number;

begin
    for i in cur_store loop
          insert into product_master(p_id,sku_id,P_name,p_cost,store_price,p_code) values(
                      seq_master.nextval,i.sku_id,i.s_p_name,i.cost,i.price,i.s_prod_id);
    end loop;
        for j in cur_online loop
        select count(*) into v_count
        from product_master
        where sku_id=j.sku_id;
            if v_count=0 then
            insert into product_master(p_id,sku_id,p_name,p_cost,online_price,launch_date) values
                        (seq_master.nextval,j.sku_id,j.prod_name,j.online_cost,j.online_price,j.launch_dt);
            else
                update product_master 
                set p_cost=j.online_cost 
                where p_cost<j.online_cost and sku_id=j.sku_id;
                
                update product_master
                set online_price=j.online_cost,launch_date=j.launch_dt
                where sku_id=j.sku_id;
           end if;
           
    end loop;
end;    
/
exec sp_master;
 

select * from product_master;