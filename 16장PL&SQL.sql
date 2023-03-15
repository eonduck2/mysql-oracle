-- PL/ SQL

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE( 'HELLO, PL/ SQL' );
END;
/


-- �ּ�

DECLARE V_EMPNO NUMBER( 4 ) := 7788;
        V_ENAME VARCHAR( 10 );
BEGIN
    V_ENAME := 'SCOTT';
    --DBMS_OUTPUT.PUT_LINE( 'V_EMPNO' || V_EMPNO );
    DBMS_OUTPUT.PUT_LINE( 'V_ENAME' || V_ENAME );
END;
/


-- ������ ���

DECLARE 
    V_TAX CONSTANT NUMBER( 1 ) := 3;
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'V_TAX' || V_TAX );
END;
/

-- ����Ʈ

DECLARE 
    V_DEPTNO NUMBER( 2 ) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'V_DEPTNO' || V_DEPTNO );
END;
/


-- NULL �� ���� ����

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


-- ���� ������( %TYPE )

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE( 'V_DEPTNO' || V_DEPTNO );
END;
/


-- ������ ( %ROWTYPE )

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


-- ������ ( IF )

DECLARE 
    V_NUMBER NUMBER  := 13;
BEGIN
    IF MOD( V_NUMBER, 2 ) = 1 THEN
    DBMS_OUTPUT.PUT_LINE( 'V_NUMBER�� Ȧ���Դϴ�.' );
    END IF;
END;
/

-- ���� ��� ( IF - THEN - ELSE )

DECLARE 
    V_NUMBER NUMBER  := 14;
BEGIN
    IF MOD( V_NUMBER, 2 ) = 1 THEN
        DBMS_OUTPUT.PUT_LINE( 'V_NUMBER�� Ȧ���Դϴ�.' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( 'V_NUMBER�� ¦���Դϴ�.' );
    END IF;
END;
/


-- ���� ��� ( IF - THEN - ELSIF )

DECLARE 
    V_SCORE NUMBER  := 87;
BEGIN
    IF V_SCORE >= 90 THEN
        DBMS_OUTPUT.PUT_LINE( 'A����' );
    ELSIF V_SCORE >= 80 THEN
        DBMS_OUTPUT.PUT_LINE( 'B����' );
    ELSIF V_SCORE >= 70 THEN
        DBMS_OUTPUT.PUT_LINE( 'C����' );
    ELSIF V_SCORE >= 60 THEN
        DBMS_OUTPUT.PUT_LINE( 'D����' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( 'F����' );
    END IF;
END;
/

-- ���� ��� ( CASE )


DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC( V_SCORE/ 10 )
        WHEN 10 THEN
            DBMS_OUTPUT.PUT_LINE( 'A����' );
        WHEN 9 THEN
            DBMS_OUTPUT.PUT_LINE( 'A����' );
        WHEN 8 THEN
            DBMS_OUTPUT.PUT_LINE( 'B����' );
        WHEN 7 THEN
            DBMS_OUTPUT.PUT_LINE( 'C����' );
        WHEN 6 THEN
            DBMS_OUTPUT.PUT_LINE( 'D����' );
        ELSE
            DBMS_OUTPUT.PUT_LINE( 'F����' );
    END CASE;
END;
/

-- CASE ���� �ٷ� ���ٺٿ���

DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE
        WHEN V_SCORE >= 90 THEN
            DBMS_OUTPUT.PUT_LINE( 'A����' );
        WHEN V_SCORE >= 80 THEN
            DBMS_OUTPUT.PUT_LINE( 'B����' );
        WHEN V_SCORE >= 70 THEN
            DBMS_OUTPUT.PUT_LINE( 'C����' );
        WHEN V_SCORE >= 60 THEN
            DBMS_OUTPUT.PUT_LINE( 'D����' );
        ELSE
            DBMS_OUTPUT.PUT_LINE( 'F����' );
    END CASE;
END;
/


-- �⺻ LOOP

DECLARE
    V_NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE( '���� V_NUM' || V_NUM );
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
        DBMS_OUTPUT.PUT_LINE( '���� V_NUM' || V_NUM );
        V_NUM := V_NUM + 1;
    END LOOP;
END;
/


-- �ݺ� ���( FOR LOOP )

BEGIN
    FOR I IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE( '���� I�� ��:' || i);
    END LOOP;
END;
/

-- ����( REVERSE )

BEGIN
    FOR I IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE( '���� I�� ��:' || i);
    END LOOP;
END;
/


-- CONTINUE ��� ���� �ݺ� �ֱ�� �̵�

BEGIN
    FOR I IN 0..4 LOOP
        CONTINUE WHEN MOD( i, 2 ) = 1;
        DBMS_OUTPUT.PUT_LINE( '���� I�� ��:' || i);
    END LOOP;
END;
/