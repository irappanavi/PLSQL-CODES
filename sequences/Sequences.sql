select * from user_sequences;

--sequence for call_centre:
CREATE SEQUENCE SQ_GUESTS
start with 1
INCREMENT BY 1
MINVALUE 0
NOCYCLE;
/

--sequence for shift id
CREATE  SEQUENCE sq_SHIFT
start with 1
increment by 1
minvalue 1
MAXVALUE 50
cycle;
/

--sequence for Txn id:
CREATE  SEQUENCE sq_txns
start with 1112
increment by 1
minvalue 1;
/

--
CREATE  SEQUENCE sq_error;
/

--
create sequence sq_date_dim;


create sequence sq_prod_dim
start with 1;

create sequence sq_audit
start with 1;

create sequence sq_cap_result;

create sequence sq_cap_res;

drop sequence sq_audit;
drop sequence sq_txns;
drop sequence sq_date_dim;