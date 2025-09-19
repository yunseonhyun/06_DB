/***************************
SUBQUERY(서브쿼리)
하나의 SQL문 안에 포함된 또다른 SQL문
메인쿼리(기존쿼리)를 위해 보조 역할을 하는 쿼리문
- SELECT, FROM, WHERE, HAVING 절에서 사용 가능
***************************/

USE delivery_app;
SELECT *  FROM stores;
SELECT *  FROM menus;

-- ======================
-- 1번 기본 서브쿼리(단일행)
-- ======================
-- 가장 비싼 메뉴 찾기
-- 1단계 : 최고 가격 찾기
SELECT MAX(price) FROM menus; -- 38900원

-- 2단계 : 그 가격인 메뉴 찾기
SELECT name, price
FROM menus
WHERE price = 38900;

-- 1단계 2단계를 조합해서 한 번에 비싼 메뉴 찾기를 진행 해 보자
SELECT name, price
FROM menus
WHERE price = (SELECT MAX(price) FROM menus);

-- 1단계 : 평균 메뉴들의 가격 조회 
SELECT AVG(price) FROM menus;

-- 2단계 : 그 가격인 메뉴 찾기 
SELECT name
FROM menus
WHERE price > 15221;

-- 1단계 2단계를 조합해서 평균보다 비싼 메뉴들만 조회
SELECT name, price
FROM menus
WHERE price > (SELECT AVG(price) FROM menus);
-- WHERE 절에 price를 기준으로 평균보다 비싼 메뉴들만 조회하는 조건


-- 평점이 가장 높은 매장 찾기
-- 1단계 : 최고 평점 찾기
SELECT MAX(rating) FROM stores;

-- 2간계 : 최고 평점인 매장 찾기
SELECT *
FROM stores
WHERE rating = 4.9;

-- 1단계 2단계를 조합하여 한 번에 평점 최고인 매장을 조회
SELECT *
FROM stores
WHERE rating = (SELECT MAX(rating) FROM stores);

-- 배달비가 가장 비싼 매장 찾기 stores
-- 1단계 : 가게에서 최고로 비싼 배달비를 가격을 조회
SELECT MAX(delivery_fee) FROM stores;

-- 2단계 : 가격이 최고로 비싼 배달비의 매장 명칭과 배달비, 카테고리 조회
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee = 5500;

-- 1단계 2단계를 조합하여 한번에 가장 비싼 배달비 가격을 조회하고, 매장의 명칭, 배달비, 카테고리 조회
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee = (SELECT MAX(delivery_fee) FROM stores);

/***********************************************
	   단일행 서브쿼리 실습문제 (1 ~ 10 문제)
***********************************************/
SELECT *  FROM stores;
SELECT *  FROM menus;

-- 문제1: 가장 싼 메뉴 찾기
-- 1단계: 최저 가격 찾기
SELECT MIN(price) 
FROM menus;
-- 2단계: 그 가격인 메뉴 찾기 (메뉴명, 가격)
SELECT name, price
FROM menus
where price = 1500;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, price
FROM menus
where price = (SELECT MIN(price) FROM menus);

-- 문제2: 평점이 가장 낮은 매장 찾기 (NULL 제외)
-- 1단계: 최저 평점 찾기
SELECT MIN(rating)
FROM stores;

-- 2단계: 그 평점인 매장 찾기 (매장명, 평점, 카테고리)
SELECT name, rating, category
FROM stores
WHERE rating = 4.2;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, category
FROM stores
WHERE rating = (SELECT MIN(rating) FROM stores);

-- 문제3: 배달비가 가장 저렴한 매장 찾기 (NULL 제외)
-- 1단계: 최저 배달비 찾기
SELECT MIN(delivery_fee)
FROM stores
WHERE delivery_fee IS NOT NULL;

-- 2단계: 그 배달비인 매장들 찾기 (매장명, 배달비, 주소)
SELECT name, delivery_fee, address
FROM stores
WHERE delivery_fee = 2000; 

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee, address
FROM stores
WHERE delivery_fee = (SELECT MIN(delivery_fee) FROM stores WHERE delivery_fee IS NOT NULL);

-- 문제4: 평균 평점보다 높은 매장들 찾기
-- 1단계: 전체 매장 평균 평점 구하기
SELECT AVG(rating)
FROM stores;

-- 2단계: 평균보다 높은 평점의 매장들 찾기 (매장명, 평점, 카테고리)
SELECT name, rating, category
FROM stores
WHERE rating > 4.66545;
  
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, category
FROM stores
WHERE rating > (SELECT AVG(rating)FROM stores);

-- 문제5: 평균 배달비보다 저렴한 매장들 찾기 (NULL 제외)
-- 1단계: 전체 매장 평균 배달비 구하기
SELECT AVG(delivery_fee)
FROM stores;

-- 2단계: 평균보다 저렴한 배달비의 매장들 찾기 (매장명, 배달비, 카테고리)
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee < 3179.2453;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee < (SELECT AVG(delivery_fee) FROM stores);


SELECT *  FROM stores;
SELECT *  FROM menus;


-- 문제6: 치킨집 중에서 평점이 가장 높은 곳
-- 1단계: 치킨집들의 최고 평점 찾기
SELECT MAX(rating)
FROM stores
WHERE category = "치킨";

-- 2단계: 치킨집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
SELECT name, rating, address
FROM stores
WHERE category = "치킨" AND rating = 4.9;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, address
FROM stores
WHERE category = "치킨"AND
 rating = (SELECT MAX(rating)
FROM stores
WHERE category = "치킨");

-- 문제7: 치킨집 중에서 배달비가 가장 저렴한 곳 (NULL 제외)
-- 1단계: 치킨집들의 최저 배달비 찾기
SELECT MIN(delivery_fee)
FROM stores
WHERE category = "치킨" AND delivery_fee IS NOT NULL;

-- 2단계: 치킨집 중 그 배달비인 매장 찾기 (매장명, 배달비)
SELECT name, delivery_fee
FROM stores
WHERE category = "치킨" AND delivery_fee = 2000;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee
FROM stores
WHERE category = "치킨" AND delivery_fee = (SELECT MIN(delivery_fee)
FROM stores
WHERE category = "치킨"  AND delivery_fee IS NOT NULL);

-- 문제8: 중식집 중에서 평점이 가장 높은 곳
-- 1단계: 중식집들의 최고 평점 찾기
SELECT MAX(rating)
FROM stores
WHERE category = "중식";

-- 2단계: 중식집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
SELECT name, rating, address
FROM stores
WHERE category = "중식" AND rating = 4.7;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, address
FROM stores
WHERE category = "중식" AND rating = (SELECT MAX(rating)
FROM stores
WHERE category = "중식");

-- 문제9: 피자집들의 평균 평점보다 높은 치킨집들
-- 1단계: 피자집들의 평균 평점 구하기
SELECT AVG(rating)
FROM stores
WHERE category = "피자";

-- 2단계: 그보다 높은 평점의 치킨집들 찾기 (매장명, 평점)
SELECT name, rating
FROM stores
WHERE category = "치킨" AND rating > 4.7;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating
FROM stores
WHERE category = "치킨" AND rating > (SELECT AVG(rating)
FROM stores
WHERE category = "피자");

-- 문제10: 한식집들의 평균 배달비보다 저렴한 일식집들 (NULL 제외)
-- 1단계: 한식집들의 평균 배달비 구하기
SELECT AVG(delivery_fee)
FROM stores
WHERE category = "한식";

-- 2단계: 그보다 저렴한 배달비의 일식집들 찾기 (매장명, 배달비)
SELECT name, delivery_fee
FROM stores
WHERE category = "일식" AND delivery_fee < 3200;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee
FROM stores
WHERE category = "일식" AND delivery_fee < (SELECT AVG(delivery_fee)
FROM stores
WHERE category = "한식");







-- ======================
-- 1번 다중행 서브쿼리(MULTI ROW SUBQUERY) N행 1열 
-- IN / NOT IN, > ANY / < ANY, > ALL < ALL, EXISTS / MOT EXISTS 사용
-- 주요 연산자 : IN, NOT IN , ANY, ALL, EXISTS
-- ======================
SELECT *  FROM stores;
SELECT *  FROM menus;

-- 1. IN 연산자 - 가장 많이 사용되는 다중행 서브쿼리

-- 인기 메뉴가 있는 매장들 조회

-- 1단계 : 인기 메뉴가 있는 매장 ID들 확인
SELECT DISTINCT store_id
FROM menus
WHERE is_popular = TRUE;

-- 2단계 : 인기있는 매장 id들에 해당하는 매장 정보 찾기
SELECT s.name, s.category, s.rating
FROM stores s, menus m
WHERE s.id = m.store_id AND s.id IN (SELECT DISTINCT store_id
FROM menus
WHERE is_popular = TRUE);


-- 2. NOT IN 연산자 - 
-- 인기 메뉴가 없는 매장들 조회
-- name, category, rating 
-- 1단계 인기메뉴가 있는 메장들 id 확인
SELECT DISTINCT store_id
FROM menus
WHERE is_popular = TRUE;
-- 2단계 1단계를 조합하여 그 id에 해당하지 않는 매장들 가져오기
SELECT name, category, rating
FROM stores
WHERE id NOT IN (SELECT DISTINCT store_id
FROM menus
WHERE is_popular = TRUE);

-- 치킨, 피자, 카테고리 매장들만 조회
-- 1단계 : 치킨, 피자 카테고리 중복없이 확인
SELECT DISTINCT name, category, rating
FROM stores
WHERE category IN ('치킨', '피자')
ORDER BY category;

-- 2단계 : WHERE category = '치킨' OR category = '피자' 이용해서 출력
SELECT DISTINCT name, category, rating
FROM stores
WHERE category = '치킨' OR category = '피자';
-- 1 + 2 조합하여 가게이름, 카테고리, 평점 조회
SELECT name, category, rating
FROM stores
WHERE category IN (SELECT DISTINCT category
FROM stores
WHERE category = '치킨' OR category = '피자');
-- IN 사용
-- FROM stores 



-- 20000원 이상 메뉴를 파는 매장들 조회

-- 1단계 : 20000원 이상 메뉴를 가진 매장 id 들 확인
SELECT DISTINCT store_id
FROM menus
WHERE price >= 20000;

-- 2단계 : 1단계 결과를 조합하여 해당 매장들에 대한 정보 가져오기
-- name, category, rating
-- name순으로 오름차순 정렬
SELECT name, category, rating
FROM stores
WHERE id IN (SELECT DISTINCT store_id FROM menus WHERE price >= 20000)
ORDER BY name;


-- *********************************************
/**********************************************************
           다중행 서브쿼리 실습문제 (1 ~ 10 문제)
           IN / NOT IN 연산자
***********************************************************/
SELECT *  FROM stores;
SELECT *  FROM menus;
-- 문제 1: 카테고리별 최고 평점 매장들 조회
-- 1단계: 카테고리별 최고 평점들 확인
-- GROUP BY category
SELECT MAX(rating)
FROM stores
GROUP BY category; -- 카테고리별 가장 높은 평점만 조회

SELECT category
FROM stores
GROUP BY category; -- SUM에 대한 결과인지, 평점인지, 가격을 합친건지, 나눈 것인지 카테고리별로 무엇을 했는지 알 수 없음
-- 문제에서 평점을 기준으로 가게 데이터를 조회하려 하기 때문에 
-- 카테고리별로 그룹을 짓고, 그룹별로 최고 평점만 조회하여
-- 평점을 기준으로 가게 데이터 조회

-- 2단계: 1단계 결과를 조합하여 각 카테고리의 최고 평점 매장들 가져오기
SELECT *
FROM stores
where rating IN (SELECT MAX(rating) FROM stores GROUP BY category);


-- 문제 2: 배달비가 가장 저렴한 매장들의 인기 메뉴들 조회
-- 1단계: 가장 저렴한 배달비 매장 ID들 확인
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 인기 메뉴들 가져오기
-- JOIN stores s ON m.store_id = s.id

-- 문제 4: 15000원 이상 메뉴가 없는 매장들 조회
-- 1단계: 15000원 이상 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT store_id
FROM menus
WHERE price >= 15000;
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기
SELECT DISTINCT *
FROM stores 
WHERE id NOT IN (SELECT DISTINCT store_id
FROM menus
WHERE price >= 15000);

-- 문제 5: 메뉴 설명이 있는 메뉴를 파는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT store_id
FROM menus
WHERE description IS NOT NULL;
-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT DISTINCT s.*
FROM stores s, menus m
WHERE s.id = m.store_id AND s.id IN (SELECT DISTINCT store_id
FROM menus
WHERE description IS NOT NULL);

-- 문제 6: 메뉴 설명이 없는 메뉴만 있는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT store_id
FROM menus
WHERE description IS NOT NULL;
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기 (단, 메뉴가 있는 매장만)
SELECT DISTINCT *
FROM stores
WHERE id NOT IN (SELECT DISTINCT store_id
FROM menus
WHERE description IS NOT NULL);

/* 가게이름을 바라보는 name*/
SELECT DISTINCT s.name
FROM stores s, menus m
WHERE s.id = m.store_id AND s.id NOT IN (SELECT DISTINCT store_id
FROM menus
WHERE description IS NOT NULL);

-- 문제 7: 치킨 카테고리 매장들의 메뉴들 조회
-- 1단계: 치킨 카테고리 매장 ID들 확인
SELECT id
FROM stores
WHERE category = "치킨";
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 메뉴들 가져오기
SELECT name
FROM menus 
WHERE store_id IN (SELECT id
FROM stores
WHERE category = "치킨");

SELECT s.name, m.name
FROM menus m, stores s
WHERE m.store_id = s.id AND store_id IN (SELECT id
FROM stores
WHERE category = "치킨");

-- 문제 8: 피자 매장이 아닌 곳의 메뉴들만 조회
-- 1단계: 피자 매장 ID들 확인
SELECT id
FROM stores
WHERE category = "피자";
-- 2단계: 1단계 결과에 해당하지 않는 매장들의 메뉴들 가져오기
SELECT s.name, m.name
FROM menus m, stores s
WHERE m.store_id = s.id AND store_id NOT IN (SELECT id
FROM stores
WHERE category = "피자"); 


SELECT *  FROM stores;
SELECT *  FROM menus;

-- 문제 9: 평균 가격보다 비싼 메뉴를 파는 매장들 조회
-- 0단계 : 메뉴들의 평균 가격 조회
SELECT AVG(price) FROM menus; -- 15221.4286
-- 1단계: 평균 가격보다 비싼 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT store_id
FROM menus
WHERE price > 15221.4286;
-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT * 
FROM stores
WHERE id IN (SELECT DISTINCT store_id
FROM menus
WHERE price > (SELECT AVG(price) FROM menus));

-- 문제 10: 가장 비싼 메뉴를 파는 매장들 조회
-- 1단계: 가장 비싼 메뉴를 가진 매장 ID들 확인
SELECT MAX(price)
FROM menus;
-- 2단계: 1단계 결과를 조합하여 해당 매장과 메뉴 정보 가져오기
SELECT store_id
FROM menus
WHERE price = 38900;

-- 가게 아이디, 메뉴이름, 메뉴 가격
SELECT stores.name, menus.price
FROM menus, stores
WHERE menus.store_id = stores.id AND price = (SELECT MAX(price)
FROM menus);

SELECT stores.name, menus.price
FROM menus, stores
WHERE menus.store_id = stores.id AND stores.id IN (SELECT store_id FROM menus WHERE price = (SELECT MAX(price) FROM menus));

-- *********************************************


-- 3. ANY 연산자 - 

-- 4. ALL 연산자 - 