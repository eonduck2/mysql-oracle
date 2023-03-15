SET SERVEROUTPUT ON;

-- 19/ Q1

DESC DEPT;
SELECT * FROM USER_PROCEDURES;

CREATE OR REPLACE PROCEDURE pro_dept_in(
    deptno      DEPT.DEPTNO%TYPE,
    DNAME       DEPT.DNAME%TYPE,
    LOC         DEPT.LOC%TYPE )

IS

BEGIN
    DBMS_OUTPUT.PUT_LINE( '부서 번호: ' || deptno );
    DBMS_OUTPUT.PUT_LINE( '부서 이름: ' || DNAME );
    DBMS_OUTPUT.PUT_LINE( '지역: ' || LOC );    
END;
/

EXECUTE PRO_dept_in(10, 'ACCOUNTING', 'NEW YORK');



-- 19/ Q2

CREATE OR REPLACE FUNCTION func_date_KOR(
    FDATE in DATE )
    
    RETURN VARCHAR2
IS
BEGIN
    RETURN( TO_CHAR( FDATE, 'YYYY"년"MM"월"DD"일"' ));
END;
/

SELECT * FROM user_source ;

/

SELECT ENAME, func_date_KOR( HIREDATE ) AS 입사년월
    FROM EMP
    WHERE DEPTNO = 7369;
    
    
SELECT * FROM EMP;    
-- 19/ Q2

-- Q2 - 1
CREATE TABLE DEPT_TRG
    AS SELECT * FROM DEPT;
    
SELECT * FROM DEPT_TRG;

-- Q2 - 2

CREATE TABLE EMP_TRG_LOG1(
    TABLENAME       VARCHAR2( 10 ), 
    DML_TYPE        VARCHAR2( 10 ), 
    DEPTNO          NUMBER( 2 ), 
    USER_NAME       VARCHAR2( 30 ), 
    CHANGE_DATE     DATE ); 

DESC EMP_TRG_LOG1;    

--Q3 - 3

CREATE OR REPLACE TRIGGER TRG_DEPT_LOG
AFTER
    INSERT OR UPDATE OR DELETE ON DEPT_TRG
FOR EACH ROW    

BEGIN

    IF INSERTING THEN
        INSERT INTO emp_trg_log1
        VALUES( 'DEPT_TRG', 'INSERT', :new.deptno, SYS_CONTEXT( 'USERENV', 'SESSION_USER'), SYSDATE); -- 현재 DB에 접속 중인 사용자

    ELSIF UPDATING THEN
        INSERT INTO emp_trg_log1
        VALUES( 'DEPT_TRG', 'UPDATE', :old.deptno, SYS_CONTEXT( 'USERENV', 'SESSION_USER'), sysdate); 
        
    ELSIF DELETING THEN
        INSERT INTO emp_trg_log1
        VALUES( 'DEPT_TRG', 'DELETE', :old.deptno, SYS_CONTEXT( 'USERENV', 'SESSION_USER'), sysdate);
        
    END IF;
END;
/

DESC DEPT;

INSERT INTO DEPT_TRG
    VALUES( 99, 'TEST_DNAME', 'SEOUL' );
    
UPDATE DEPT_TRG
SET LOC = 'test_lOC'
WHERE DEPTNO = 99;

DELETE FROM DEPT_TRG WHERE DEPTNO =99;

SELECT * FROM USER_TRIGGERS;

SELECT * FROM EMP_TRG_LOG1;