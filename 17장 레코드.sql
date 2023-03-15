-- 레코드와 컬렉션


-- 자료형이 다른 여러 데이터를 저장하는 레코드
-- 기본 레코드

SET SERVEROUTPUT ON;

DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO NUMBER( 2 ) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE );
    dept_rec REC_DEPT;
    
BEGIN
    DEPT_REC.deptno := 99;
    dept_rec.DNAME := 'DATABASE';
    dept_rec.LOC := 'SEOUL';
    DBMS_OUTPUT.PUT_LINE( 'DEPTNO: ' || dept_REC.DEPTNO );
    DBMS_OUTPUT.PUT_LINE( 'DNAME: ' || dept_REC.DNAME );
    DBMS_OUTPUT.PUT_LINE( 'LOC: ' || dept_REC.LOC );
END;
/


-- 레코드를 사용한 INSERT

CREATE TABLE DEPT_RECORD
    AS SELECT * FROM DEPT;
desc dept_record;

SELECT * FROM DEPT_RECORD;

DECLARE
    TYPE REC_DEPT IS RECORD(
    deptno NUMBER( 2 ) NOT NULL := 99,
    dname dept.dname%type,
    loc DEPT.loc%type );
    
    DEPT_REC REC_DEPT;
    
BEGIN
    DEPT_REC.DEPTNO := 99;
    dept_rec.DNAME := 'DATABASE';
    dept_rec.LOC := 'SEOUL';
    
    INSERT INTO DEPT_RECORD
    VALUES dept_rec;
END;
/
SELECT * FROM DEPT_RECORD;


-- 레코드를 사용한 UPDATE

DECLARE
    TYPE REC_DEPT IS RECORD(
    deptno  NUMBER(2) NOT NULL := 99,
    dname dept.dname%type,
    loc DEPT.loc%type );
    
    DEPT_REC REC_DEPT;
    
BEGIN
    dept_rec.deptno := 50;
    dept_rec.dname := 'D';
    dept_rec.loc := 'SEOUL';
    
    UPDATE DEPT_RECORD
    SET ROW = dept_rec
    WHERE DEPTNO = 99;
END;
/

SELECT * FROM DEPT_RECORD;
    
    
SELECT * FROM EMP;
-- 중첩 레코드    
/
DECLARE 
    TYPE REC_DEPT IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE );        -- 1

    TYPE REC_EMP IS RECORD(
        EMPNO EMP.EMPNO%TYPE,
        ENAME EMP.ENAME%TYPE,
        DINFO REC_DEPT ); -- 1
    
    EMP_rec REC_EMP;
    
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
        INTO emp_rec.EMPNO, 
            emp_rec. ENAME,
            emp_rec.DINFO.DEPTNO,
            EMP_REC.DINFO.DNAME,
            EMP_REC.DINFO.LOC
        FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO
            AND E.EMPNO = 7369;
            
        DBMS_OUTPUT.PUT_LINE( 'EMPNO: ' || EMP_rec.EMPNO );
        DBMS_OUTPUT.PUT_LINE( 'ENAME: ' || EMP_rec.ENAME );
        DBMS_OUTPUT.PUT_LINE( 'DEPTNO: ' || EMP_rec.DINFO.DEPTNO );
        DBMS_OUTPUT.PUT_LINE( 'DNAME: ' || EMP_rec.DINFO.DNAME );
        DBMS_OUTPUT.PUT_LINE( 'LOC: ' || EMP_rec.DINFO.LOC );
END ;
/



-- 컬렉션
-- 연관 배열 사용하기


DECLARE 
    TYPE ITAB_EX IS TABLE OF VARCHAR2( 20 )
    INDEX BY PLS_INTEGER;
    
    text_arr ITAB_EX;
    
BEGIN
    text_arr( 1 ) := '1st data';
    text_arr( 2 ) := '2nd data';
    text_arr( 3 ) := '3rd data';
    text_arr( 4 ) := '4th data';
    
    DBMS_OUTPUT.PUT_LINE( 'text_arr( 1 ): ' || text_arr( 1) );
    DBMS_OUTPUT.PUT_LINE( 'text_arr( 2 ): ' || text_arr( 2 ) );
    DBMS_OUTPUT.PUT_LINE( 'text_arr( 3 ): ' || text_arr( 3 ) );
    DBMS_OUTPUT.PUT_LINE( 'text_arr( 4 ): ' || text_arr( 4 ) );
    
END;
/


-- 연관 배열 자료형에 레코드 사용하기 * 오류

DECLARE
    TYPE REC_DEPT IS RECORD(
        deptno DEPT.DEPTNO%TYPE,
        DNAME DEPT.DNAME%TYPE );
        
    TYPE ITAB_DETP IS TABLE OF REC_DEPT
        INDEX BY PLS_INTEGER;
        
    DEPT_arr ITAB_DEPT;
    idx PLS_INTEGER := 0;
    
BEGIN
    FOR i IN( SELECT DEPTNO, DNAME FROM DEPT ) LOOP
        idx := idx + 1;
        dept_arr(idx).deptno := i.deptno;
        dept_arr(idx).dname := i.dname;
        
    DBMS_OUTPUT.PUT_LINE( dept_arr(idx).deptno || ' : ' || dept_arr(idx).dname );
    END LOOP;
    
END;
/
        

-- ROWTYPE 자료형 저장

DECLARE
    TYPE ITAB_DEPT IS TABLE OF DEPT%ROWTYPE
        INDEX BY PLS_INTEGER;
        
    DEPT_ARR ITAB_DEPT;
    IDX PLS_INTEGER := 0;
    
BEGIN
    FOR i IN( SELECT * FROM DEPT ) LOOP
        IDX := IDX + 1;
        DEPT_ARR( IDX ).DEPTNO := i.DEPTNO;
        DEPT_ARR( IDX ).DNAME := i.DNAME;
        DEPT_ARR( IDX ).LOC := i.LOC;
        
        DBMS_OUTPUT.PUT_LINE(
        DEPT_ARR( IDX ).DEPTNO || ' : ' ||
        DEPT_ARR( IDX ).DNAME || ' : ' ||
        DEPT_ARR( IDX ).LOC );
    END LOOP;
END;
/


-- 컬렉션 메소드

DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2( 20 )
        INDEX BY PLS_INTEGER;
        
    TEXT_ARR ITAB_EX;
    
BEGIN
    TEXT_ARR( 1 ) := '1st data';
    TEXT_ARR( 2 ) := '2nd data';
    TEXT_ARR( 3 ) := '3rd data';
    TEXT_ARR( 50 ) := '50th data';
    
    DBMS_OUTPUT.PUT_LINE( 'TEXT_ARR.COUNT: ' || TEXT_ARR.COUNT );
    DBMS_OUTPUT.PUT_LINE( 'TEXT_ARR.FIRST: ' || TEXT_ARR.FIRST );
    DBMS_OUTPUT.PUT_LINE( 'TEXT_ARR.LAST: ' || TEXT_ARR.LAST );
    DBMS_OUTPUT.PUT_LINE( 'TEXT_ARR.PRIOR: ' || TEXT_ARR.PRIOR( 50 ));
    DBMS_OUTPUT.PUT_LINE( 'TEXT_ARR.NEXT: ' || TEXT_ARR.NEXT ( 50 ));
    
END;
/
    
    
    
        