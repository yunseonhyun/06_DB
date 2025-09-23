-- DML (Data Manipulation Language) : 데이터 조작 언어

-- 데이터에 값을 삽입하거나, 수정하거나, 삭제하는 구문

-- 주의 : COMMIT, ROLLBACK 을 실무에서 혼자서 하지 말것 !!!

CREATE TABLE member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    gender ENUM('M', 'F', 'Other'),
    address TEXT,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') DEFAULT 'ACTIVE'
);

SELECT * FROM member;
-- =========================================
-- INSERT 구문
-- INSERT INTO 테이블이름
--		VALUES (데이터, 데이터, 데이터, ...)
-- 모든 컬럼에 대한 값을 넣을 때는 컬럼명칭은 생략하고 순서대로 VALUES에 추가할 데이터 작성
-- =========================================

-- 모든 컬럼에 대한 값 저장(AUTO_INCREMENT 제외)
INSERT INTO member
		VALUES(
        NULL, 				-- member_id (AUTO_INCREMENT 이므로 NULL)
        'hong1234',	   		-- username 닉네임
        'pass1234', 		-- password 비밀번호
        'hong@gmail.com', 	-- email 유저 이메일
        '홍길동',		    	-- name 유저이름
        '010-1234-5678', 	-- phone 핸드폰 번호
        '2000-01-01', 		-- birth_date 생일
        'M', 				-- gender 성별
        '서울시 종로구 관철동',  -- address 주소
        NOW(), 				-- join_date 가입일자 현재시간 기준
        'ACTIVE' 			-- status 탈퇴, 휴면계정 여부
        );
        
-- =============================================
-- 실습 문제 1: 기본 INSERT 구문
-- =============================================
-- 문제: 다음 회원 정보들을 한 번에 INSERT하세요.
/*
회원1: jane_smith, password456, jane@example.com, 김영희, 010-9876-5432, 1992-08-20, F, 부산시 해운대구, 현재시간, ACTIVE
회원2: mike_wilson, password789, mike@example.com, 이철수, 010-5555-7777, 1988-12-03, M, 대구시 중구, 현재시간, ACTIVE  
회원3: sarah_lee, passwordabc, sarah@example.com, 박미영, 010-3333-9999, 1995-03-10, F, 광주시 서구, 현재시간, INACTIVE
*/
INSERT INTO member
		VALUES
        (NULL, 'jane_smith', 'password456', 'hong@gmailexamplecom', '김영희',	'010-9876-5432', '1992-08-20', 'F', '부산시 해운대구', NOW(), 'ACTIVE'),
        (NULL, 'mike_wilson', 'password789', 'mike@example.com', '이철수', '010-5555-7777', '1988-12-03', 'M', '대구시 중구', NOW(), 'ACTIVE' ),
        (NULL, 'sarah_lee', 'passwordabc', 'sarah@example.com', '박미영', '010-3333-9999', '1995-03-10', 'F', '광주시 서구', NOW(), 'INACTIVE');
        

        
-- =========================================
-- INSERT 구문 여러 행을 한 번에 입력
-- INSERT INTO 테이블이름
--		VALUES (데이터1, 데이터1, 데이터1, ...)
--		VALUES (데이터2, 데이터2, 데이터2, ...)
--		VALUES (데이터3, 데이터3, 데이터3, ...)
-- ,로 구분하여 여러 행을 한 번에 입력 후, 데이터를 저장할 수 있다.
-- =========================================

INSERT INTO member
		VALUES
        (NULL, 'mini1004', 'pass5678', 'mini1004@gmail.com', '김미니', '010-6666-7777', '2000-02-02', 'F', '서울시 강남구 역삼동', NOW(), 'ACTIVE'),
        (NULL, 'soo5678', 'pass9999', 'soo1004@gmail.com', '한철수', '010-8888-9999', '2000-03-03', 'M', '서울시 동작구 흑석동', NOW(), 'ACTIVE');
        
        
        
-- =========================================
-- INSERT 필수 컬럼만 입력 -> 모든 컬럼에 데이터를 넣지 않고
-- 컬럼명칭 옆에 NOT NULL 인 컬럼명칭만 지정하여 데이터를 넣을 수 있음
-- 주의할 점 : NOT NULL은 필수로 데이터를 넣어야하는 공간이기 때문에 생략할 수 없음

-- 하나의 INSERT 구문 추가하는 방법
-- INSERT INTO 테이블이름 (필수컬럼명1, 필수컬럼명2, 필수컬럼명3, ...)
--		VALUES (데이터1, 데이터1, 데이터1, ...);

-- 두개 이상의 INSERT 구문 추가하는 방법
-- INSERT INTO 테이블이름(필수컬럼명1, 필수컬럼명2, 필수컬럼명3, ...)
--		VALUES (데이터1, 데이터1, 데이터1, ...),
--		VALUES (데이터2, 데이터2, 데이터2, ...),
--		VALUES (데이터3, 데이터3, 데이터3, ...);
-- ,로 구분하여 여러 행을 한 번에 입력 후, 데이터를 저장할 수 있다.
-- AUTO_INCREMENT 가 설정된 컬럼은 번호가 자동으로 부여될 것이고,
-- 이외 컬럼데이터는 모두 NULL이나 0의 값으로 데이터가 추가될 것이다
-- 여기서 DEFAULT 설정된 데이터는 DEFAULT로 설정된 기본 데이터가 추가될 것이다. 
-- =========================================


-- =============================================
-- 실습 문제 1: 필수 컬럼만 INSERT
-- =============================================
-- 문제: 다음 회원들을 필수 컬럼(username, password, email, name)만으로 INSERT하세요.
-- 나머지 컬럼들은 기본값 또는 NULL이 됩니다.

/*
회원1: user_basic1, basicpass123, basic1@email.com, 기본유저1
회원2: user_basic2, basicpass456, basic2@email.com, 기본유저2  
회원3: user_basic3, basicpass789, basic3@email.com, 기본유저3
*/
INSERT INTO member
		VALUES
        (NULL, 'user_basic1', 'basicpass123', 'basic1@email.com', '기본유저1', NULL, NULL, NULL, NULL, NULL, NULL),
        (NULL, 'user_basic2', 'basicpass456', 'basic2@email.com', '기본유저2', NULL, NULL, NULL, NULL, NULL, NULL),
        (NULL, 'user_basic13', 'basicpass789', 'basic3@email.com', '기본유저3', NULL, NULL, NULL, NULL, NULL, NULL);


-- =============================================
-- INSERT INTO 테이블명 (컬럼명, ...) VALUES(데이터, ...)
-- 특정 컬럼마 지정하여 데이터 저장(필수 + 선택사항)
-- =============================================

INSERT INTO member (username, password, email, name, phone, gender)
			VALUES('admin_user', 'admin_pass', 'admin@gmail.com', '관리자', '010-4689-1357', 'M');

-- =============================================
-- INSERT INTO 로 데이터 저장하는 작업을 할 때
-- 컬럼명칭과 넣고자하는 데이터 일치하면 넣는데 문제가 없음
-- 데이터 일치의 기준은 컬럼명칭에 작성된 자료형, 자료형 크기가 기준
-- =============================================
INSERT INTO member(password, username, email, phone, name, gender)
			VALUES('guest_pass1', 'guest_user1', 'guest1@gmail.com', '게스트1', '010-2222-8888', 'F');
            
INSERT INTO member(password, username, email, phone, name, gender)
			VALUES('guest_pass2', 'guest_user2', 'guest2@gmail.com', '010-2222-8888', '게스트2', 'F');
            

-- =============================================
-- INSERT 실습문제
-- =============================================

-- 문제 1: 다음 회원 정보를 주어진 컬럼 순서에 맞춰 INSERT하세요.
-- 컬럼 순서: password, username, email, name, phone, gender
-- 회원 데이터: hong123, hong_pass, hong@naver.com, 홍길동, 010-1234-5678, M
INSERT INTO member(password, username, email, name, phone, gender)
			VALUES('hong_pass', 'hong123', 'hong@naver.com', '홍길동', '010-1234-5678', 'M');


-- 문제 2: 필수 컬럼 4개를 다른 순서로 INSERT하세요.
-- 컬럼 순서: email, name, password, username  
-- 회원 데이터: kim_student, student123, kim@gmail.com, 김영희
INSERT INTO member(email, name, password, username)
			VALUES('kim@gmail.com', '김영희', 'student123', 'kim_student');


-- 문제 3: 생년월일과 성별을 포함해서 다른 순서로 INSERT하세요
-- 컬럼 순서: birth_date, username, gender, email, name, password
-- 회원 데이터: park_teacher, teacher456, park@daum.net, 박철수, 1985-03-15, M
INSERT INTO member(birth_date, username, gender, email, name, password)
			VALUES('1985-03-15', 'park_teacher', 'M', 'park@daum.net', '박철수', 'teacher456');

-- 문제 4: 주소를 포함해서 컬럼 순서를 바꿔 INSERT하세요.
-- 컬럼 순서: address, phone, birth_date, gender, name, email, password, username
-- 회원 데이터: lee_manager, manager789, lee@company.co.kr, 이미영, F, 1990-07-20, 010-9876-5432, 서울시 강남구 역삼동
INSERT INTO member(address, phone, birth_date, gender, name, email, password, username)
			VALUES('서울시 강남구 역삼동', '010-9876-5432', '1990-07-20', 'F', '이미영', 'lee@company.co.kr', 'manager789', 'lee_manager');

-- 문제 5: 회원 상태를 포함해서 INSERT하세요.
-- 컬럼 순서: status, gender, username, password, email, name, phone
-- 회원 데이터: choi_admin, admin999, choi@admin.kr, 최관리, 010-5555-7777, INACTIVE, M
INSERT INTO member(status, gender, username, password, email, name, phone)
			VALUES('INACTIVE', 'M', 'choi_admin', 'admin999', 'choi@admin.kr', '최관리', '010-5555-7777');

-- 문제 6: 3명의 회원을 각각 다른 컬럼 순서로 한 번에 INSERT하세요.
-- 순서: username, password, email, name, phone, gender
/*
회원1: jung_user1, pass1234, jung1@kakao.com, 정수민, 010-1111-2222, F
회원2: kang_user2, pass5678, kang2@nate.com, 강동원, 010-3333-4444, M  
회원3: yoon_user3, pass9012, yoon3@hanmail.net, 윤서연, 010-5555-6666, F
*/
INSERT INTO member(username, password, email, name, phone, gender)
			VALUES('jung_user1', 'pass1234', 'jung1@kakao.com', '정수민', '010-1111-2222', 'F'),
			('kang_user2', 'pass5678', 'kang2@nate.com', '강동원', '010-3333-4444', 'M'),
			('yoon_user3', 'pass9012', 'yoon3@hanmail.net', '윤서연', '010-5555-6666', 'F');



-- 문제 7: 다음 잘못된 INSERT문을 올바르게 수정하세요.
-- 잘못된 예제 (실행하지 마세요.):
-- INSERT INTO member (username, password, email, name, phone) 
-- VALUES ('010-7777-8888', 'song_user', 'song@lycos.co.kr', 'songpass', '송지효');
INSERT INTO member(phone, username, email, password, name)
			VALUES('010-7777-8888', 'song_user', 'song@lycos.co.kr', 'songpass', '송지효');

-- 문제 8: 전화번호와 주소는 제외하고 다른 순서로 INSERT하세요.
-- 컬럼 순서: gender, birth_date, name, email, username, password
-- 회원 데이터: oh_student, student321, oh@snu.ac.kr, 오수진, 1995-12-03, F
INSERT INTO member(username, password, email, name, birth_date, gender)
			VALUES('oh_student', 'student321', 'oh@snu.ac.kr', '오수진', '1995-12-03', 'F');

-- 문제 9: 모든 컬럼을 포함해서 순서를 바꿔 INSERT하세요.
-- 컬럼 순서: address, status, gender, birth_date, phone, name, email, password, username
-- 회원 데이터: han_ceo, ceo2024, han@bizmail.kr, 한대표, 010-8888-9999, 1975-05-25, M, ACTIVE, 부산시 해운대구 우동
INSERT INTO member(status, birth_date, name, password, address, gender, phone, email, username)
			VALUES('ACTIVE', '1975-05-25', '한대표', 'ceo2024', '부산시 해운대구 우동', 'M', '010-8888-9999', 'han@bizmail.kr', 'han_ceo');

-- 문제 10: 5명의 한국 회원을 서로 다른 컬럼 순서로 INSERT하세요.

/*
회원1: 김민수, minsoo_kim, minpass1, minsoo@gmail.com, 010-1010-2020, M
회원2: 이소영, soyoung_lee, sopass2, soyoung@naver.com, 010-3030-4040, F
회원3: 박준혁, junhyuk_park, junpass3, junhyuk@daum.net, 010-5050-6060, M
회원4: 최유진, yujin_choi, yujinpass4, yujin@hanmail.net, 010-7070-8080, F  
회원5: 장태현, taehyun_jang, taepass5, taehyun@korea.kr, 010-9090-1010, M
*/

/*
-- 회원1 순서: name, username, password, email, phone, gender
INSERT INTO member(name, username, password, email, phone, gender)
			VALUES('김민수', 'minsoo_kim', 'minpass1', 'minsoo@gmail.com', '010-1010-2020', 'M');
            
-- 회원2 순서: username, gender, email, name, password, phone  
INSERT INTO member(name, username, password, email, phone, gender)
			VALUES('이소영', 'soyoung_lee', 'sopass2', 'soyoung@naver.com', '010-3030-4040', 'F');
            
-- 회원3 순서: email, phone, username, password, name, gender
INSERT INTO member(email, phone, username, password, name, gender)
			VALUES('junhyuk@daum.net', '010-5050-6060', 'junhyuk_park', 'junpass3', '박준혁', 'M');
            
-- 회원4 순서: gender, name, phone, email, username, password
INSERT INTO member(gender, name, phone, email, username, password)
			VALUES('F', '최유진', '010-7070-8080', 'yujin@hanmail.net', 'yujin_choi', 'yujinpass4');
            
-- 회원5 순서: phone, email, gender, username, password, name
INSERT INTO member(phone, email, gender, username, password, name)
			VALUES('010-9090-1010', 'taehyun@korea.kr', 'M', 'taehyun_jang', 'taepass5', '장태현');
*/

-- ===========================================
-- UPDATE 이미 존재하는 데이터의 값을 수정(변경)할 때 사용하는 조작 언어
-- UPDATE 테이블이름
-- SET 컬럼명1 = 새롭게 추가할값1,
-- SET 컬럼명2 = 새롭게 수정할값2,
-- ...
-- WHERE 조건;
-- 주의할점 : WHERE절이 없으면 해당 테이블의 모든 데이터가 한 번에 변경되므로 데이터 유실이 발생할 수 있음
-- 모든데이터를 한 번에 변경해야 하는 일이 없으면 WHERE 사용 필수
-- UPDATE는 ERROR가 거의 일어나지 않음
-- 왜냐하면 WHERE에 해당하는 조건을 찾고, 해당하는 조건이 없으면 없는대로..
-- 있으면 있는조건에 맞춰 변경하기 때문
-- ===========================================

-- username 이 hong1234인 홍길동 회원의 핸드폰 번호를 변경
-- WHERE 절을 이용해서 특정 회원 한 명만 정확히 변경하는게 중요!!!

-- UPDATE가 무사히 될 경우 1row 1행 변경 반환
-- 1 row(s) affected Rows matched: 1  Changed: 1  Warnings: 0	0.015 sec
UPDATE member
SET email = 'hong1234@gmail.com',
	address = '인천시 남구'
WHERE 
	username = 'hong1234';
    
    
-- 존재하지 않는 username을 작성해도 에러가 발생하지 않는다
-- 못찾은 상태 그대로 변경된 데이터가 0으로 조회
-- 0 row(s) affected Rows matched: 0  Changed: 0  Warnings: 0	0.000 sec
UPDATE member
SET email = 'hong1234@gmail.com',
	address = '인천시 남구'
WHERE 
	username = 'hong12343333';
    

SELECT * FROM member;

-- 1175 : 모든 데이터를 한 번에 수정하거나 삭제하는 것을 방지하기 위한 MYSQL 안전장치!!
-- 안전모드 비 활성화
SET SQL_SAFE_UPDATES = 0;

UPDATE member
SET join_date = CURRENT_TIMESTAMP();

-- 안전모드 활성화
SET SQL_SAFE_UPDATES = 1;

-- 안전모드는 존재하는 이유가 있음 비활성화 해지 하지 말 것

-- 문제 1: username이 'mike_wilson'인 이철수 회원의 이메일 주소를 'mike.w@naver.com'으로 변경하세요.
UPDATE member
SET email = 'mike.w@naver.com'
WHERE username = 'mike_wilson';

-- 문제 2: member_id가 5번인 회원의 상태(status)를 'SUSPENDED'로, 주소(address)를 '확인 필요'로 변경하세요.
UPDATE member
SET status = 'SUSPENDED',
	address = '확인 필요'
WHERE member_id = 5;

-- 문제 3: 1990년 이전에 태어난 모든 회원의 상태(status)를 'INACTIVE'로 변경하세요.
UPDATE member
SET status = 'INACTIVE'
WHERE birth_date < '1990-12-31';


-- ======================================
-- DELETE
-- 테이블의 행을 삭제하는 구문
-- [작성법]
-- DELETE FROM 테이블명 WHERE 조건설정
-- 만약 WHERE 조건을 설정하지 않으면 모든 행이 다 삭제됨

-- DELETE 작업을 하기 전에 개발자가 잠시 수행하는 작업 중 하나
-- 가볍게 저용량의 테이블을 삭제할 경우 많이 사용

-- 테스트용 테이블 생성 (기존 stores 테이블 복사)
CREATE TABLE stores_copy AS SELECT * FROM stores;
-- 테스트용 테이블 삭제
DROP TABLE stores_copy;
-- ======================================

use delivery_app;
CREATE TABLE stores_copy AS SELECT * FROM stores;
SELECT @sql_mode; -- sql에서 아무런 설정이 되어있지 않는 상태

SELECT * 
FROM stores_copy;

-- member 테이블은 null이 되고, stores_copy null이 안되는 이유
-- member 직접적으로 개발자가 create table부터 모두 작성해서 만든 sql 테이블 형태
-- stores_copy는 만들어진 테이블을 가볍게 복제한 상태 
-- auto_increment와 같은 컬럼 설정과 같이 세세한 특징은 복제 안됨
-- 속성은 추가로 설정해야함
-- 속성까지 모두 복제하겠다
CREATE TABLE stores_copy_2 LIKE stores;
INSERT INTO stores_copy_2 SELECT  * FROM stores;
INSERT INTO stores_copy_2
VALUES(null, '박말숙치킨', '치킨', '서울시 강남구 테스트로 999', '02-999-9999', 4.8, 3000);
SELECT * FROM stores_copy_2;

INSERT INTO stores_copy
-- AUTO INCREMENT NULL 값이 되었는데 오늘은 안되고,
-- default로 설정하니 데이터 저장이 되었다.
VALUES(default, '박말숙치킨', '치킨', '서울시 강남구 테스트로 999', '02-999-9999', 4.8, 3000);
# Error Code: 1048. Column 'id' cannot be null	0.000 sec

SELECT * FROM stores_copy_2;
-- stores_copy_2
SELECT * FROM stores_copy_2
WHERE delivery_fee <= 4000;
-- 배달비가 4000원 이상인 가게들 삭제
DELETE
FROM stores_copy_2
WHERE delivery_fee >= 4000;
-- stores_copy_2에서 배달비가 4000원 이상인 가게들 모두 삭제

-- stores_copy_2에서 평점이 4.5미만이고 카테고리가 치킨인 매장 모두 삭제
DELETE
FROM stores_copy_2
WHERE rating < 4.5 AND category = '치킨'; 
-- 0 row가 뜨면 삭제하는데 문제가 없고, 고객에게 삭제할 데이터가 존재하지 않습니다 전달.
-- 고객 회원 탈퇴 되었있는지 확인 : 성함 + 연락처    성함 + 이메일

-- stores_copy_2에서 전화번호가 NULL인 매장 삭제
DELETE 
FROM stores_copy_2
WHERE phone IS NULL;

-- stores_copy_2 테이블 자체 모두 삭제
DROP TABLE stores_copy;


-- 속성까지 모두 복제하여 store_dev_test라는 명칭으로 테이블 복제하여 생성
-- DELETE FROM store_dev_test WHERE을 이용하여 IN 조건으로 1, 2, 3 ID들 매장 모두 삭제
CREATE TABLE store_dev_test LIKE stores;
INSERT INTO store_dev_test SELECT * FROM stores;
SELECT * FROM store_dev_test;

DELETE
FROM store_dev_test
WHERE id IN(1, 2, 3);

-- DELETE FROM store_dev_test WHERE 이용해서 이름에 치킨이 앞뒤로 포함된 매장 모두 삭제
DELETE
FROM store_dev_test
WHERE name LIKE '%치킨%';

DROP TABLE store_dev_test;