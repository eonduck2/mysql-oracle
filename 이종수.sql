DROP TABLE ORDER_TBL;

-- 고객 테이블

CREATE TABLE CUSTOM (
    cID         VARCHAR2( 10 ) , -- 고객 아이디      1
    cName       VARCHAR2( 9 ) CONSTRAINT CUSTOM_CNAME_NN NOT NULL, -- 고객 이름
    AGE         NUMBER( 4 ), -- 나이
    GRADE       VARCHAR2( 10 )CONSTRAINT CUSTOM_GRADE_NN NOT NULL, -- 등급
    JOB         VARCHAR2( 10 ), -- 직업
    POINT       NUMBER( 30 ) DEFAULT '0', -- 적립금
    
            CONSTRAINT CUSTOM_CID_PK PRIMARY KEY( CID ));            
   
DESC CUSTOM;

INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'APPLE', '정소화' , 20, 'GOLD', '학생', 1000 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'BANANA', '김선우' , 25, 'VIP', '간호사', 2500 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'CARROT', '고명석' , 28, 'GOLD', '교사', 4500 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'ORANGE', '김용욱' , 22, 'SILVER', '학생', 0 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'MELON', '성원용' , 35, 'GOLD', '회사원', 5000 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'PEACH', '오형준' , NULL, 'SILVER', '의사', 300 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'PEAR', '채광주' , 31, 'SILVER', '회사원', 500 ); 
   
SELECT * FROM CUSTOM;
-- DROP TABLE CUSTOM;

-- 제품 테이블

CREATE TABLE PRODUCT (
    pNum            VARCHAR2( 10 ), -- 제품 번호    2
    pName           VARCHAR2( 20 ), -- 제품 이름
    pQUANTITY       NUMBER( 10 ), -- 재고량
    PRICE           NUMBER( 10 ), -- 단가
    COMPANY         VARCHAR2( 20 ), -- 제조 업체
    
            CONSTRAINT PRODUCT_PNUM_PK PRIMARY KEY( PNUM ),
            CONSTRAINT PRODUCT_pQUANTITY_CK CHECK( PQUANTITY BETWEEN 0 AND 10000 ));

-- DROP TABLE PRODUCT;    
DESC PRODUCT;
SELECT * FROM USER_CONSTRAINTS;

INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p01', '그냥만두', 5000, 4500, '대한푸드' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p02', '매운쫄면', 2500, 5500, '민국푸드' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p03', '쿵떡파이', 3600, 2600, '한빛제과' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p04', '맛난초콜릿', 1250, 2500, '한빛제과' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p05', '얼큰라면', 2200, 1200, '대한푸드' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p06', '통통우동', 1000, 1550, '민국푸드' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p07', '달콤비스킷', 1650, 1500, '한빛제과' );
    

SELECT * FROM PRODUCT;

-- 주문 테이블

SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM CUSTOM, PRODUCT, ORDER_TBL10;

CREATE TABLE ORDER_TBL10 (
    oNum            VARCHAR2( 10 ), -- 주문 번호
    oID             VARCHAR2( 10 ), -- 주문 고객    1
    oPRODUCT        VARCHAR2( 10 ), -- 주문 제품    2
    QUANTITY        NUMBER( 10 ), -- 수량
    ADDRESS1        VARCHAR2( 30 ), -- 배송지
    ordDate         DATE,    -- 주문 일자
    
            CONSTRAINT zxc PRIMARY KEY( ONUM ),
            CONSTRAINT asd FOREIGN KEY( oID )
                REFERENCES CUSTOM( cID ),
            CONSTRAINT qwe FOREIGN KEY( oPRODUCT )
                REFERENCES PRODUCT( pNUM ));

DESC ORDER_TBL10;

 INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o01', 'APPLE', 'p03', 10, '서울시 마포구', TO_DATE( '2019/01/01', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o02', 'MELON', 'p01', 5, '인천시 계양구', TO_DATE( '2019/01/10', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o03', 'BANANA', 'p06', 45, '경기도 부천시', TO_DATE( '2019/01/11', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o04', 'CARROT', 'p02', 8, '부산시 금정구', TO_DATE( '2019/02/01', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS, ordDate )
    VALUES( 'o05', 'MELON', 'p06', 36, '경기도 용인시', TO_DATE( '2019/02/20', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o06', 'BANANA', 'p01', 19, '충청북도 보은군', TO_DATE( '2019/03/02', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o07', 'APPLE', 'p03', 22, '서울시 영등포구', TO_DATE( '2019/03/15', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o08', 'PEAR', 'p02', 50, '강원도 춘천시', TO_DATE( '2019/04/10', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o09', 'BANANA', 'p04', 15, '전라남도 목포시', TO_DATE( '2019/04/11', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o10', 'CARROT', 'p03', 20, '경기도 안양시', TO_DATE( '2019/05/22', 'YYYY/MM/DD' ));

SELECT * FROM CUSTOM;
SELECT * FROM PRODUCT;
SELECT * FROM ORDER_TBL10;


SELECT ADDRESS FROM ORDER_TBL WHERE oNum = 'o01';



-- 배송 업체 테이블

CREATE TABLE B_TBL (
    BNum             VARCHAR2( 10 ), -- 업체 번호
    BNAME            VARCHAR2( 10 ), --  업체명    
    ADRRESS          VARCHAR2( 10 ), -- 주소
    asdnumber        VARCHAR2( 20 ), -- 전화번호
   
            CONSTRAINT B_TBL_PK PRIMARY KEY( BNUM ));

desc B_TBL;

-- 7-5
ALTER TABLE CUSTOM ADD BHIREDATE VARCHAR(20);

SELECT * FROM CUSTOM;

-- 7-6
ALTER TABLE CUSTOM DROP COLUMN BHIREDATE;

-- 7-7
ALTER TABLE custom ADD CONSTRAINT alter20years CHECK ( AGE >= 20 );

SELECT * FROM USER_CONSTRAINTS;

-- 7-8
ALTER TABLE custom DROP CONSTRAINT alter20years;

-- 7-9
DROP TABLE B_TBL;

SELECT * FROM USER_TABLES;