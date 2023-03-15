SET SERVEROUTPUT ON;

-- 19 저장 서브 프로그램

-- 19-2 파라미터를 사용하지 않는 프로시저

CREATE OR REPLACE PROCEDURE pro_noparam
IS
    V_EMPNO NUMBER( 4 ) := 7369;
    V_ENAME VARCHAR2 ( 10 );
BEGIN
    V_ENAME := 'SMITH';
    DBMS_OUTPUT.PUT_LINE( CONCAT( 'V_EMPNO: ', V_EMPNO ));
    DBMS_OUTPUT.PUT_LINE( 'V_ENAME: ' || V_ENAME );
END;
/
    
SELECT * FROM user_PROCEDURES;
SELECT * FROM user_source;

EXECUTE pro_noParam;
/

BEGIN
    pro_noparam;
end;
/

DROP PROCEDURE pro_noparam;


-- 19-2 파라미터를 사용한 프로시저 ( IN )


CREATE OR REPLACE PROCEDURE pro_param_in(
    param1 IN number,
    param2 number,
    param3 number := 3,
    param4 number DEFAULT 4 )
    
IS

BEGIN
    DBMS_OUTPUT.PUT_LINE( ' param1: ' || param1 );
    DBMS_OUTPUT.PUT_LINE( ' param2: ' || param2 );
    DBMS_OUTPUT.PUT_LINE( ' param3: ' || param3 );
    DBMS_OUTPUT.PUT_LINE( ' param4: ' || param4 );
END;
/

EXECUTE pro_param_in( 1, 2 );

BEGIN
    pro_param_in(1, 2, 9, 8);
END;
/

EXECUTE pro_param_in( Param1 => 10, Param2 => 20 );



-- 19-2 파라미터를 사용한 프로시저 ( OUT )


CREATE OR REPLACE PROCEDURE pro_param_out(
    in_empno IN EMP.EMPNO%TYPE,
    out_ename out EMP.ENAME%Type,
    OUT_sal out emp.sal%TYPE )

IS

BEGIN
    SELECT ENAME, SAL INTO OUT_ENAME, out_sal
    FROM EMP
    WHERE EMPNO = in_empno;
END;
/

DECLARE 
    v_ename EMP.ENAME%TYPE;
    v_sal   EMP.SAL%TYPE;
BEGIN
    pro_param_out( 7369, v_ename, v_sal );
    DBMS_OUTPUT.PUT_LINE( ' ENAME: ' || v_ename );
    DBMS_OUTPUT.PUT_LINE( ' sal: ' || v_sal );
    
END;
/

-- 19-2 파라미터를 사용한 프로시저 ( IN OUT )

CREATE OR REPLACE PROCEDURE pro_param_inout(
    input_no IN OUT NUMBER )
    
IS

BEGIN
    INPUT_NO := input_no * 2;
END pro_param_inout;
/

DECLARE
    no number;
BEGIN
    no := 5;
    pro_param_inout( no );
    DBMS_OUTPUT.PUT_LINE( ' no: ' || no );
END;
/
    
    
-- 프로시저 오류 정보 확인하기

CREATE OR REPLACE PROCEDURE pro_err
IS
    err_no = 100;
    DBMS_OUTPUT.PUT_LINE( ' err_no: ' || err_no );
END;
/

show errors;

SELECT * FROM USER_ERRORS;


-- 함수

-- 급여 값을 입력 받아 세금을 제한 실수령액 계산

CREATE FUNCTION func_aftertax(
    sal in number )
    
    RETURN NUMBER
IS
    tax NUMBER := 0.05;
BEGIN
    RETURN( ROUND( sal- ( sal * tax )));
END;
/

-- 함수 실행
DECLARE
    aftertax NUMBER;
BEGIN
    aftertax := func_aftertax( 3000 );
    DBMS_OUTPUT.PUT_LINE( ' after-tax income: ' || aftertax );
END;
/

-- SELECT 문으로 함수 실행

SELECT FUNC_AFTERTAX( 3000 ) FROM DUAL;


-- 함수에 테이블 데이터 사용하기

SELECT EMPNO, ENAME, SAL, func_aftertax(SAL) AS AFTERTAX
    FROM EMP;
    
    
-- 함수 삭제

DROP FUNCTION FUNC_aftertax;

SELECT * FROM USER_FUNCTIONS;


-- 패키지

-- 패키지 생성

CREATE PACKAGE pkg_example
IS
    spec_no number := 10;
    function func_aftertax( sal number ) return number;
    procedure pro_emp( in_empno IN emp.empno%type );
    procedure pro_dept( in_deptno IN emp.deptno%type );
End;
/

DROP PACKAGE pkg_example;

SELECT text
    fROM user_source
    WHERE TYPE = 'package'
    AND   NAME = 'pkg_example';
    
DESC pkg_example;

-- 패키지 바디 생성하기

CREATE PACKAGE BODY pkg_example
IS
    body_no NUMBER := 10;
    
    FUNCTION func_aftertax( sal NUMBER ) 
        RETURN NUMBER
            IS
        tax number := 0.05
        BEGIN
            return( ROUND( sal -( sal * tax )));
        END;
/

PROCEDURE pro_emp( in_empno IN EMP.EMPNO%TYPE )
    IS
        OUT_ENAME EMP.ENAME%TYPE;
        OUT_SAL EMP.SAL%TYPE;
    BEGIN
        SELECT ENAME, SAL INTO OUT_ename, out_sal
            FROM EMP
            WHERE EMPNO = in_empno;
        
    
        DBMS_OUTPUT.put_LINE( ' ENAME: ' || OUT_ENAME );
        DBMS_OUTPUT.PUT_LINE( ' SAL: ' || OUT_SAL );
    END;
  /  
    

PROCEDURE pro_dept( in_deptno IN EMP.deptno%TYPE )
    IS
        OUT_dname dept.dname%TYPE;
        OUT_loc dept.loc%TYPE;
    BEGIN
        SELECT dNAME, Loc INTO OUT_dname, out_loc
            FROM dept
            WHERE deptNO = in_deptno;
        
    
        DBMS_OUTPUT.put_LINE( ' dNAME: ' || OUT_dNAME );
        DBMS_OUTPUT.PUT_LINE( ' LOC: ' || OUT_Loc );
    END;
    
    
-- 서브 프로그램 오버로딩

CREATE OR REPLACE PACKAGE pkg_overload
IS
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
    PROCEDURE pro_emp(in_ename IN EMP.ENAME%TYPE);
END;


CREATE OR REPLACE PACKAGE BODY pkg_overload
IS
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
        IS
            out_ename EMP.ENAME%TYPE;
            out_sal EMP.SAL%TYPE;
        BEGIN
            SELECT ENAME, SAL INTO out_ename, out_sal
                FROM EMP
            WHERE EMPNO = in_empno;
            
        DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
        DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
    END pro_emp;


    PROCEDURE pro_emp(in_ename IN EMP.ENAME%TYPE)
        IS
            out_ename EMP.ENAME%TYPE;
            out_sal EMP.SAL%TYPE;
        BEGIN
            SELECT ENAME, SAL INTO out_ename, out_sal
            FROM EMP
            WHERE ENAME = in_ename;

                DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
                DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
                END pro_emp;
 END;
 /
 
BEGIN
    DBMS_OUTPUT.PUT_LINE('--pkg_example.func_aftertax(3000)--');
    DBMS_OUTPUT.PUT_LINE('after-tax:' || pkg_example.func_aftertax(3000));
    
    DBMS_OUTPUT.PUT_LINE('--pkg_example.pro_emp(7369)--');
    pkg_example.pro_emp(7369);
    
    DBMS_OUTPUT.PUT_LINE('--pkg_example.pro_dept(10)--' );
    pkg_example.pro_dept(10);
    
    DBMS_OUTPUT.PUT_LINE('--pkg_overload.pro_emp(7369)--' );
    pkg_overload.pro_emp(7369);
    
    DBMS_OUTPUT.PUT_LINE('--pkg_overload.pro_emp(‘’SMITH'')--' );
    pkg_overload.pro_emp('SMITH');
    
    END;
END;
/




-- 트리거

-- 비포어 트리거
SELECT * FROM EMP_TRG;

CREATE TABLE EMP_TRG
    AS SELECT * FROM EMP;
    
CREATE OR REPLACE TRIGGER trg_emp_nodml_weekend
    BEFORE
    INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
    IF TO_CHAR( SYSDATE, 'DY' ) IN( '토', '화' ) THEN
        IF INSERTING THEN
            raise_application_error( -20000, ' 주말 사원 정보 추가 불가 ' );
        ELSIF UPDATING THEN
            raise_application_error( -20001, ' 주말 사원 정보 수정 불가 ' );
        ELSIF DELETING THEN
            raise_application_error( -20002, ' 주말 사원 정보 삭제 불가 ' );
        ELSE
            raise_application_error( -20003, ' 주말 사원 정보 변경 불가 ' );
        END IF;
    END IF;
END;
/
SELECT * FROM EMP_TRG;
SELECT * FROM USER_TRIGGERs;

UPDATE emp_trg SET sal = 3500 WHERE EMPNO = 7369;

INSERT INTO emp_trg 
    VALUES( 7777, 'NAME', 'SINGER', 8888, TO_DATE( '2000/12/31', 'YYYY/MM/DD' ), 9999, NULL, 30 );

DELETE emp_trg WHERE EMPNO = 7777;
rollback
/
-- 애프터 트리거

DROP TABLE EMP_TRG_LOG;

CREATE TABLE EMP_TRG_LOG(
    TABLENAME       VARCHAR2(10), -- DML이 수행된 테이블 이름
    DML_TYPE        VARCHAR2(10), -- DML 명령어의 종류
    EMPNO           NUMBER(4), -- DML 대상이 된 사원 번호
    USER_NAME       VARCHAR2(30), -- DML을 수행한 USER 이름
    CHANGE_DATE     DATE ); -- DML이 수행된 날짜

DESC EMP_TRG_LOG;
DESC EMP;
/
    
CREATE OR REPLACE TRIGGER trg_emp_log
AFTER
    INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW

BEGIN
    
    IF INSERTING THEN
        INSERT INTO emp_trg_log
        VALUES( 'EMP_TRG', 'INSERT', :new.empno, SYS_CONTEXT( 'USERENV', 'SESSION_USER'), SYSDATE); -- 현재 DB에 접속 중인 사용자
    
    ELSIF UPDATING THEN
        INSERT INTO emp_trg_log
        VALUES( 'EMP_TRG', 'UPDATE', :old.empno, SYS_CONTEXT( 'USERENV', 'SESSION_USER'), sysdate); 
        
    ELSIF DELETING THEN
        INSERT INTO emp_trg_log
        VALUES( 'EMP_TRG', 'DELETE', :old.empno, SYS_CONTEXT( 'USERENV', 'SESSION_USER'), sysdate);
        
    END IF;
END;
/

-- 인서트

SELECT * FROM USER_TRIGGERS;
SELECT * FROM EMP_TRG;

ALTER TRIGGER TRG_EMP_NODML_WEEKEND DISABLE;

INSERT INTO EMP_TRG
    VALUES( 7777, 'NAME', 'SINGER', 8888, TO_DATE( '2000/12/31', 'YYYY/MM/DD' ), 9999, NULL, 30 );
    
COMMIT;

SELECT * FROM EMP_trg_log;

-- 업데이트

UPDATE EMP_TRG
SET sal = 1300
WHERE empno = 7777;

rollback;


-- 트리거 정보 조회

SELECT * FROM USER_TRIGGERS WHERE TABLE_NAME = 'EMP_TRG';

ALTER TABLE EMP_TRG DISABLE ALL TRIGGERS;
ALTER TABLE EMP_TRG ENABLE ALL TRIGGERS;

ALTER TRIGGER TRG_EMP_NODML_WEEKEND DISABLE;

-- DROP TRIGGER TRG_EMP_NODML_WEEKEND