-- ��ü ����

SELECT * FROM DICT;


-- USER

SELECT * FROM USER_TABLES; -- SCOTT�� ��� ���̺�

-- ALL

SELECT * FROM ALL_TABLES; -- SCOTT ������ ������ ���� ��� ���̺�

-- DBA ( DB ���� ���� )

SELECT * FROM DBA_TABLES;

-- INDEX

SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;


-- �ε��� ����

CREATE INDEX IDX_EMP_SAL
    ON EMP(SAL);
    
-- �ε��� ����

DROP INDEX IDX_EMP_SAL;

-- �� ���� ( SYSTEM ���� �ʿ� )

SELECT * FROM USER_TABLES;
SELECT * FROM USRE_VIEWS;

--
CREATE VIEW VW_EMP20
    AS( SELECT EMPNO, ENAME, JOB, DEPTNO
        FROM EMP
        WHERE DEPTNO = 20 );
--        
SELECT * FROM VW_EMP20;

SELECT VIEW_NAME, TEXT_LENGTH, TEXT FROM USER_VIEWS;



-- �� ����

DROP VIEW VW_EMP20;



-- �ζ��� �並 ����� TOP-N SQL�� ( ���� ��� )

SELECT ROWNUM, E.* FROM EMP E;  -- ROWNUM ����

SELECT ROWNUM, E.* FROM EMP E   -- ROWNUM, ORDER BY ����
    ORDER BY SAL DESC;
    
SELECT ROWNUM, E.*
    FROM ( SELECT *
            FROM EMP E
            ORDER BY SAL DESC ) E;    -- SAL ���� ��

WITH E AS ( SELECT * FROM EMP ORDER BY  SAL DESC ) -- WITH��
SELECT ROWNUM, E.*
    FROM E
    WHERE ROWNUM < 3;

SELECT ROWNUM, E.*
    FROM ( SELECT *
            FROM EMP E
            ORDER BY SAL DESC ) E;    -- SAL ���� ��
            
            
-- ������ ����

CREATE TABLE DEPT_SEQUENCE
    AS SELECT *
         FROM DEPT
         WHERE 1 <> 1;
        
SELECT * FROM DEPT;

SELECT * FROM DEPT_SEQUENCE;

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
    INCREMENT BY 10
    START WITH 10
    MAXVALUE 90
    MINVALUE 0
    NOCYCLE
    CACHE 2;
    
SELECT * FROM USER_SEQUENCES;

-- ������ �Է�

INSERT INTO DEPT_SEQUENCE ( DEPTNO, DNAME, LOC )
    VALUES ( SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL' );
    
SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO;


SELECT SEQ_DEPT_SEQUENCE.CURRVAL FROM DUAL;


-- ������ ����

ALTER SEQUENCE SEQ_DEPT_SEQUENCE
    INCREMENT BY 3
    MAXVALUE 99
    CYCLE;
    
-- ������ ����

DROP SEQUENCE SEQ_DEPT_SEQUENCE;


-- ���Ǿ� ( ��ü �̸� ��� �� �ٸ� ��Ī ), SYSTEM ���� �ʿ�

CREATE SYNONYM E
    FOR EMP;
    
SELECT * FROM E;

DROP SYNONYM E;

