USE employee_management;
/*
SELECT 문 해석 순서
5 : SELECT 컬럼명 AS 별칭, 계산식, 함수식
1 : FROM 참조할 테이블명
2 : WHERE 컬럼명 | 함수식 비교연산자 비교값
3 : GROUP BY 그룹을 묶을 컬럼명
4 : HAVING 그룹함수식 비교연산자 비교값
6 : ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식[NULLS FIRST | LAST];
*/

SELECT *
FROM employees;

-- employees 테이블에서
-- 부서별 보너스를 받는 서원 수 조회
SELECT dept_id, COUNT(*)
FROM employees
GROUP BY dept_id;

-- employees 테이블에서 부서별로 보너스를 주고싶음
-- 보너스를 주는 조건은 연봉 60000000 이상인 사원만 보너스 제공
-- 보너스를 받는 사원 수 부서별로 조회
SELECT dept_id, COUNT(*)
FROM employees
WHERE salary > 60000000
GROUP BY dept_id;

-- employees 테이블에서
-- 부서 ID, 부서별 급여의 합계 as 급여 합계 
-- 부서 별 급여의 평균(정수 처리 - 내림 처리) as 급여 평균 
-- 인원 수 조회 as 인원 수
-- 부서 ID 순으로 오름차준 정렬
SELECT dept_id AS "부서아이디", COUNT(*) AS "인원수" , SUM(salary) AS "급여 합계" , FLOOR(AVG(salary)) AS "급여 평균"
FROM employees
GROUP BY `부서아이디`
ORDER BY `부서아이디`;

-- 부서ID가 4, 5인 부서의 평균 급여조회  WHERE IN()
-- SELECT dept_id, floor(avg(salary))
SELECT dept_id, floor(avg(salary))
FROM employees
WHERE dept_id IN(4, 5)
GROUP BY dept_id;

-- employees 테이블에서 직급 별 2020년도 이후 입사자들의 급여 합 조회
-- position_id, YEAR(hire_date) salary
-- SELECT FROM WHERE GROUP BY
SELECT position_id AS "직급", SUM(salary) AS "급여합"
FROM employees
WHERE hire_date >= 2020
GROUP BY position_id;

/*
GROUP BY 사용시 주의사항
SELECT 문에 GROUP BY 절을 사용할 경우
SELECT 절에 명시한 조회하려는 컬럼 중
그룹함수가 적용되지 않은 컬럼은
모두 다 GROUP BY 절에 작성해야함
*/

SELECT *
FROM employees;

-- employees 테이블에서 부서 별로 같은 직급인 사원의 급여 합계를 조회하고
-- 부서 ID 오름차순으로 정렬
SELECT position_id AS "직급", SUM(salary) AS "급여합"
FROM employees
GROUP BY position_id
ORDER BY dept_id;

/**
0	127	16:29:32	SELECT position_id AS "직급", SUM(salary) AS "급여합"
 FROM employees
 GROUP BY position_id
 ORDER BY dept_id
 LIMIT 0, 1000	Error Code: 1055. Expression #1 of ORDER BY clause is not in GROUP BY clause and contains nonaggregated column 'employee_management.employees.dept_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.000 sec
**/

SELECT *
FROM employees;
-- 1. employees 테이블에서 부서 별로 직급이 같은 직원의 수를 조회하고
-- 부서 ID, 직급 ID 오름차순으로 정렬
SELECT dept_id, position_id, COUNT(*)
FROM employees
GROUP BY dept_id, position_id
ORDER BY dept_id, position_id;

/*
GROUP BY dept_id, position_id
dept_id 와 position_id의 조합을 기준으로 데이터를 묶는다
예)
	부서 10, 직위 1
    부서 10, 직위 2
    부서 20, 직위 1
    등등 ...alter각 조합마다 COUNT(*)로 몇 명의 직원이 존재하는지 계산하겠다
ORDER BY dept_id, position_id
	계산한 결과를
    부서 ID -> 직위 ID 순서로 오름차순 정렬
    부서로 정렬된 뒤, 그 안에서 직위별로 정렬
*/


-- 2. 부서별 평균 급여를 조회하고
-- 부서를 조회하여 부서 ID 오름차순으로 정렬
SELECT dept_id, AVG(salary)
FROM employees
GROUP BY dept_id
ORDER BY dept_id;


/***************************
WHERE 절 : 지정된 테이블에서 어떤 행만을 조회 결과로 삼을건지 조건을 지정하는 구문
		  (테이블 내에 특정 행만 뽑아서 쓰겠다는 조건문)
		
HAVING 절 : 그룹함수로 구해 올 그룹에 대한 조건을 설정할 때 사용
		   (그룹에 대한 조건, 어떤 그룹만 조회하겠다)
           
HAVING 컬럼명 | 함수식 비교연산자 비교값
***************************/

SELECT * FROM employees;
-- 직원이 2명 이상인 부서보기
SELECT dept_id, COUNT(*)
FROM employees
WHERE count(*) >= 2; -- Error Code: 1111. Invalid use of group function	0.000 sec
-- 그룹 함수를 잘못 사용했을 때 나타나는 문제


SELECT dept_id, COUNT(*)
FROM employees
GROUP BY dept_id
HAVING count(*) >= 2; 


/*
WHERE : 개별 직원 조건
급여가 5천만원 이상인 직원 찾기
WHERE salary >= 50000000

HAVING : 부서나 그룹 조건
평균 급여가 5천만원 이상인 "부서" 찾기
HAVING AVG(salary) >= 50000000

GROUP BY HAVING = 함수(COUNT, AVG, SUM, MIN, MAX 등) 특정 그룹의 숫자 데이터를 활용해서 조건별로 조회할 때 사용

*/

-- 평균 급여가 70000000만원 이상인 부서 조회
-- dept_id, salary, employees
SELECT dept_id, FLOOR(AVG(salary)) 
FROM employees
GROUP BY dept_id
HAVING AVG(salary) >= 70000000;

-- 급여 총합이 1억 5천만원 이상인 부서 조회
SELECT dept_id, SUM(salary) 
FROM employees
GROUP BY dept_id
HAVING SUM(salary) >= 150000000;


SELECT * 
FROM departments;
-- WHERE DEPT_ID
-- employees E departments D 연결
-- 평균 급여가 8천만원 이상인 부서 이름 조회
SELECT D.dept_name, AVG(E.salary)
FROM employees E, departments D
WHERE E.dept_id = D.dept_id
GROUP BY D.dept_name
HAVING AVG(E.salary) >= 80000000;


/*****************************************
수업용_SCRIPT_2를 활용하여 GROUP BY HAVING 실습하기
기본 문법 순서
SELECT 컬럼명, 집계함수()
FROM 테이블이름
WHERE 조건 -- 개별 행 하나씩에 대한 조건
GROUP BY 컬럼명 -- 그룹 만들기 (SELECT ORDER에서 집계 함수로 작성되지 않은 컬럼명칭 모두 작성)
HAVING 집계 조건 -- 조회할 그룹에 대한 조건 
ORDER BY -- 정렬 기준
* 주의할 점 : 숫자값에 NULL이 존재한다면 WHERE 로 NULL을 먼저 필터링 처리
WHERE 컬럼이름 IS NOT NULL
과 같이 NULL이 존재하지 않는 데이터들을 통해서 조회
--------------------------------

집계함수
COUN(*) : 개수 세기
AVG() : 합에 대한 평균
MAX() : 최고로 높은 숫자
MIN() : 최고로 낮은 숫자

테이블 구조
stores(가게 테이블)
가게번호, 가게명, 카테고리,   평점,     배달비
id    , name category, rating, delivery_fee

menus(메뉴 테이블)
메뉴번호, 가게번호,  메뉴명   가격,  인기메뉴여부
id   , store_id  name  price  is_popular
*****************************************/
USE deliver_app;

SELECT *
FROM stores;
-- stores 테이블에서
-- 각 카테고리 별로 가게가 몇개씩 존재하는지 확인하기
-- select category  as 가게수
SELECT category, count(*) AS "가게수"
FROM stores
GROUP BY category
ORDER BY COUNT(*) DESC; -- COUNT(*) 내림차순 정렬

-- stores 테이블에서
-- 각 카테고리별 평균 배달비 구하기
-- null 존재하는지 확인하고, null이 아닌 배달비만 조회
SELECT category, AVG(delivery_fee)
FROM stores
WHERE delivery_fee IS NOT NULL
GROUP BY category;
