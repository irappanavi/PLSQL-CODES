create or replace procedure sp_cust_dim_calls as
cursor c_instore is select cust_id,cust_name,city,store_name
                    from instore;
cursor c_call is select cust_id,cust_name,city,rep_name,phone
                        from call_center_cust;
                        
cursor c_web_cust is  select cust_id,cust_name,cust_city,email,status
                      from web_cust;
                      
begin
      for i in c_instore loop
       
            if i.store_name = null then
                insert into reject_cust_table(rej_id,src_rec,reason) values(seq_reject.nextval,i.cust_id,'no store name');
            else
                insert into target_table_cust_dim(cust_id,cust_name,city,rep_name,src_cust_id,source)
                            values(seq_target_cust_dim.nextval,i.cust_name,i.city,i.store_name,i.cust_id,'store');
                            
            end if;
       end loop;
       
       for j in c_call loop
            if j.phone is null then                
                insert into reject_cust_table(rej_id,src_rec,reason) values(seq_reject.nextval,j.cust_id,'phone number is not avialable');
                elsif j.rep_name = null then
                    insert into reject_cust_table(rej_id,src_rec,reason) values(seq_reject.nextval,j.cust_id,'rep_name is not avialable');
            else
             insert into target_table_cust_dim(cust_id,cust_name,city,phone,rep_name,src_cust_id,source)
                            values(seq_target_cust_dim.nextval,j.cust_name,j.city,j.phone,j.rep_name,j.cust_id,'call');
            end if;
        end loop;
        
        for k  in c_web_cust loop
          if k.email is null then
               insert into reject_cust_table(rej_id,src_rec,reason) values(seq_reject.nextval,k.cust_id,'email is not avialable');
               
          elsif k.status='BOUNCED' then
                insert into reject_cust_table(rej_id,src_rec,reason) values(seq_reject.nextval,k.cust_id,'bounced');
                
          else
               insert into target_table_cust_dim(cust_id,cust_name,city,email,rep_name,src_cust_id,source)
                            values(seq_target_cust_dim.nextval,k.cust_name,k.cust_city,k.email,k.status,k.cust_id,'web');
            end if;
       end loop;
exception
when others then
dbms_output.put_line(sqlcode||'-'||sqlerrm);
end;
/
exec sp_cust_dim_calls;
                
                
                
                
                
                
 /               
select * from  instore;               
select * from target_table_cust_dim;  
select * from reject_cust_table;