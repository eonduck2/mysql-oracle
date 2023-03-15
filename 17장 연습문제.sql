-- 17/ Q1

CREATE TABLE EMP_RECORD
    AS SELECT * FROM EMP
    WHERE 1 ^= 1;
    
SELECT * FROM EMP_RECORD;

/
DECLARE
    TYPE E_RCD IS RECORD(
        EMPNO       NUMBER( 4 ) NOT NULL := 1111,
        ENAME       EMP.ENAME%TYPE,
        JOB         EMP.JOB%TYPE,
        MGR         EMP.MGR%TYPE,
        HIREDATE    EMP.HIREDATE%TYPE, 
        SAL         EMP.SAL%TYPE,
        COMM        EMP.COMM%TYPE,
        DEPTNO      EMP.DEPTNO%TYPE );
        
    E_RCD2 E_RCD;
    
BEGIN
    E_RCD2.EMPNO := 1111;
    E_RCD2.ENAME := 'TEST_USER';
    E_RCD2.JOB := 'TEST_308';
    E_RCD2.MGR := NULL;
    E_RCD2.HIREDATE := TO_DATE( '2018/03/01', 'YYYY/MM/DD' );
    E_RCD2.SAL := 3000;
    E_RCD2.COMM := NULL;
    E_RCD2.DEPTNO := 40;
    
    INSERT INTO EMP_RECORD
    VALUES E_RCD2;
    
END;
/

SELECT * FROM EMP_RECORD;


-- 17/ Q2

DECLARE
    TYPE ITAB_EMP IS TABLE OF EMP%ROWTYPE
        INDEX BY PLS_INTEGER;
        
    EMP_ARR ITAB_EMP;
    IDX PLS_INTEGER := 0;
    
BEGIN
    FOR i IN( SELECT * FROM EMP ) LOOP
        IDX := IDX + 1;
        EMP_ARR( IDX ).EMPNO := i.EMPNO;
        EMP_ARR( IDX ).ENAME := i.ENAME;
        EMP_ARR( IDX ).JOB := i.JOB;
        EMP_ARR( IDX ).MGR := i.MGR;
        EMP_ARR( IDX ).HIREDATE := i.HIREDATE;
        EMP_ARR( IDX ).SAL := i.SAL;
        EMP_ARR( IDX ).COMM := i.COMM;
        EMP_ARR( IDX ).DEPTNO := i.DEPTNO;
        
        DBMS_OUTPUT.PUT_LINE(
        EMP_ARR( IDX ).EMPNO || ' : ' ||
        EMP_ARR( IDX ).ENAME || ' : ' ||
        EMP_ARR( IDX ).JOB || ' : ' || 
        EMP_ARR( IDX ).MGR || ' : ' ||
        EMP_ARR( IDX ).HIREDATE || ' : ' ||
        EMP_ARR( IDX ).SAL || ' : ' ||
        EMP_ARR( IDX ).COMM || ' : ' ||
        EMP_ARR( IDX ).DEPTNO
        );
    END LOOP;
END;
/
