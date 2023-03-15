-- SUM 함수
SELECT * FROM EMP;

SELECT SUM(SAL) FROM EMP;

SELECT SUM(COMM)FROM EMP;

SELECT SUM(DISTINCT SAL),
    SUM(ALL SAL),
    SUM(SAL)
FROM EMP;

SELECT SUM(SAL), SUM(COMM) FROM EMP;



-- COUNT 함수
SELECT COUNT(*) FROM EMP;

SELECT COUNT(*) FROM EMP WHERE DEPTNO = 30;

SELECT COUNT(DISTINCT SAL),
    COUNT(ALL SAL),
    COUNT(SAL)
FROM EMP ;

SELECT COUNT(COMM) FROM EMP;
SELECT * FROM EMP;

SELECT COUNT(COMM) FROM EMP WHERE COMM IS NOT NULL;


-- MAX(최댓값), MIN(최솟값) 함수
SELECT * FROM EMP;
SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 10;

SELECT MIN(SAL) FROM EMP;

SELECT MAX(HIREDATE) FROM EMP WHERE DEPTNO = 20; -- 신입

SELECT MIN(HIREDATE) FROM EMP WHERE DEPTNO = 20; -- 터줏대감

-- AVG(평균값)
SELECT * FROM EMP;
SELECT AVG(DISTINCT SAL) FROM EMP WHERE DEPTNO = 30;

SELECT AVG(COMM) FROM EMP WHERE DEPTNO = 30;

-- GROUP BY
SELECT AVG(SAL), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;

SELECT AVG(SAL), DEPTNO FROM EMP GROUP BY DEPTNO;

SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;               -- 집계함수 사용 시 불가능한 영역을 GROUP BY로 가능

SELECT DEPTNO, AVG(COMM)
    FROM EMP
GROUP BY DEPTNO;

SELECT ENAME, DEPTNO, AVG(SAL)
    FROM EMP
GROUP BY DEPTNO;        -- GROUP BY로 묶어주지 않은 ENAME 때문에 오류

-- HAVING 절 ( GROUP BY랑 무조건 같이 나와야 함 )        ORDER BY는 남발 X 꼭 필요할 때만
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    WHERE SAL <= 3000
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;
    
    
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) > 500
    ORDER BY DEPTNO, JOB;

    
-- ROLLUP, CUBE 함수
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
    
    SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY ROLLUP( DEPTNO, JOB );
    
    SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY CUBE(DEPTNO, JOB)
    ORDER BY DEPTNO, JOB;
    
    SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, ROLLUP(JOB);
    
    SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
    GROUP BY JOB, ROLLUP(DEPTNO);
    
    
-- GROUPING SETS: 지정한 각 열별 그룹화
SELECT DEPTNO, JOB, COUNT(*)
    FROM EMP
    GROUP BY GROUPING SETS( DEPTNO, JOB )
    ORDER BY DEPTNO, JOB;
    

-- GROUPING: ROLLUP, CUBE와 함께 사용 ( 하나 )
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
    GROUPING( DEPTNO ),
    GROUPING( JOB )
    FROM EMP
GROUP BY CUBE ( DEPTNO, JOB )
ORDER BY DEPTNO, JOB;

SELECT DECODE( GROUPING( DEPTNO ), 1, 'ALL_DEPT', DEPTNO ) AS DEPTNO,
    DECODE( GROUPING( JOB ), 1, 'ALL_JOB', JOB ) AS JOB,
    COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
    FROM EMP
GROUP BY CUBE ( DEPTNO, JOB )
ORDER BY DEPTNO, JOB;


-- GROUPING_ID: ROLLUP, CUBE와 함께 사용 ( 여럿 )
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
    GROUPING( DEPTNO ),
    GROUPING( JOB ),
    GROUPING_ID( DEPTNO, JOB )
    FROM EMP
GROUP BY CUBE ( DEPTNO, JOB )
ORDER BY DEPTNO, JOB;


-- LISTAGG: 그룹에 속해있는 데이터를 가로로 나열할 때 사용
SELECT DEPTNO, ENAME
    FROM EMP
    GROUP BY DEPTNO, ENAME;
    
SELECT DEPTNO,
    LISTAGG( ENAME, ', ' )
    WITHIN GROUP( ORDER BY SAL DESC ) AS ENAMES
    FROM EMP
    GROUP BY DEPTNO;
    
    
-- PIVOT, UNPIVOT: 행을 열로, 열을 행으로 바꾸어 출력
SELECT DEPTNO, JOb, MAX(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;
    
SELECT * FROM EMP ;
SELECT * FROM( SELECT DEPTNO, JOB, SAL FROM EMP )
    PIVOT( MAX( SAL ) FOR DEPTNO IN( 10, 20, 30 ))
    ORDER BY JOB;
    
SELECT * FROM( SELECT JOB, DEPTNO, SAL FROM EMP )
    PIVOT( MAX( SAL )
        FOR JOB IN( 'CLERK' AS CLERK,
            'SALESMAN' AS SALESMAN,
            'PRESIDENT' AS PRESIDENT1,
            'MANAGER' AS MANAGER,
            'ANALYST' AS ANALYST))
        ORDER BY DEPTNO;
        
        
SELECT DEPTNO,
    MAX( DECODE( JOB,'CLERK', SAL )) AS CLERK,
    MAX( DECODE( JOB,'SALESMAN', SAL )) AS SALESMAN,
    MAX( DECODE( JOB,'PRESIDENT', SAL )) AS PRESIDENT,
    MAX( DECODE( JOB,'MANAGER', SAL )) AS MANAGER,
    MAX( DECODE( JOB,'ANALYST', SAL )) AS ANALYST
FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO;

    
SELECT * FROM (SELECT DEPTNO,
    MAX( DECODE( JOB,'CLERK', SAL )) AS CLERK,
    MAX( DECODE( JOB,'SALESMAN', SAL )) AS SALESMAN,
    MAX( DECODE( JOB,'PRESIDENT', SAL )) AS PRESIDENT,
    MAX( DECODE( JOB,'MANAGER', SAL )) AS MANAGER,
    MAX( DECODE( JOB,'ANALYST', SAL )) AS ANALYST
FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO )
UNPIVOT(
    SAL FOR JOB IN( CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST ))
    ORDER BY DEPTNO, JOB;