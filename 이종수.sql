DROP TABLE ORDER_TBL;

-- �� ���̺�

CREATE TABLE CUSTOM (
    cID         VARCHAR2( 10 ) , -- �� ���̵�      1
    cName       VARCHAR2( 9 ) CONSTRAINT CUSTOM_CNAME_NN NOT NULL, -- �� �̸�
    AGE         NUMBER( 4 ), -- ����
    GRADE       VARCHAR2( 10 )CONSTRAINT CUSTOM_GRADE_NN NOT NULL, -- ���
    JOB         VARCHAR2( 10 ), -- ����
    POINT       NUMBER( 30 ) DEFAULT '0', -- ������
    
            CONSTRAINT CUSTOM_CID_PK PRIMARY KEY( CID ));            
   
DESC CUSTOM;

INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'APPLE', '����ȭ' , 20, 'GOLD', '�л�', 1000 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'BANANA', '�輱��' , 25, 'VIP', '��ȣ��', 2500 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'CARROT', '���' , 28, 'GOLD', '����', 4500 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'ORANGE', '����' , 22, 'SILVER', '�л�', 0 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'MELON', '������' , 35, 'GOLD', 'ȸ���', 5000 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'PEACH', '������' , NULL, 'SILVER', '�ǻ�', 300 ); 
    
    INSERT INTO CUSTOM (
    cID, cName, AGE, GRADE, JOB, POINT )
    VALUES ( 'PEAR', 'ä����' , 31, 'SILVER', 'ȸ���', 500 ); 
   
SELECT * FROM CUSTOM;
-- DROP TABLE CUSTOM;

-- ��ǰ ���̺�

CREATE TABLE PRODUCT (
    pNum            VARCHAR2( 10 ), -- ��ǰ ��ȣ    2
    pName           VARCHAR2( 20 ), -- ��ǰ �̸�
    pQUANTITY       NUMBER( 10 ), -- ���
    PRICE           NUMBER( 10 ), -- �ܰ�
    COMPANY         VARCHAR2( 20 ), -- ���� ��ü
    
            CONSTRAINT PRODUCT_PNUM_PK PRIMARY KEY( PNUM ),
            CONSTRAINT PRODUCT_pQUANTITY_CK CHECK( PQUANTITY BETWEEN 0 AND 10000 ));

-- DROP TABLE PRODUCT;    
DESC PRODUCT;
SELECT * FROM USER_CONSTRAINTS;

INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p01', '�׳ɸ���', 5000, 4500, '����Ǫ��' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p02', '�ſ��̸�', 2500, 5500, '�α�Ǫ��' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p03', '��������', 3600, 2600, '�Ѻ�����' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p04', '�������ݸ�', 1250, 2500, '�Ѻ�����' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p05', '��ū���', 2200, 1200, '����Ǫ��' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p06', '����쵿', 1000, 1550, '�α�Ǫ��' );
    
    INSERT INTO PRODUCT(
    pNUM, pName, pQUANTITY, PRICE, COMPANY )
    VALUES( 'p07', '���޺�Ŷ', 1650, 1500, '�Ѻ�����' );
    

SELECT * FROM PRODUCT;

-- �ֹ� ���̺�

SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM CUSTOM, PRODUCT, ORDER_TBL10;

CREATE TABLE ORDER_TBL10 (
    oNum            VARCHAR2( 10 ), -- �ֹ� ��ȣ
    oID             VARCHAR2( 10 ), -- �ֹ� ��    1
    oPRODUCT        VARCHAR2( 10 ), -- �ֹ� ��ǰ    2
    QUANTITY        NUMBER( 10 ), -- ����
    ADDRESS1        VARCHAR2( 30 ), -- �����
    ordDate         DATE,    -- �ֹ� ����
    
            CONSTRAINT zxc PRIMARY KEY( ONUM ),
            CONSTRAINT asd FOREIGN KEY( oID )
                REFERENCES CUSTOM( cID ),
            CONSTRAINT qwe FOREIGN KEY( oPRODUCT )
                REFERENCES PRODUCT( pNUM ));

DESC ORDER_TBL10;

 INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o01', 'APPLE', 'p03', 10, '����� ������', TO_DATE( '2019/01/01', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o02', 'MELON', 'p01', 5, '��õ�� ��籸', TO_DATE( '2019/01/10', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o03', 'BANANA', 'p06', 45, '��⵵ ��õ��', TO_DATE( '2019/01/11', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o04', 'CARROT', 'p02', 8, '�λ�� ������', TO_DATE( '2019/02/01', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS, ordDate )
    VALUES( 'o05', 'MELON', 'p06', 36, '��⵵ ���ν�', TO_DATE( '2019/02/20', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o06', 'BANANA', 'p01', 19, '��û�ϵ� ������', TO_DATE( '2019/03/02', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o07', 'APPLE', 'p03', 22, '����� ��������', TO_DATE( '2019/03/15', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o08', 'PEAR', 'p02', 50, '������ ��õ��', TO_DATE( '2019/04/10', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o09', 'BANANA', 'p04', 15, '���󳲵� ������', TO_DATE( '2019/04/11', 'YYYY/MM/DD' ));
    
    INSERT INTO ORDER_TBL10(
    oNUM, oID, oPRODUCT, QUANTITY, ADDRESS1, ordDate )
    VALUES( 'o10', 'CARROT', 'p03', 20, '��⵵ �Ⱦ��', TO_DATE( '2019/05/22', 'YYYY/MM/DD' ));

SELECT * FROM CUSTOM;
SELECT * FROM PRODUCT;
SELECT * FROM ORDER_TBL10;


SELECT ADDRESS FROM ORDER_TBL WHERE oNum = 'o01';



-- ��� ��ü ���̺�

CREATE TABLE B_TBL (
    BNum             VARCHAR2( 10 ), -- ��ü ��ȣ
    BNAME            VARCHAR2( 10 ), --  ��ü��    
    ADRRESS          VARCHAR2( 10 ), -- �ּ�
    asdnumber        VARCHAR2( 20 ), -- ��ȭ��ȣ
   
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