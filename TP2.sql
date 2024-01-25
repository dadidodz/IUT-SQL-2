--TP2
--a
select * from thierry_millan.celcat2017;
desc thierry_millan.CELCAT2017;

create table GROUPE (GRPC varchar2(20), ANNEEC char(3));
desc GROUPE;

create table CRENEAU (DEBSEMC date, JOURC varchar2(8), HEUREDC char(5), TYPEC varchar2(20), HEUREFC char(5), GRPC varchar2(20), MATC varchar2(10));
desc CRENEAU;

create table ENSEIGNER (DEBSEMC date, JOURC varchar2(8), HEUREDC char(5), GRPC varchar2(20), ENSC char(3));
desc ENSEIGNER;

create table AFFECTER (DEBSEMC date, JOURC varchar2(8), HEUREDC char(5), GRPC varchar2(20), SALC varchar2(15)); 
desc AFFECTER;

--b
alter table GROUPE add constraint PK_GROUPE primary key (GRPC) ;
alter table CRENEAU add constraint PK_CRENEAU primary key (DEBSEMC, JOURC, HEUREDC, GRPC) ;
alter table ENSEIGNER add constraint PK_ENSEIGNER primary key (DEBSEMC, JOURC, HEUREDC, GRPC, ENSC) ;
alter table AFFECTER add constraint PK_AFFECTER primary key (DEBSEMC, JOURC, HEUREDC, GRPC, SALC) ;

alter table CRENEAU add constraint FK_CRENEAU_MATC foreign key (MATC) references MAT(MATC) ;
alter table CRENEAU add constraint FK_CRENEAU_GRPC foreign key (GRPC) references GROUPE(GRPC) ;
alter table AFFECTER add constraint FK_AFFECTER_GRPC foreign key (GRPC) references GROUPE(GRPC) ;
alter table AFFECTER add constraint FK_AFFECTER_SALC foreign key (SALC) references GROUPE(GRPC) ;
alter table ENSEIGNER add constraint FK_ENSEIGNER_GRPC foreign key (GRPC) references GROUPE(GRPC) ; 
alter table AFFECTER add constraint FK_AFFECTER_DEBSEMC_GRPC foreign key (DEBSEMC, JOURC, HEUREDC, GRPC) references CRENEAU (DEBSEMC, JOURC, HEUREDC, GRPC) ;
alter table ENSEIGNER add constraint FK_ENSEIGNER_DEBSEMC_GRPC foreign key (DEBSEMC, JOURC, HEUREDC, GRPC) references CRENEAU (DEBSEMC, JOURC, HEUREDC, GRPC) ; 

--c
insert into GROUPE (GRPC, ANNEEC)
select distinct GRPC, ANNEEC from thierry_millan.CELCAT2017
where GRPC is not null;

insert into CRENEAU (DEBSEMC, JOURC, HEUREDC, TYPEC, HEUREFC, GRPC, MATC)
select distinct DEBSEMC, JOURC, HEUREDC, TYPEC, HEUREFC, GRPC, MATC
from thierry_millan.CELCAT2017;

insert into ENSEIGNER (DEBSEMC, JOURC, HEUREDC, GRPC, ENSC)
select distinct DEBSEMC, JOURC, HEUREDC, GRPC, ENSC
from thierry_millan.CELCAT2017
where ENSC is not null;

insert into AFFECTER (DEBSEMC, JOURC, HEUREDC, GRPC, SALC)
select distinct DEBSEMC, JOURC, HEUREDC, GRPC, SALC
from thierry_millan.CELCAT2017
where SALC is not null;

select CRENEAU.DEBSEMC, CRENEAU.JOURC, CRENEAU.HEUREDC, TYPEC, HEUREFC, CRENEAU.GRPC, CRENEAU.MATC, SALC, ENSC, ANNEEC, INTC
from CRENEAU, MAT, GROUPE, ENSEIGNER, AFFECTER
where CRENEAU.GRPC = GROUPE.GRPC
 and MAT.MATC (+) = CRENEAU.MATC
 and AFFECTER.DEBSEMC (+) = CRENEAU.DEBSEMC
 and AFFECTER.JOURC (+) = CRENEAU. JOURC
 and AFFECTER.HEUREDC (+) = CRENEAU. HEUREDC
 and AFFECTER.GRPC (+) = CRENEAU. GRPC
 and ENSEIGNER.DEBSEMC (+) = CRENEAU.DEBSEMC
 and ENSEIGNER.JOURC (+) = CRENEAU. JOURC
 and ENSEIGNER.HEUREDC (+) = CRENEAU. HEUREDC
 and ENSEIGNER.GRPC (+) = CRENEAU. GRPC
minus
select DEBSEMC, JOURC, HEUREDC, TYPEC, HEUREFC, GRPC, MATC, SALC, ENSC, ANNEEC,INTC
from thierry_millan.CELCAT2017 ;

select DEBSEMC, JOURC, HEUREDC, TYPEC, HEUREFC, GRPC, MATC, SALC, ENSC, ANNEEC,INTC
from thierry_millan.CELCAT2017
minus
select CRENEAU.DEBSEMC, CRENEAU.JOURC, CRENEAU.HEUREDC, TYPEC, HEUREFC,CRENEAU.GRPC, CRENEAU.MATC, SALC, ENSC, ANNEEC, INTC
from CRENEAU, MAT, GROUPE, ENSEIGNER, AFFECTER
where CRENEAU.GRPC = GROUPE.GRPC
 and MAT.MATC (+) = CRENEAU.MATC
 and AFFECTER.DEBSEMC (+) = CRENEAU.DEBSEMC
 and AFFECTER.JOURC (+) = CRENEAU. JOURC
 and AFFECTER.HEUREDC (+) = CRENEAU. HEUREDC
 and AFFECTER.GRPC (+) = CRENEAU. GRPC
 and ENSEIGNER.DEBSEMC (+) = CRENEAU.DEBSEMC
 and ENSEIGNER.JOURC (+) = CRENEAU. JOURC
 and ENSEIGNER.HEUREDC (+) = CRENEAU. HEUREDC
 and ENSEIGNER.GRPC (+) = CRENEAU. GRPC;
 
 --3.a.
create table FORMATION as select * from thierry_millan.FORMATION2018 ;

create table SALLE as select * from thierry_millan.SALLE2018 ;

create table ENSEIGNANT as select * from thierry_millan.ENSEIGNANT2018 ;

create table STATUT as select * from thierry_millan.STATUT2018 ; 

--b
alter table FORMATION add constraint PK_FORMATION primary key (IdFor) ;

alter table SALLE add constraint PK_SALLE primary key (NSalle) ;

alter table ENSEIGNANT add constraint PK_ENDEIGNANT primary key (IdEnseign) ;

alter table STATUT add constraint PK_STATUT primary key (Grade) ;

alter table GROUPE add constraint FK_GROUPE_ANNEEC foreign key (ANNEEC)
references FORMATION(IdFor) ;

alter table ENSEIGNANT add constraint FK_ENSEIGNANT_GRADE foreign key (Grade)
references STATUT (Grade) ;

alter table ENSEIGNER add constraint FK_ENSEIGNER_ENSC foreign key (ENSC)
references Enseignant (IdEnseign) ;

alter table AFFECTER add constraint FK_AFFECTER_SALC foreign key (SALC)
references SALLE (NSalle) ;

--c
alter table GROUPE add Eff number(3) default 0 ;

--d
desc thierry_millan.efformation2018;
update GROUPE
set Eff = (select Eff from thierry_millan.EFFORMATION2018 where IDGRP = GROUPE.GRPC);

--4
select * from GROUPE;
select * from MAT;
select * from CRENEAU;

--a
select groupe.grpc, groupe.eff
from GROUPE, CRENEAU
where GROUPE.GRPC = CRENEAU.GRPC
 and CRENEAU.MATC = 'InM1101'
 and CRENEAU.DEBSEMC = TO_DATE('19/09/2016','dd/mm/yyyy')
 and CRENEAU.JOURC = 'mercredi'
 and CRENEAU.HEUREDC = '11:00';

--b
select MATC,TYPEC,GRPC,
sum((to_date(HEUREFC, 'HH24:MI')-to_date(HEUREDC, 'HH24:MI'))*24) 
from CRENEAU
where MATC is not null
group by MATC,TYPEC,GRPC;

--c
create or replace view NbHdispenseParEnseignant(IdEns,NbH)
as select ENSC,
sum(decode(TYPEC,'CM',1.5,'TD',1.0, 'TP',1.0,0)*
(to_date(HEUREFC, 'HH24:MI')-to_date(ENSEIGNER.HEUREDC, 'HH24:MI'))*24)
from CRENEAU, ENSEIGNER
where ENSEIGNER.DEBSEMC = CRENEAU.DEBSEMC
and ENSEIGNER.JOURC=CRENEAU.JOURC
and ENSEIGNER.HEUREDC= CRENEAU.HEUREDC
and ENSEIGNER.GRPC = CRENEAU.GRPC
group by ENSC;

select * from enseignant;

select * from NbHdispenseParEnseignant
where IdEns = 'BUC';

--d
update Enseignant 
set NbHDisp=(select NbH
from NbHdispenseParEnseignant where IdEns=IdEnseign);

--5
select * from affecter;
select * from creneau;


--a
create or replace trigger T_B_I_AFFECTER
before insert or update on AFFECTER
for each row

declare
    vNbTYPEC number;
    vNbTSAL  number;

Begin
    select count(*) into vNbTYPEC
    from creneau
    where creneau.DEBSEMC = :new.DEBSEMC
     and creneau.JOURC = :new.JOURC
     and creneau.HEUREDC = :new.HEUREDC
     and creneau.GRPC = :new.GRPC
     and TYPEC = 'TP';
     
     select count(*)into vNbTSAL
     from salle
     where salle.NSalle = :new.SALC
      and TSAL <> 'TP';
      
    if vNbTYPEC = 1 and vNbTSAL = 1 then
        raise_application_error(-20001, 'la salle ne convient pas pour ce type d''enregistrement');
    end if;
end T_B_I_AFFECTER;

insert into AFFECTER values ('05/06/2017','mardi','08:00','InS2F2','IN209');
insert into AFFECTER values ('05/06/17','mardi','08:00','InS2F2','InJade');
insert into AFFECTER values ('05/06/17', 'mardi', '08:00', 'InSxx', 'IN209');
insert into AFFECTER values ('05/06/17', 'mardi', '08:00', 'InS2F2', 'INxxx');


--b
drop trigger T_B_I_AFFECTER;

create or replace trigger T_B_IU_AFFECTER
before insert or update of SALC on AFFECTER
for each row

declare
    vTYPEC CRENEAU.TYPEC%type;
    vTSAL SALLE.TSAL%type;

Begin
    select TYPEC into vTYPEC
    from creneau
    where creneau.DEBSEMC = :new.DEBSEMC
     and creneau.JOURC = :new.JOURC
     and creneau.HEUREDC = :new.HEUREDC
     and creneau.GRPC = :new.GRPC;
     
     select TSAL into vTSAL
     from salle
     where salle.NSalle = :new.SALC;
      
    if vTYPEC <>vTSAL and vTYPEC = 'TP' then
        raise_application_error(-20001, 'la salle ne convient pas pour ce type d''enregistrement');
    end if;
end T_B_IU_AFFECTER;

update AFFECTER
set SALC = 'IN209'
where AFFECTER.DEBSEMC = '05/06/17'
 and AFFECTER.JOURC = 'vendredi'
 and AFFECTER.HEUREDC = '08:00'
 and AFFECTER.GRPC = 'InS2A1'
 and AFFECTER.SALC = 'InRubis' ;
 
update AFFECTER
set SALC = 'InJade'
where AFFECTER.DEBSEMC = '05/06/17'
 and AFFECTER.JOURC = 'vendredi'
 and AFFECTER.HEUREDC = '08:00'
 and AFFECTER.GRPC = 'InS2A1'
 and AFFECTER.SALC = 'InRubis';
 

