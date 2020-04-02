CREATE TABLE PLAYER 
(
  ID NUMBER 
, NAME VARCHAR2(30) 
, POSITION VARCHAR2(20) 
, TEAMID NUMBER 
);

insert into player(id, name, position, teamid) values (1, '이대호', '1루수', 1);
commit;

select * from player;

update player set position = '2루수' where name = '이대호'; 
commit;

delete from player where id = 1;
commit;

insert into player(id, name, position, teamid) values (1, '이대호', '1루수', 1);
rollback;

insert into player(id, name, position, teamid) values (1, '이대호', '1루수', 1);
rollback;

insert into player(id, name, position, teamid) values (1, '이대호', '1루수', 1);
update player set name = '김대호' where id = 1;

