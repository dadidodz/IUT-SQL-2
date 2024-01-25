--1
create table T ( A number constraint PK_A primary key, B varchar2(5) );

drop table T;

ALTER TABLE T
ADD C varchar2(5);

ALTER TABLE T
drop column C ;

--2a
insert into T values (1, 'a');
select * from T;

commit;
select * from T;

--b
DELETE FROM T
WHERE A = 1;
select * from T;

commit;
select * from T;

--3
INSERT INTO T VALUES (1, 'a');
INSERT INTO T VALUES (2, 'b');
INSERT INTO T VALUES (3, 'b');
INSERT INTO T VALUES (4, 'c');
DELETE FROM T WHERE b = 'b';
SELECT * FROM T; 

ROLLBACK;
SELECT * FROM T; 

--4
INSERT INTO T VALUES (2, 'b');
INSERT INTO T VALUES (3, 'e');
INSERT INTO T VALUES (5, 'f');
INSERT INTO T VALUES (6, 'g');
SAVEPOINT point_de_reprise;
DELETE FROM T WHERE b = 'b';
SELECT * FROM T; 

ROLLBACK TO SAVEPOINT point_de_reprise;
SELECT * FROM T; 

COMMIT;
SELECT * FROM T;

--5
UPDATE T SET b = 'K' where a = 2;
SELECT * FROM T; 