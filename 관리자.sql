ALTER SESSION SET "_oracle_script"=true;
CREATE USER cos IDENTIFIED BY bitc5600;

GRANT CREATE session to cos;
grant create TABLE to cos;
grant select, insert, delete, update on cos.player to cos;
alter user cos default TABLESPACE users quota unlimited on users;

create user cos2 IDENTIFIED by bitc5600;
grant DBA to cos2;

grant DBA to SCOTT;

ALTER SESSION SET "_oracle_script"=true;
@C:\scott.sql;

ALTER SESSION SET "_oracle_script"=true;
@c:\test_data.sql;

ALTER SESSION SET "_oracle_script"=true;
create user jin IDENTIFIED by bitc5600;

grant create session to jin;
grant create table to jin;
grant select, insert, delete, update on jin.first to jin;
alter user jin default TABLESPACE users quota unlimited on users;

