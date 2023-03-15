        -- Ŀ���� ���� ó��

-- SELECT INTO ���

DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
    FROM DEPT
    WHERE DEPTNO = 40;
    DBMS_OUTPUT.PUT_LINE( 'DEPTNO: ' || V_DEPT_ROW.DEPTNO );
    DBMS_OUTPUT.PUT_LINE( 'DNAME: ' || V_DEPT_ROW.DNAME );
    DBMS_OUTPUT.PUT_LINE( 'LOC: ' || V_DEPT_ROW.LOC );
    
END;
/

-- ����� Ŀ�� ( �ϳ��� �� )
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT
                WHERE DEPTNO = 40;
                
BEGIN
    OPEN c1;
    
    FETCH c1 INTO V_DEPT_ROW;
    
    DBMS_OUTPUT.PUT_LINE( 'DEPTNO: ' || V_DEPT_ROW.DEPTNO );
    DBMS_OUTPUT.PUT_LINE( 'DEPTNO: ' || V_DEPT_ROW.DNAME );
    DBMS_OUTPUT.PUT_LINE( 'DEPTNO: ' || V_DEPT_ROW.LOC );
    
    CLOSE c1;
    
END;
/


    -- Ư�� ���� �����Ͽ� ó���ϴ� Ŀ�� LOOP

DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;

    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT;
        
BEGIN
    OPEN c1;
 
    LOOP
    FETCH c1 INTO V_DEPT_ROW;
    
    EXIT WHEN c1%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE( 'DEPTNO : ' || V_DEPT_ROW.DEPTNO
                        ||', DNAME: ' || V_DEPT_ROW.DNAME
                        ||', LOC: ' || V_DEPT_ROW.LOC );
    END LOOP;
    CLOSE c1;
END;
/
 

-- Ŀ�� FOR LOOP ���

DECLARE
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT;
            
BEGIN
-- Ŀ�� FOR LOOP ���� (�ڵ� Open, Fetch, Close)
    FOR c1_rec IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE( 'DEPTNO : ' || c1_rec.DEPTNO
                        ||', DNAME: ' || c1_rec.DNAME
                        ||', LOC: ' || c1_rec.LOC );
        END LOOP;
END;

/

SELECT * FROM DEPT_RECORD;



-- �Ķ���͸� ����� Ŀ�� ( ��ġ �Լ�ó�� )

DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    
    CURSOR c1( p_DEPTNO DEPT.DEPTNO%TYPE ) IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT
            WHERE DEPTNO = P_DEPTNO;    
            
BEGIN
    OPEN c1( 10 );
        LOOP
            FETCH c1 INTO V_DEPT_ROW;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE( '10�� �μ� - DEPTNO: ' || 
                                V_DEPT_ROW.DEPTNO||
                                ', DNAME: ' || V_DEPT_ROW.DNAME ||
                                ', LOC: ' || V_DEPT_ROW.LOC );
            END LOOP;
        CLOSE c1;
        
    OPEN c1( 20 );
        LOOP
            FETCH c1 INTO V_DEPT_ROW;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE( '20�� �μ� - DEPTNO: ' || 
                                V_DEPT_ROW.DEPTNO||
                                ', DNAME: ' || V_DEPT_ROW.DNAME ||
                                ', LOC: ' || V_DEPT_ROW.LOC );
            END LOOP;
        CLOSE c1;
    END;
/
            
            
    
-- Ŀ���� ����� �Ķ���� �Է¹ޱ�

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE;
    
    CURSOR c1 ( P_DEPTNO DEPT.DEPTNO%TYPE ) IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT
                WHERE DEPTNO = p_deptno;
                
BEGIN
    V_DEPTNO := &INPUT_DEPTNO;
        FOR c1_rec IN c1( V_DEPTNO ) LOOP
            DBMS_OUTPUT.PUT_LINE( 'DEPTNO: ' || 
                                c1_rec.DEPTNO||
                                ', DNAME: ' || c1_rec.DNAME ||
                                ', LOC: ' || c1_rec.LOC );
            END LOOP;
       
    END;
/
    
    
-- ������ Ŀ�� �Ӽ� ���

SELECT * FROM DEPT;

BEGIN
    UPDATE DEPT
    SET DNAME = 'DATABASE'
    WHERE DEPTNO = 50;
    
    DBMS_OUTPUT.PUT_LINE( ' ���ŵ� ���� ��: ' || SQL%ROWCOUNT );
    
    IF( SQL%FOUND ) THEN
        DBMS_OUTPUT.PUT_LINE( ' ���� ��� �� ���� ����: TRUE ' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( ' ���� ��� �� ���� ����: FALSE ' );
    END IF;
    
    IF( SQL%ISOPEN ) THEN  
        DBMS_OUTPUT.PUT_LINE( ' Ŀ���� OPEN ����: TRUE ' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( ' Ŀ���� OPEN ����: FALSE ' );
    END IF;
END;
/


-- ���� ó��

DESC DEPT;

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
    END;
/

-- EXCEPTION �߰�

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
            
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE( '���� ó��: ��ġ �Ǵ� �� ���� �߻�' );
    END;
/    

-- EXCEPTION �߻� ���� ���� �ڵ� ���� Ȯ��

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
            
        DBMS_OUTPUT.PUT_LINE( '���� �߻� �� ��� X' );
            
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE( '���� ó��: ��ġ �Ǵ� �� ���� �߻�' );
    END;
/    



-- ���� ���ǵ� ���� ����ϱ�

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
            
        DBMS_OUTPUT.PUT_LINE( '���� �߻� �� ��� X' );
        
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE( '���� ó��: �䱸���� ���� �� ���� ���� �߻�' );
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE( '���� ó��: ��ġ �Ǵ� �� ���� �߻�' );
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE( '���� ó��: ���� ���� �� ���� �߻�' );
    END;
/



-- ���� �ڵ�� ���� �޽��� ����ϱ�

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
            
        DBMS_OUTPUT.PUT_LINE( '���� �߻� �� ��� X' );
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE( '���� ó��: ���� ���� �� ���� �߻�' );
            DBMS_OUTPUT.PUT_LINE( 'SQLCODE: ' || TO_CHAR( SQLCODE ));
            DBMS_OUTPUT.PUT_LINE( 'SQLERRM: ' || SQLERRM );
    END;
/