USE delivery_app;

CREATE TABLE USER_TABLE ( 
		USER_NO INT,
		USER_ID VARCHAR(20),
		USER_PWD VARCHAR(30) NOT NULL,  -- NOT NULL은 컬럼 레벨만 가능
		GENDER VARCHAR(10),  
		-- 👇 테이블 레벨 제약조건들 
		CONSTRAINT PK_USER_NO PRIMARY KEY(USER_NO), 
		CONSTRAINT UK_USER_ID UNIQUE(USER_ID), 
		CONSTRAINT CK_GENDER CHECK(GENDER IN ('남', '여')) 
);

CREATE TABLE USER_TABLE ( 
        USER_NO INT PRIMARY KEY,                    -- 컬럼 레벨 PK 
        USER_ID VARCHAR(20) UNIQUE,                 -- 컬럼 레벨 UNIQUE 
        USER_PWD VARCHAR(30) NOT NULL,              -- 컬럼 레벨 NOT NULL 
        GENDER VARCHAR(10) CHECK(GENDER IN ('남', '여')) -- 컬럼 레벨 CHECK 
);

/*
LIBRARY_MEMBER 테이블을 생성하세요.

컬럼 정보:
- MEMBER_NO: 회원번호 (숫자, 기본키)
- MEMBER_NAME: 회원이름 (최대 20자, 필수입력)
- EMAIL: 이메일 (최대 50자, 중복불가)
- PHONE: 전화번호 (최대 15자)
- AGE: 나이 (숫자, 7세 이상 100세 이하만 가능)
- JOIN_DATE: 가입일 (날짜시간, 기본값은 현재시간)

제약조건명 규칙:
- PK: PK_테이블명_컬럼명
- UK: UK_테이블명_컬럼명  
- CK: CK_테이블명_컬럼명
*/

CREATE TABLE LIBRARY_MEMBER (
-- 다른 SQL에서는 컬럼 레벨로 제약조건을 작성할 때 CONSTRAINT 를 이용해서
-- 제약조건의 명칭을 설정할 수 있지만
-- MYSQL은 제약조건 명칭을 MYSQL 자체에서 자동생성 해주기 때문에 명칭 작성을 컬럼레벨에서 할 수 없음
-- 컬럼명칭     자료형(자료형크기)     제약조건           제약조건명칭               제약조건들설정
-- MEMBER_NO       INT      CONSTRAINT    PK_LIBRARY_MEMBER_MEMBER_NO   PRIMARY KEY,

MEMBER_NO INT PRIMARY KEY, -- CONSTRAINT PK_LIBRARY_MEMBER_MEMBER_NO 와 같은 명칭 자동생성됨
MEMBER_NAME VARCHAR(20) NOT NULL,
EMAIL VARCHAR(50) UNIQUE, -- CONSTRAINT UK_LIBRARY_MEMBER_EMAIL 와 같은 제약조건 명칭 자동 생성되고 관리
PHONE VARCHAR(15),
AGE INT CONSTRAINT CK_LIBRARY_MEMBER_AGE CHECK(AGE >= 7 AND AGE <= 100),
JOIN_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*
MEMBER_NO, EMAIL에는 제약조건 명칭 설정이 안되지만 
단순히 PK, UNIQUE, FK, NOT NULL과 같이 한 단어로 키 형태를 작성하는 경우 제약조건 명칭 설정 불가능

AGE에서는 제약조건 명칭이 설정되는 이유
CHECK처럼 제약조건이 상세할 경우에는 제약조건 명칭 설정 가능
CHECK만 개발자가 지정한 제약조건 명칭 설정 가능
*/

-- 우리회사는 이메일을 최대 20글자 작성으로 설정 -> 21글자 유저가 회원가입이 안된다!!! 
INSERT INTO LIBRARY_MEMBER (MEMBER_NO, MEMBER_NAME, EMAIL, PHONE, AGE)
VALUES (1, '김독서', 'kim@email.com', '010-1234-5678', 25);

-- Error Code : 1406. Data too long for column 'EMAIL' at row 1 0.016 sec
-- 컬럼에서 넣을 수 있는 크기에 비해 데이터양이 많을 때 발생하는 문제

-- 방법 1번 : DROP 해서 테이블 새로 생성한다. -> 기존 데이터는..? 회사 폐업 엔딩

-- 방법 2번 : EMAIL 컬럼의 크기 변경 

-- 1. EMAIL 컬럼을 5자에서 50자로 변경
ALTER TABLE LIBRARY_MEMBER
MODIFY EMAIL VARCHAR(50) UNIQUE;
-- ALTER로 컬럼 속성을 변경할 경우 컬럼명칭에 해당하는 정보를 하나 더 만들어놓은 후 해당하는 제약조건 동작
-- ALTER에서 자세한 설명 진행..
/*
ALTER로 컬럼에 해당하는 조건을 수정할 경우
Indexes에 컬럼명_1 컬럼명_2 컬러명_3... 과 같은 형식으로 추가가됨

Indexes
EMAIL
EMAIL_2와 같은 형태로 존재

EMAIL의 경우 제약 조건 VARCHAR(5) UNIQUE,
EMAIL_2 의 경우 제약조건 VARCHAR(50) UNIQUE,

컬럼이름 인덱스들
EMAIL     EMAIL, EMAIL_2 중에서 가장 최근에 생성된 명칭으로 연결
          하지만 새로 생성된 조건들이 마음에 들지 않아 되돌리고 싶은 경우에는
          EMAIL과 같이 기존에 생성한 조건을 인덱스 명칭을 통해 되돌아 설정할 수 있음
          인덱스 = 제약조건명칭 동일
*/

SELECT * FROM LIBRARY_MEMBER;


-- 제약조건 위반 테스트 (에러가 발생해야 정상)
INSERT INTO LIBRARY_MEMBER VALUES (1, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- PK 중복
INSERT INTO LIBRARY_MEMBER VALUES (6, '이나이', 'lee@email.com', '010-7777-6666', 5, DEFAULT); -- 나이 제한 위반

INSERT INTO LIBRARY_MEMBER VALUES (2, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT);

/*
온라인 쇼핑몰의 PRODUCT(상품) 테이블과 ORDER_ITEM(주문상품) 테이블을 생성하세요.

1) PRODUCT 테이블:
- PRODUCT_ID: 상품코드 (문자 10자, 기본키)
- PRODUCT_NAME: 상품명 (문자 100자, 필수입력)
- PRICE: 가격 (숫자, 0보다 큰 값만 가능)
- STOCK: 재고수량 (숫자, 0 이상만 가능, 기본값 0)
- STATUS: 판매상태 ('판매중', '품절', '단종' 중 하나만 가능, 기본값 '판매중')

2) ORDER_ITEM 테이블:
- ORDER_NO: 주문번호 (문자 20자)  
- PRODUCT_ID: 상품코드 (문자 10자)
- QUANTITY: 주문수량 (숫자, 1 이상만 가능)
- ORDER_DATE: 주문일시 (날짜시간, 기본값은 현재시간)

주의사항:
- ORDER_ITEM의 PRODUCT_ID는 PRODUCT 테이블의 PRODUCT_ID를 참조해야 함
- ORDER_ITEM은 (주문번호 + 상품코드) 조합으로 기본키 설정 (복합키)
*/
DROP TABLE PRODUCT;
DROP TABLE ORDER_ITEM;

CREATE TABLE PRODUCT(
PRODUCT_ID VARCHAR(10) PRIMARY KEY, -- AUTO_INCREMENT 정수만 가능 VARCHAR 사용 불가
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRICE INT CONSTRAINT CK_PRODUCT_PRICE CHECK(PRICE > 0),
STOCK INT DEFAULT 0 CHECK(STOCK >= 0), -- constraint 제약조건 제약조건명칭은 필수가 아님 작성 안했을 경우 자동완성
STATUS VARCHAR(20) DEFAULT '판매중' CONSTRAINT CK_PRODUCT_STATUS CHECK(STATUS IN ('판매중', '품절', '단종'))
);

CREATE TABLE ORDER_ITEM(
ORDER_NO VARCHAR(20),
PRODUCT_ID VARCHAR(10),
QUANTITY INT CHECK(QUANTITY >= 1 ),
ORDER_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');

-- CREATE TABLE 할 때 FK(FOREIGN KEY)를 작성하지 않아
-- 존재하지 않는 제품번호의 주문이 들어오는 문제가 발생
-- 제품이 존재하고, 제품번호에 따른 주문
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);

-- 테이블 다시 생성
-- 테이블이 존재하는게 맞다면 삭제하겠어
-- 외래키가 설정되었을 경우 메인 테이블은
-- 메인을 기준으로 연결된 데이터가 자식테이블에 존재할 경우
-- 자식 테이블을 삭제한 후 메인 테이블 삭제할 수 있다.
-- -> ORDER_ITEM 삭제한 후 PRODUCT 테이블을 삭제할 수 있다.
DROP TABLE IF EXISTS PRODUCT;
DROP TABLE IF EXISTS ORDER_ITEM;

-- 메인이 되는 기준이 되는 테이블 생성
CREATE TABLE PRODUCT(
PRODUCT_ID VARCHAR(10) PRIMARY KEY, -- AUTO_INCREMENT 정수만 가능 VARCHAR 사용 불가
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRICE INT CONSTRAINT CK_PRODUCT_PRICE CHECK(PRICE > 0),
STOCK INT DEFAULT 0 CHECK(STOCK >= 0), -- constraint 제약조건 제약조건명칭은 필수가 아님 작성 안했을 경우 자동완성
STATUS VARCHAR(20) DEFAULT '판매중' CONSTRAINT CK_PRODUCT_STATUS CHECK(STATUS IN ('판매중', '품절', '단종'))
);

/*
-- ORDER_ITEM 테이블 안에서 PRODUCT_ID 컬럼은 PRODUCT 테이블 내에 존재하는 컬럼 중 PRODUCT_ID 컬럼명칭과 연결할 것이다.
-- 단순 참조용
-- PRODUCT_ID VARCHAR(10) REFERENCES PRODUCT(PRIDUCT_ID), -- CONSTRAINT 제약조건명칭 자동 생성 
-- 상품이 있어야 주문 가능
-- 외래키를 작성할 때는 반드시 FOREIGN KEY라는 명칭이 필수로 컬럼 레벨이나 테이블 레벨이 무조건 들어가야함
*/

-- ORDER_ITEM에서
-- CONSTRAIN ABC FOREIGN KEY (PRODUCT_ID) REDERENCES PRODUCT(PRODUCT_ID) 테이블 레벨로 존재하는 외래키를
-- 위 내용 참조하여 컬럼 레벨로 설정해서 ORDER_ITEM 테이블 생성
-- 상품이 있어야 주문 가능
-- MYSQL에서 FOREUGN KEY 또한 테이블 컬럼 형태로 작성
CREATE TABLE ORDER_ITEM(
ORDER_NO VARCHAR(20),
PRODUCT_ID VARCHAR(10), 
QUANTITY INT CHECK(QUANTITY >= 1 ),
ORDER_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT ABC FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
/*
-- ORDER_ITEM 테이블 안에서 PRODUCT_ID 컬럼은 PRODUCT 테이블 내에 존재하는 컬럼 중 PRODUCT_ID 컬럼명칭과 연결할 것이다.
-- 단순 참조용
-- PRODUCT_ID VARCHAR(10) REFERENCES PRODUCT(PRIDUCT_ID), -- CONSTRAINT 제약조건명칭 자동 생성 
-- 상품이 있어야 주문 가능
-- 외래키를 작성할 때는 반드시 FOREIGN KEY라는 명칭이 필수로 컬럼 레벨이나 테이블 레벨이 무조건 들어가야함
-- 외래키의 경우에는 보통 테이블 레벨 형태로 작성
-- ORDER_ITEM 테이블내 존재하는 PRODUCT_ID는 PRODUCT테이블에 PRODUCT_ID를 참조할 것이다
-- 라는 조건의 내용을 ABC라는 명칭 내에 저장하겠다 설정
*/

);

INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');

-- CREATE TABLE 할 때 FK(FOREIGN KEY)를 작성하지 않아
-- 존재하지 않는 제품번호의 주문이 들어오는 문제가 발생
-- 제품이 존재하고, 제품번호에 따른 주문
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);
-- PRODUCT 테이블에 존재하지 않은 상품번호로 주문이 들어와 외래키 조건에 위배되는 현상 발생으로 주문 받지 않음
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`delivery_app`.`order_item`, CONSTRAINT `ABC` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PRODUCT_ID`))	0.015 sec




-- YEAR과 같이 SQL에서 사용하는 예약어를 SQL에서는 컬럼명칭으로 사용 가능하나
-- 예약어는 되도록이면 컬럼명칭 사용 지양
CREATE TABLE STUDENT(
STUDENT_ID VARCHAR(10) PRIMARY KEY,
STUDENT_NAME VARCHAR(30) NOT NULL,
MAJOR VARCHAR(50),
YEAR INT CHECK(YEAR >= 1 AND YEAR <= 4), -- CHECK 내에 존재하는 YEAR 컬럼명 YEAR 값 제한
EMAIL VARCHAR(100) UNIQUE
);

CREATE TABLE SUBJECT(
SUBJECT_ID VARCHAR(10) PRIMARY KEY,
SUBJECT_NAME VARCHAR(100) NOT NULL,
CREDIT INT CHECK(CREDIT >= 1 AND CREDIT <= 4)
);

CREATE TABLE SCORE(
STUDENT_ID VARCHAR(10),
SUBJECT_ID VARCHAR(10),
SCORE INT CHECK(SCORE >= 0 AND SCORE <= 100),
SEMESTER VARCHAR(10) NOT NULL,
SCORE_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

-- 외래키
-- 기본 문법
-- 제약조건시작 제약조건명칭 외래키(제약조건을 걸 컬럼명칭)   참조하다   메인테이블(내에 존재하는 컬럼명칭)
-- CONSTRAINT   명칭    FOREIGN KEY(컬럼명칭)    REFERENCES   ~
-- STUDENT 테이블과 SUBJECT 테이블은 SCORE 테이블과 SCORE 테이블 내 데이터가 사라지기 전까지
-- 연결되어 있는 STUDENT 테이블과 SUBJECT 테이블은 삭제할 수 없다.
CONSTRAINT FK_SCORE_STUDENT_ID FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
CONSTRAINT FK_SCORE_SUBJECT_ID FOREIGN KEY (SUBJECT_ID) REFERENCES SUBJECT(SUBJECT_ID),
PRIMARY KEY (STUDENT_ID, SUBJECT_ID, SEMESTER)
);
-- Error Code: 3813. Column check constraint 'score_chk_1' references other column.	0.000 sec
-- SCORE INT CHECK(CREDIT >= 0 AND CREDIT <= 100), --> SCORE 컬럼명 제약조건에서 관련없는 CREDIT명칭을 작성했기 떄문
-- > 같이 수정하면 에러 문제 해결 : SCORE INT CHECK(SCORE >= 0 AND SCORE <= 100)


INSERT INTO STUDENT VALUES ('2024001', '김대학', '컴퓨터공학과', 2, 'kim2024@univ.ac.kr');
INSERT INTO STUDENT VALUES ('2024002', '이공부', '경영학과', 1, 'lee2024@univ.ac.kr');

INSERT INTO SUBJECT VALUES ('CS101', '프로그래밍기초', 3);
INSERT INTO SUBJECT VALUES ('BM201', '경영학원론', 3);
INSERT INTO SUBJECT VALUES ('EN101', '대학영어', 2);

INSERT INTO SCORE VALUES ('2024001', 'CS101', 95, '2024-1학기', DEFAULT);
INSERT INTO SCORE VALUES ('2024001', 'EN101', 88, '2024-1학기', DEFAULT);
INSERT INTO SCORE VALUES ('2024002', 'BM201', 92, '2024-1학기', DEFAULT);

-- 제약조건 위반 테스트
INSERT INTO STUDENT VALUES ('2024003', '박중복', '수학과', 2, 'kim2024@univ.ac.kr');
-- Error Code: 1062. Duplicate entry 'kim2024@univ.ac.kr' for key 'student.EMAIL'	0.031 sec
-- 이메일 중복
INSERT INTO SCORE VALUES ('2024001', 'CS101', 150, '2024-1학기', DEFAULT);
-- Error Code: 3819. Check constraint 'score_chk_1' is violated.	0.000 sec
-- 학번, 과목, 학기 기본키 중복, 점수 제약조건 위반
INSERT INTO SCORE VALUES ('2024001', 'CS101', 90, '2024-1학기', DEFAULT);
-- Error Code: 1062. Duplicate entry '2024001-CS101-2024-1학기' for key 'score.PRIMARY'	0.000 sec
-- 학번, 과목, 학기 기본키 중복