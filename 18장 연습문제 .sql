SET SERVEROUTPUT ON;

-- 18/ Q1-1 ( LOOP )

SELECT * FROM EMP;
/

DECLARE
    V_EMP_ROW EMP%ROWTYPE;

    CURSOR c1 IS
        SELECT EMPNO, ENAME, JOB,
                MGR, HIREDATE, SAL, COMM, DEPTNO
            FROM EMP;
        
BEGIN
    OPEN c1;
 
    LOOP
    FETCH c1 INTO V_EMP_ROW;
    
    EXIT WHEN c1%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE( 'EMPNO : ' || V_EMP_ROW.EMPNO
                        ||', ENAME: ' || V_EMP_ROW.ENAME
                        ||', JOB: ' || V_EMP_ROW.JOB
                        ||', MGR: ' || V_EMP_ROW.MGR
                        ||', HIREDATE: ' || V_EMP_ROW.HIREDATE
                        ||', SAL: ' || V_EMP_ROW.SAL
                        ||', COMM: ' || V_EMP_ROW.COMM
                        ||', DEPTNO: ' || V_EMP_ROW.DEPTNO
                        );
    END LOOP;
    CLOSE c1;
END;
/

-- Q1-2 ( FOR LOOP )


DECLARE
    CURSOR c1 IS
        SELECT EMPNO, ENAME, JOB,
                MGR, HIREDATE, SAL, COMM, DEPTNO
            FROM EMP;
            
BEGIN
-- 커서 FOR LOOP 시작 (자동 Open, Fetch, Close)
    FOR V_EMP_ROW IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE( 'EMPNO : ' || V_EMP_ROW.EMPNO
                        ||', ENAME: ' || V_EMP_ROW.ENAME
                        ||', JOB: ' || V_EMP_ROW.JOB
                        ||', MGR: ' || V_EMP_ROW.MGR
                        ||', HIREDATE: ' || V_EMP_ROW.HIREDATE
                        ||', SAL: ' || V_EMP_ROW.SAL
                        ||', COMM: ' || V_EMP_ROW.COMM
                        ||', DEPTNO: ' || V_EMP_ROW.DEPTNO
                        );
        END LOOP;
END;

/


-- 18/ Q-2

DESC EMP;

DECLARE
    V_WRONG DATE;
    
BEGIN
    SELECT ENAME INTO V_WRONG                   --1
        FROM EMP
            WHERE EMPNO = 7369;           
            
        DBMS_OUTPUT.PUT_LINE( '예외 발생 시 출력 X' );
        
    EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE( ' 오류가 발생하였습니다 ' || TO_CHAR( SYSDATE,'YYYY"년"-MM"월"-DD"일" HH24"시"MI"분"SS"초"' ));
            DBMS_OUTPUT.PUT_LINE( 'SQLCODE: ' || TO_CHAR( SQLCODE ));
            DBMS_OUTPUT.PUT_LINE( 'SQLERRM: ' || 'ORA-01841: ' || '년은 영이 아닌 -4713과 +4713 사이 값으로 지정해야 합니다.'  );
    END;
/