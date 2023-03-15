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
-- Ŀ�� FOR LOOP ���� (�ڵ� Open, Fetch, Close)
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
            
        DBMS_OUTPUT.PUT_LINE( '���� �߻� �� ��� X' );
        
    EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE( ' ������ �߻��Ͽ����ϴ� ' || TO_CHAR( SYSDATE,'YYYY"��"-MM"��"-DD"��" HH24"��"MI"��"SS"��"' ));
            DBMS_OUTPUT.PUT_LINE( 'SQLCODE: ' || TO_CHAR( SQLCODE ));
            DBMS_OUTPUT.PUT_LINE( 'SQLERRM: ' || 'ORA-01841: ' || '���� ���� �ƴ� -4713�� +4713 ���� ������ �����ؾ� �մϴ�.'  );
    END;
/