--TP3
--1
--a
select * from USER_INDEXES;

select * from USER_IND_COLUMNS;

--b
create index CRENEAU_GRPC_I on CRENEAU (GRPC);

create index ENSEIGNANT_NOM_I on ENSEIGNANT (NOM);

create index ENSEIGNER_ENSC_I on ENSEIGNER (ENSC);

--d
drop index CRENEAU_GRPC_I;

drop index ENSEIGNANT_NOM_I;

drop index ENSEIGNER_ENSC_I;

--2
--a
select * from CRENEAU
where CRENEAU.matc='inA1108';

EXPLAIN PLAN SET statement_id = 'p1' FOR
select * from CRENEAU where MATC='inA1108';
call dbms_stats.gather_schema_stats(user, 20) ;
SELECT plan_table_output FROM table(dbms_xplan.display('plan_table','p1','ALL'));

set autotrace on
select * from CRENEAU where MATC='inA1108';

--3
select NOM from ENSEIGNANT
where idenseign='DBJ';

--4
--a
select * from ENSEIGNANT
where NOM='DU BELLAY';

--b
create index NDX_ENSEIGNANT_NOM on ENSEIGNANT (NOM);

--d
call dbms_stats.gather_schema_stats(user, 20) ;

--5
--a
select * from ENSEIGNANT, ENSEIGNER
where ENSEIGNER.ENSC= ENSEIGNANT.IDENSEIGN;

--b
create index ENSEIGNER_ENSC_I on ENSEIGNER (ENSC);

drop index enseigner_ensc_i;

--6
--a
select CRENEAU.MATC, ENSEIGNER.ENSC,
 sum((to_date(HEUREFC, 'HH24:MI') - to_date(CRENEAU.HEUREDC, 'HH24:MI')) * 24)
from CRENEAU, ENSEIGNER
where CRENEAU.DEBSEMC = ENSEIGNER.DEBSEMC
 and CRENEAU.JOURC = ENSEIGNER.JOURC
 and CRENEAU.HEUREDC = ENSEIGNER.HEUREDC
 and CRENEAU.GRPC = ENSEIGNER.GRPC
group by CRENEAU.MATC, ENSEIGNER.ENSC
having sum((to_date(HEUREFC, 'HH24:MI') - to_date(CRENEAU.HEUREDC, 'HH24:MI')) *24)> 5;

--b
select CRENEAU.MATC, ENSEIGNER.ENSC, count(*)
from CRENEAU, ENSEIGNER
where CRENEAU.DEBSEMC = ENSEIGNER.DEBSEMC
 and CRENEAU.JOURC = ENSEIGNER.JOURC
 and CRENEAU.HEUREDC = ENSEIGNER.HEUREDC
 and CRENEAU.GRPC = ENSEIGNER.GRPC
group by CRENEAU.MATC, ENSEIGNER.ENSC ;

--7
delete from ENSEIGNER
where DEBSEMC = '31/10/16'
 and JOURC = 'vendredi'
 and HEUREDC = '08:00'
 and GRPC = 'InS1A'
 and ENSC = 'FUA' ; 
 
--8
insert into ENSEIGNER values ('31/10/16', 'vendredi', '08:00', 'InS1A', 'FUA') ;


