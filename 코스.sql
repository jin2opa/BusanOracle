CREATE TABLE PLAYER 
(
  ID NUMBER 
, NAME VARCHAR2(30) 
, POSITION VARCHAR2(20) 
, TEAMID NUMBER 
);

insert into player(id, name, position, teamid) values (1, '�̴�ȣ', '1���', 1);
commit;

select * from player;

update player set position = '2���' where name = '�̴�ȣ'; 
commit;

delete from player where id = 1;
commit;

insert into player(id, name, position, teamid) values (1, '�̴�ȣ', '1���', 1);
rollback;

insert into player(id, name, position, teamid) values (1, '�̴�ȣ', '1���', 1);
rollback;

insert into player(id, name, position, teamid) values (1, '�̴�ȣ', '1���', 1);
update player set name = '���ȣ' where id = 1;

