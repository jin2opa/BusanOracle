SELECT *
FROM EMP;

SELECT ENAME, S1, S2, DECODE(S1,S2, NO-1, NO)
FROM(
SELECT ENAME, SAL "S1", LAG(SAL, 1, 0) OVER(ORDER BY SAL DESC) "S2", 
ROWNUM "NO"
FROM
(
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL DESC
)); 

SELECT ENAME, SAL, LAG(SAL, 1, 0) OVER(ORDER BY SAL DESC)
FROM EMP;

SELECT RANK('SMITH') WITHIN GROUP (ORDER BY ENAME) "RANK"
FROM EMP;

-- RANK
SELECT ENAME, SAL, RANK() OVER (ORDER BY SAL DESC)
FROM EMP;

SELECT NAME, HEIGHT, RANK() OVER (ORDER BY HEIGHT DESC)
FROM STUDENT;

--STUDENT 학년별 키 순위
SELECT NAME, GRADE, HEIGHT, RANK() OVER (PARTITION BY GRADE ORDER BY GRADE) 
FROM STUDENT;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       

--12
SELECT * 
FROM EMP;

--4
SELECT *
FROM DEPT;

SELECT *
FROM EMP, DEPT
ORDER BY ENAME;

SELECT E.ENAME, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--ORACLE SYNTAX

SELECT *
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO
;

SELECT *
FROM DEPT
;

SELECT *
FROM EMP
ORDER BY DEPTNO
;

DELETE FROM DEPT WHERE DEPTNO = 10;
DELETE FROM DEPT WHERE DEPTNO = 20;
DELETE FROM DEPT WHERE DEPTNO = 30;
ROLLBACK;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
-- driven table의 모든 값이 나온다. 위에서 DEPT
-- right-outer join
-- where d.deptno = e.deptno(+);
-- left-outer join

SELECT S.NAME STUDENT, P.NAME PROFESSOR
FROM STUDENT S, PROFESSOR P
WHERE S.PROFNO = P.PROFNO;

-- DDL: create, alter, drop
create table Reply(
    id number,
    content varchar2(200) not null,
    boardId number,
    userId number,
    CONSTRAINT reply_PK primary key (id),
    CONSTRAINT reply_FK_board_id foreign key (boardid) references board (id),
    CONSTRAINT reply_PK_USER_ID foreign key (userid) references users (id)
);

CREATE SEQUENCE users_seq
INCREMENT BY 1
START WITH 1;

CREATE SEQUENCE board_seq
INCREMENT BY 1
START WITH 1;

CREATE SEQUENCE reply_seq
INCREMENT BY 1
START WITH 1;

-- Users, Board, Reply
-- DML

-- 전체를 넣을 경우 생략 가능, 또는 순서변경 가능
insert into users(ID, USERNAME, EMAIL)  
VALUES(USERS_SEQ.nextval, 'SSAL', 'ssar@nate.com');

insert into users(ID, USERNAME, EMAIL) 
VALUES(USERS_SEQ.nextval, 'love', 'love@nate.com');

insert into users(ID, USERNAME, EMAIL) 
VALUES(USERS_SEQ.nextval, 'cos', 'cos@nate.com');

commit;

select *
from users;

insert into board(ID, title, content, userid)
values(board_seq.nextval, '오라클1강', 'DDL이란?', 1);

insert into board(ID, title, content, userid)
values(board_seq.nextval, '오라클2강', 'DML이란?', 1);

insert into board(ID, title, content, userid)
values(board_seq.nextval, '오라클3강', 'DCL이란?', 2);

insert into board(ID, title, content, userid)
values(board_seq.nextval, '오라클1강', 'DQL이란?', 1);

commit;

SELECT *
FROM BOARD;

INSERT INTO REPLY(ID, CONTENT, BOARDID, USERID)
VALUES(REPLY_SEQ.nextval, '재밌어요', 1, 1);

INSERT INTO REPLY(ID, CONTENT, BOARDID, USERID)
VALUES(REPLY_SEQ.nextval, '진짜 재밌어요', 1, 2);

COMMIT;

SELECT * 
FROM REPLY;

--JOIN

SELECT *
FROM USERS U, BOARD B
WHERE U.ID = B.USERID;

SELECT *
FROM USERS U, BOARD B
WHERE U.ID = B.USERID(+);

SELECT *
FROM USERS U, REPLY R
WHERE U.ID = R.USERID;

------

SELECT *
FROM USERS U, REPLY R
WHERE U.ID = R.USERID(+)
AND R.ID IS NULL;

SELECT *
FROM USERS U, REPLY R
WHERE U.ID = R.USERID(+)
MINUS
SELECT *
FROM USERS U, REPLY R
WHERE U.ID = R.USERID;

SELECT *
FROM BOARD B, REPLY R
WHERE B.ID = R.BOARDID;

SELECT B.ID, B.TITLE, B.USERID, COUNT(R.ID) "댓글수"
FROM BOARD B, REPLY R
WHERE B.ID = R.BOARDID(+)
GROUP BY B.ID, B.TITLE, B.USERID;

SELECT B.ID, B.TITLE, B.USERID, COUNT(R.ID) "댓글수"
FROM BOARD B, REPLY R, USERS U
WHERE B.ID = R.BOARDID(+) AND
GROUP BY B.ID, B.TITLE, B.USERID;

SELECT ID, TITLE, USERID,
(SELECT COUNT(*) FROM REPLY WHERE BOARDID = B.ID) "댓글수"
FROM BOARD B;
