-- PL/ SQL

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE( 'HELLO, PL/ SQL' );
END;
/


-- 주석

DECLARE V_EMPNO NUMBER( 4 ) := 7788;
        V_ENAME VARCHAR( 10 );
BEGIN
    V_ENAME := 'SCOTT';
    --DBMS_OUTPUT.PUT_LINE( 'V_EMPNO' || V_EMPNO );
    DBMS_OUTPUT.PUT_LINE( 'V_ENAME' || V_ENAME );
END;
/


-- 변수와 상수

DECLARE 
    V_TAX CONSTANT NUMBER( 1 ) := 3;
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'V_TAX' || V_TAX );
END;
/

-- 디폴트

DECLARE 
    V_DEPTNO NUMBER( 2 ) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'V_DEPTNO' || V_DEPTNO );
END;
/


-- NULL 값 저장 막기

DECLARE
    V_DEPTNO NUMBER( 2 ) NOT NULL := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'V_DEPTNO' || V_DEPTNO );
END;
/


-- NOT NULL, DEFAULT

DECLARE
    V_DEPTNO NUMBER( 2 ) NOT NULL DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'V_DEPTNO' || V_DEPTNO );
END;
/


-- 변수 참조형( %TYPE )

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'V_DEPTNO' || V_DEPTNO );
END;
/


-- 참조형 ( %ROWTYPE )

DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
        FROM DEPT
            WHERE DEPTNO = 40;
    DBMS_OUTPUT.PUT_LINE( 'V_DEPT_ROW.DEPTNO' || V_DEPT_ROW.DEPTNO );  --40
    DBMS_OUTPUT.PUT_LINE( 'V_DEPT_ROW.DNAME' || V_DEPT_ROW.DNAME );     --OPERATIONS
    DBMS_OUTPUT.PUT_LINE( 'V_DEPT_ROW.LOC' || V_DEPT_ROW.LOC );     --BOSTON
END;
/

SELECT * FROM DEPT;


-- 복합형 ( IF )

DECLARE 
    V_NUMBER NUMBER  := 13;
BEGIN
    IF MOD( V_NUMBER, 2 ) = 1 THEN
    DBMS_OUTPUT.PUT_LINE( 'V_NUMBER는 홀수입니다.' );
    END IF;
END;
/

-- 조건 제어문 ( IF - THEN - ELSE )

DECLARE 
    V_NUMBER NUMBER  := 14;
BEGIN
    IF MOD( V_NUMBER, 2 ) = 1 THEN
        DBMS_OUTPUT.PUT_LINE( 'V_NUMBER는 홀수입니다.' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( 'V_NUMBER는 짝수입니다.' );
    END IF;
END;
/


-- 조건 제어문 ( IF - THEN - ELSIF )

DECLARE 
    V_SCORE NUMBER  := 87;
BEGIN
    IF V_SCORE >= 90 THEN
        DBMS_OUTPUT.PUT_LINE( 'A학점' );
    ELSIF V_SCORE >= 80 THEN
        DBMS_OUTPUT.PUT_LINE( 'B학점' );
    ELSIF V_SCORE >= 70 THEN
        DBMS_OUTPUT.PUT_LINE( 'C학점' );
    ELSIF V_SCORE >= 60 THEN
        DBMS_OUTPUT.PUT_LINE( 'D학점' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( 'F학점' );
    END IF;
END;
/

-- 조건 제어문 ( CASE )


DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC( V_SCORE/ 10 )
        WHEN 10 THEN
            DBMS_OUTPUT.PUT_LINE( 'A학점' );
        WHEN 9 THEN
            DBMS_OUTPUT.PUT_LINE( 'A학점' );
        WHEN 8 THEN
            DBMS_OUTPUT.PUT_LINE( 'B학점' );
        WHEN 7 THEN
            DBMS_OUTPUT.PUT_LINE( 'C학점' );
        WHEN 6 THEN
            DBMS_OUTPUT.PUT_LINE( 'D학점' );
        ELSE
            DBMS_OUTPUT.PUT_LINE( 'F학점' );
    END CASE;
END;
/

-- CASE 조건 바로 갖다붙여서

DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE
        WHEN V_SCORE >= 90 THEN
            DBMS_OUTPUT.PUT_LINE( 'A학점' );
        WHEN V_SCORE >= 80 THEN
            DBMS_OUTPUT.PUT_LINE( 'B학점' );
        WHEN V_SCORE >= 70 THEN
            DBMS_OUTPUT.PUT_LINE( 'C학점' );
        WHEN V_SCORE >= 60 THEN
            DBMS_OUTPUT.PUT_LINE( 'D학점' );
        ELSE
            DBMS_OUTPUT.PUT_LINE( 'F학점' );
    END CASE;
END;
/


-- 기본 LOOP

DECLARE
    V_NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE( '현재 V_NUM' || V_NUM );
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 4;
    END LOOP;
END;
/


-- WHILE LOOP

DECLARE
    V_NUM NUMBER := 0;
BEGIN
    WHILE V_NUM < 4 LOOP
        DBMS_OUTPUT.PUT_LINE( '현재 V_NUM' || V_NUM );
        V_NUM := V_NUM + 1;
    END LOOP;
END;
/


-- 반복 제어문( FOR LOOP )

BEGIN
    FOR I IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE( '현재 I의 값:' || i);
    END LOOP;
END;
/

-- 역순( REVERSE )

BEGIN
    FOR I IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE( '현재 I의 값:' || i);
    END LOOP;
END;
/


-- CONTINUE 즉시 다음 반복 주기로 이동

BEGIN
    FOR I IN 0..4 LOOP
        CONTINUE WHEN MOD( i, 2 ) = 1;
        DBMS_OUTPUT.PUT_LINE( '현재 I의 값:' || i);
    END LOOP;
END;
/