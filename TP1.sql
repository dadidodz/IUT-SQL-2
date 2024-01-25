--TP1
select * from thierry_millan.celcat2017;

--CAS 1
--Hypoth�se : MATC ->INTC
select MATC, count(distinct INTC) nb_c_distincts
from thierry_millan.CELCAT2017
where MATC is not null
group by MATC
having count(distinct INTC)>1;
--aucun r�sultat -> df v�rifi�e donc MATC ->INTC

--CAS 2
--Hypoth�se : JOURC -> HEUREDC
select JOURC, count(distinct HEUREDC) nb_c_distincts
from thierry_millan.CELCAT2017
where JOURC is not null
group by JOURC
having count(distinct HEUREDC)>1;
--r�sultats dans la table -> df non v�rifi�e donc JOURC -/-> HEUREDC

--CAS 3
--Hypoth�se : GRPC -> ANNEEC
select GRPC, count(distinct ANNEEC) nb_c_distincts
from thierry_millan.CELCAT2017
where GRPC is not null
group by GRPC
having count(distinct ANNEEC)>1;
--aucun r�sultat -> df v�rifi�e donc GRPC -> ANNEEC

--CAS 4
--Hypoth�se : GRPC -> ANNEEC
select debsemc, jourc, heuredc, grpc, count(distinct heurefc) nb_c_distincts
from thierry_millan.CELCAT2017
where debsemc is not null
    and jourc is not null
    and heuredc is not null
    and grpc is not null
group by debsemc, jourc, heuredc, grpc
having count(distinct heurefc)>1;
--aucun r�sultat -> df v�rifi�e donc debsemc, jourc, heuredc, grpc -> heurec

--CAS 5
--Hypoth�se : GRPC -> ANNEEC
select debsemc, jourc, heuredc, grpc, count(distinct typec) nb_c_distincts
from thierry_millan.CELCAT2017
where debsemc is not null
    and jourc is not null
    and heuredc is not null
    and grpc is not null
group by debsemc, jourc, heuredc, grpc
having count(distinct typec)>1;
--aucun r�sultat -> df v�rifi�e donc debsemc, jourc, heuredc, grpc -> typec

--CAS 6
--Hypoth�se : GRPC -> ANNEEC
select debsemc, jourc, heuredc, grpc, count(distinct matc) nb_c_distincts
from thierry_millan.CELCAT2017
where debsemc is not null
    and jourc is not null
    and heuredc is not null
    and grpc is not null
group by debsemc, jourc, heuredc, grpc
having count(distinct matc)>1;
--aucun r�sultat -> df v�rifi�e donc debsemc, jourc, heuredc, grpc -> matc

--GRPC -> ANNEEC
--MATC ->INTC
--debsemc, jourc, heuredc, grpc
--debsemc, jourc, heuredc, grpc
--debsemc, jourc, heuredc, grpc
select distinct JOURC, HEUREDC from THIERRY_MILLAN.celcat2017 order by 1;

desc thierry_millan.CELCAT2017

select MATC, count(distinct INTC) nb_c_distinct
from thierry_millan.CELCAT2017
where MATC is not null
group by MATC
having count (distinct INTC) > 1;

create table MAT (MATC varchar2(10), INTC varchar2(70));

alter table MAT
add constraint PK_MAT primary key (MATC);

insert into MAT
select distinct MATC,INTC
from thierry_millan.CELCAT2017
where MATC is not null;
