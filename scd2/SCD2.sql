create or replace procedure sp_scd2 as
    cursor c_source is select prod_id,prod_name,prod_cat_desc,prod_fam_desc,prod_price
                    from products p,prod_cat pc, prod_family pf
                    where pf.prod_fam_id=pc.prod_fam_id
                    and pc.prod_cat_id=p.prod_cat_id; 
                    
    v_cnt int;
    v_cnt_up int;
begin
    for i in c_source  loop
        select count(*) into v_cnt
        from prod_dim2
        where prod_id=i.prod_id
        and prod_nm=i.prod_name
        and prod_cat=i.prod_cat_desc
        and prod_family=i.prod_fam_desc;
        
        if v_cnt=0 then
            insert into prod_dim2 values(sq_prod_dim.nextval,i.prod_id,i.prod_name,i.prod_cat_desc,i.prod_fam_desc,i.prod_price,sysdate,null,'Y');
        else
            select count(*) into v_cnt_up
            from prod_dim2
            where prod_nm<>i.prod_name
            or prod_cat<>i.prod_cat_desc
            or prod_family<>i.prod_fam_desc
            or prod_price<>i.prod_price;
                if v_cnt_up =1 then
                    insert into prod_dim2 values(sq_prod_dim.nextval,i.prod_id,i.prod_name,i.prod_cat_desc,i.prod_fam_desc,i.prod_price,sysdate,null,'Y');
            
                    update prod_dim2
                    set to_date=sysdate-1,cur_rec_ind='N'
                    where rowid=(select max(rowid)
                                              from prod_dim2
                                              where rowid not in(select max(rowid)
                                                                                 from prod_dim2 
                                                                                 group by prod_id));
                end if;
        end if;
        end loop;
    exception
        when others then
        dbms_output.put_line(sqlcode||' - '||sqlerrm);
end;
/

select * from prod_dim2;
/
exec sp_scd2;
truncate table prod_dim2;

update products
set prod_price=3999
where prod_name='iron box';

select * from products;