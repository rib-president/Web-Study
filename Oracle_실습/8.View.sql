--View : 가상(virtual) TABLE
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPT;

SELECT * FROM DEPT_COPY;

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP;

SELECT * FROM EMP_COPY;

CREATE VIEW EMP_VIEW30
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=30;

SELECT * FROM EMP_VIEW30;

SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=30;

DESC EMP_VIEW30;

CREATE VIEW EMP_VIEW20
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=20;

SELECT * FROM EMP_VIEW20;

--VIEW TABLE의 내부 구조 살펴보기
DESC USER_VIEW;

SELECT VIEW_NAME, TEXT FROM USER_VIEWS;


--VIEW TABLE에 INSERT
INSERT INTO EMP_VIEW30
VALUES (1111, 'AAAA', 30);

SELECT * FROM EMP_VIEW30;

SELECT * FROM EMP_COPY;

--VIEW 칼럼에 ALIAS(별칭) 부여
CREATE OR REPLACE VIEW EMP_VIEW (사원번호, 사원명, 급여, 부서번호)
AS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_COPY;

SELECT * FROM EMP_VIEW WHERE 부서번호=20;

--VIEW 삭제
DROP VIEW EMP_VIEW;

--복합 VIEW
CREATE OR REPLACE VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;

SELECT * FROM EMP_VIEW_DEPT;

CREATE OR REPLACE VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;

--조건 컬럼 값을 변경하지 못하게 막는 WITH CHECK OPTION 사용
--INSERT INTO EMP_VIEW30 VALUES (2222, 'BBBB', 20);

UPDATE EMP_VIEW30 SET DEPTNO = 20 WHERE EMPNO=1111;

SELECT * FROM EMP_VIEW30;
SELECT * FROM EMP_COPY;

CREATE OR REPLACE VIEW VIEW_CHK30
AS
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO
FROM EMP_COPY
WHERE DEPTNO = 30 WITH CHECK OPTION;

SELECT * FROM VIEW_CHK30;

UPDATE VIEW_CHK30
SET DEPTNO = 20
WHERE EMPNO = 7900;

UPDATE VIEW_CHK30
SET ENAME = 'JAMESJR'
WHERE EMPNO = 7900;

INSERT INTO VIEW_CHK30
VALUES(1234, 'HIHI', 111, NULL, 20);


--VIEW를 통해 기본 테이블 변경을 막는 WITH READ ONLY
CREATE OR REPLACE VIEW VIEW_READ30
AS
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO
FROM EMP_COPY
WHERE DEPTNO = 30 WITH READ ONLY;

UPDATE VIEW_READ30 SET COMM = 5000;

INSERT INTO VIEW_READ30
VALUES (1234, 'HIHI', 1, NULL, 30);

DELETE FROM VIEW_READ30 WHERE DEPTNO = 30;

--ROWNUM
SELECT * FROM EMP;

SELECT ROWNUM, EMP.* FROM EMP;

SELECT * 
FROM (SELECT * FROM EMP ORDER BY SAL DESC);

--SAL이 상위 3명을 가져와라
--(SELECT * FROM EMP ORDER BY SAL DESC) : INLINE VIEW
SELECT *
FROM(SELECT * FROM EMP ORDER BY SAL DESC)
WHERE ROWNUM <= 3;


CREATE OR REPLACE VIEW VIEW_HIRE
AS
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
ORDER BY HIREDATE;

SELECT ROWNUM, VIEW_HIRE.* FROM VIEW_HIRE;

SELECT * FROM VIEW_HIRE WHERE ROWNUM <= 3;










