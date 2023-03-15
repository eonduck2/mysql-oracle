        -- 커서와 예외 처리

-- SELECT INTO 방식

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

-- 명시적 커서 ( 하나의 행 )
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


    -- 특정 열을 선택하여 처리하는 커서 LOOP

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
 

-- 커서 FOR LOOP 사용

DECLARE
    CURSOR c1 IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT;
            
BEGIN
-- 커서 FOR LOOP 시작 (자동 Open, Fetch, Close)
    FOR c1_rec IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE( 'DEPTNO : ' || c1_rec.DEPTNO
                        ||', DNAME: ' || c1_rec.DNAME
                        ||', LOC: ' || c1_rec.LOC );
        END LOOP;
END;

/

SELECT * FROM DEPT_RECORD;



-- 파라미터를 사용한 커서 ( 마치 함수처럼 )

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
            DBMS_OUTPUT.PUT_LINE( '10번 부서 - DEPTNO: ' || 
                                V_DEPT_ROW.DEPTNO||
                                ', DNAME: ' || V_DEPT_ROW.DNAME ||
                                ', LOC: ' || V_DEPT_ROW.LOC );
            END LOOP;
        CLOSE c1;
        
    OPEN c1( 20 );
        LOOP
            FETCH c1 INTO V_DEPT_ROW;
            EXIT WHEN c1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE( '20번 부서 - DEPTNO: ' || 
                                V_DEPT_ROW.DEPTNO||
                                ', DNAME: ' || V_DEPT_ROW.DNAME ||
                                ', LOC: ' || V_DEPT_ROW.LOC );
            END LOOP;
        CLOSE c1;
    END;
/
            
            
    
-- 커서에 사용할 파라미터 입력받기

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
    
    
-- 묵시적 커서 속성 사용

SELECT * FROM DEPT;

BEGIN
    UPDATE DEPT
    SET DNAME = 'DATABASE'
    WHERE DEPTNO = 50;
    
    DBMS_OUTPUT.PUT_LINE( ' 갱신된 행의 수: ' || SQL%ROWCOUNT );
    
    IF( SQL%FOUND ) THEN
        DBMS_OUTPUT.PUT_LINE( ' 갱신 대상 행 존재 여부: TRUE ' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( ' 갱신 대상 행 존재 여부: FALSE ' );
    END IF;
    
    IF( SQL%ISOPEN ) THEN  
        DBMS_OUTPUT.PUT_LINE( ' 커서의 OPEN 여부: TRUE ' );
    ELSE
        DBMS_OUTPUT.PUT_LINE( ' 커서의 OPEN 여부: FALSE ' );
    END IF;
END;
/


-- 예외 처리

DESC DEPT;

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
    END;
/

-- EXCEPTION 추가

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
            
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE( '예외 처리: 수치 또는 값 오류 발생' );
    END;
/    

-- EXCEPTION 발생 후의 실행 코드 순서 확인

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
            
        DBMS_OUTPUT.PUT_LINE( '예외 발생 시 출력 X' );
            
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE( '예외 처리: 수치 또는 값 오류 발생' );
    END;
/    



-- 사전 정의된 예외 사용하기

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
            
        DBMS_OUTPUT.PUT_LINE( '예외 발생 시 출력 X' );
        
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE( '예외 처리: 요구보다 많은 행 추출 오류 발생' );
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE( '예외 처리: 수치 또는 값 오류 발생' );
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE( '예외 처리: 사전 정의 외 오류 발생' );
    END;
/



-- 오류 코드와 오류 메시지 사용하기

DECLARE
    V_WRONG NUMBER;
    
BEGIN
    SELECT DNAME INTO V_WRONG
        FROM DEPT
            WHERE DEPTNO = 10;
            
        DBMS_OUTPUT.PUT_LINE( '예외 발생 시 출력 X' );
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE( '예외 처리: 사전 정의 외 오류 발생' );
            DBMS_OUTPUT.PUT_LINE( 'SQLCODE: ' || TO_CHAR( SQLCODE ));
            DBMS_OUTPUT.PUT_LINE( 'SQLERRM: ' || SQLERRM );
    END;
/