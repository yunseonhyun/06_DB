USE delivery_db;

SELECT *
FROM customers;

SELECT *
FROM stores;

SELECT *
FROM menus;

SELECT *
FROM orders;

-- 문제 1
-- CUSTOMERS 테이블에서 고객명과 이메일 길이를 조회하고, 이메일 길이를 기준으로 내림차순 정렬하시오.
SELECT customer_name, LENGTH(email)
FROM customers
ORDER BY LENGTH(email) DESC;

-- 문제 2
-- STORES 테이블에서 가게명의 길이가 10자 이상인 가게들의 이름과 글자 수를 조회하시오.
SELECT store_name, LENGTH(store_name)
FROM stores
WHERE LENGTH(store_name) >= 10;

-- 문제 3
-- CUSTOMERS 테이블에서 이메일에서 '@' 문자의 위치를 찾아 고객명, 이메일, '@위치'로 조회하시오.
SELECT customer_name AS "고객명", email AS "이메일", LOCATE('@', email) AS "@위치"
FROM customers;

-- 문제 4
-- CUSTOMERS 테이블에서 고객명, 이메일에서 아이디 부분만 추출하여 '이메일 아이디'라는 별칭으로 조회하시오.
SELECT customer_name, SUBSTRING(email, 1, LOCATE('@', email) - 1) AS "이메일 아이디"
FROM customers;

-- 문제 5
-- CUSTOMERS 테이블에서 고객명, 이메일 아이디, 이메일 도메인을 각각 분리하여 조회하시오.
SELECT customer_name, SUBSTRING(email, 1, LOCATE('@', email) - 1) AS "이메일 아이디", SUBSTRING(email,LOCATE('@', email) + 1) AS "이메일 도메인"
FROM customers;

-- 문제 6
-- MENUS 테이블에서 메뉴명에 '치킨'이라는 단어가 포함된 메뉴들을 조회하고, '치킨'을 'Chicken'으로 변경한 결과도 함께 보여주시오.
SELECT menu_name, REPLACE(menu_name, '치킨', 'Chicken')
FROM menus
WHERE menu_name LIKE '%치킨%';

-- 문제 7
-- STORES 테이블에서 가게명에 '점'을 'Store'로 바꾸어 조회하시오. (기존명, 변경명)
SELECT store_name AS "기존명", REPLACE(store_name, '점', 'Store') AS "변경명"
FROM stores;


-- regexp_replace 정규식을 이용해서 특정 명칭 변경 
-- ㅇㅇ$ : ㅇㅇ 단어 마지막으로 조회되는 단어만 변경
-- ^ㅇㅇ : ㅇㅇ 단어를 시작으로 조회되는 단어만 변경
SELECT store_name AS "기존명", regexp_REPLACE(store_name, '점$', 'Store') AS "변경명"
FROM stores;

-- 문제 8
-- MENUS 테이블에서 가격을 1000으로 나눈 나머지를 구하여 메뉴명, 가격, 나머지를 조회하시오.
SELECT menu_name, price, MOD(price, 1000) AS "나머지"
FROM menus;
-- WHERE MOD(price, 1000) != 0 나머지가 0인 값은 모두 제외하고 조회

-- 문제 9 
-- ORDERS 테이블에서 총 가격의 절댓값을 구하여 주문번호, 총가격, 절댓값을 조회하시오.
SELECT order_id, total_price, ABS(total_price)
FROM orders;

-- 문제 10
-- MENUS 테이블에서 가격을 1000으로 나눈 몫을 올림, 내림, 반올림하여 비교해보시오.
SELECT CEIL(price / 1000) AS "올림", FLOOR(price / 1000) AS "내림", ROUND(price / 1000) AS "반올림"
FROM menus;

-- 문제 11
-- STORES 테이블에서 평점을 소수점 첫째 자리까지, 배달비를 백의 자리에서 반올림하여 조회하시오.
SELECT ROUND(rating, 1), ROUND(delivery_fee, -3)
FROM stores;

-- 문제 12
-- MENUS 테이블에서 가격이 10000원 이상인 메뉴들의 가격을 천 원 단위로 반올림하여 조회하시오.
SELECT ROUND(price, -4)
FROM menus
WHERE price >= 10000;

-- 문제 13
-- ORDERS 테이블에서 고객 ID가 짝수인 주문들의 정보를 조회하시오. (MOD 함수 사용)
SELECT *
FROM orders
WHERE MOD(customer_id, 2) = 0;

-- 문제 14///////////////////////////////////////////////////
-- STORES 테이블에서 최소 주문금액을 만 원 단위로 올림하여 조회하시오.
SELECT CEIL(min_order_amount / 10000) * 10000
FROM stores;

-- 문제 15
-- MENUS 테이블에서 인기메뉴 여부를 숫자로 변환하여 조회하시오. (TRUE=1, FALSE=0)
SELECT is_popular
FROM menus;


SELECT *
FROM customers;

SELECT *
FROM stores;

SELECT *
FROM menus;

SELECT *
FROM orders;

-- 문제 16
-- 전체 주문의 총 주문금액 합계를 구하시오.
SELECT SUM(total_price)
FROM orders;

-- 문제 17
-- 배달 완료된 주문들의 평균 주문금액을 구하시오. (소수점 내림 처리)
SELECT FLOOR(AVG(total_price))
FROM orders
WHERE order_status = 'Delivering';

-- 문제 18
-- 가장 비싼 메뉴 가격과 가장 저렴한 메뉴 가격을 조회하시오.
SELECT MAX(price) AS "가장 비싼 메뉴", MIN(price) AS "가장 저렴한 메뉴"
FROM menus;

-- 문제 19
-- 전체 고객 수와 전화번호가 등록된 고객 수를 각각 구하시오.
SELECT COUNT(*)
FROM customers;

SELECT COUNT(*)
FROM customers
WHERE phone IS NOT NULL;

-- 문제 20
-- 카테고리별로 중복을 제거한 가게 수를 조회하시오.
SELECT DISTINCT category_id, COUNT(*)
FROM stores
GROUP BY category_id;

-- 문제 21
-- 가게별로 메뉴 개수와 평균 메뉴 가격을 조회하시오. (가게명 포함)
SELECT S.store_name, COUNT(*), AVG(M.price)
FROM stores S, menus M
WHERE s.store_id = M.store_id
GROUP BY store_name;

-- 문제 22
-- 카테고리별로 가게 수, 평균 평점, 평균 배달비를 조회하시오. (배달비가 NULL이 아닌 경우만)
SELECT category_id, COUNT(*), AVG(rating), AVG(delivery_fee)
FROM stores
WHERE delivery_fee IS NOT NULL
GROUP BY category_id;

-- 문제 23
-- 고객별로 총 주문 횟수와 총 주문금액을 조회하시오. (고객명 포함)
SELECT C.customer_name, COUNT(*), SUM(O.total_price)
FROM customers C, orders O
WHERE C.customer_id = O.customer_id
GROUP BY customer_name;

-- 문제 24
-- 주문 상태별로 주문 건수와 평균 주문금액을 조회하시오.
SELECT order_status, COUNT(*), AVG(total_price)
FROM orders
GROUP BY order_status;

-- 문제 25
-- 가게별 인기메뉴 개수와 일반메뉴 개수를 각각 구하시오.
SELECT 가게테이블.store_name, SUM(메뉴테이블.is_popular) AS "인기메뉴개수", COUNT(*) - SUM(메뉴테이블.is_popular) AS "일반 메뉴"
FROM stores 가게테이블, menus 메뉴테이블
WHERE 가게테이블.store_id = 메뉴테이블.store_id
GROUP BY 가게테이블.store_name;


SELECT *
FROM customers;

SELECT *
FROM stores;

SELECT *
FROM menus;

SELECT *
FROM orders;
-- 문제 26
-- 메뉴가 3개 이상인 가게들의 가게명과 메뉴 개수를 조회하시오.
SELECT S.store_name, COUNT(*)
FROM stores S, menus M
WHERE S.store_id = M.store_id
GROUP BY store_name
HAVING COUNT(*) >= 3;

-- 문제 27
-- 평균 메뉴 가격이 15000원 이상인 가게들을 조회하시오. (가게명, 평균가격)
SELECT S.store_name, AVG(M.price)
FROM stores S, menus M
WHERE S.store_id = M.store_id
GROUP BY store_name
HAVING AVG(M.price) >= 15000;

-- 문제 28
-- 총 주문금액이 30000원 이상인 고객들의 고객명과 총 주문금액을 조회하시오.
SELECT customer_name, SUM(total_price)
FROM customers C, orders O
WHERE C.customer_id = O.customer_id
GROUP BY customer_name
HAVING SUM(total_price) >= 30000;

-- 문제 29
-- 배달비 평균이 3500원 이상인 카테고리들을 조회하시오. (배달비가 NULL이 아닌 경우만)
SELECT category_id, AVG(delivery_fee)
FROM stores
WHERE delivery_fee IS NOT NULL
GROUP BY category_id
HAVING AVG(delivery_fee) >= 3500; 

-- 문제 30
-- 주문 건수가 2건 이상인 주문 상태들과 해당 건수, 총 주문금액을 조회하시오. 총 주문금액 기준으로 내림차순 정렬하시오.
SELECT order_status, COUNT(*), SUM(total_price)
FROM orders
GROUP BY order_status
