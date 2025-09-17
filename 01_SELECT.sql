USE employee_management;
/*
SELECT (조회)
지정된 테이블에서 원하는 데이터를 선택해서 조회하는 SQL

작성법 -1
SELECT 컬럼명, 컬럼명, ...
FROM 테이블명;

작성법 -2 : 테이블 내 모든 컬럼을 선택해서 모든 행, 컬럼 조회
SELECT *
FROM 테이블명;
*/

-- EMPLOYEE 테이블에서 사번, 이름, 이메일 조회
SELECT emp_id, full_name, email
From employees;

SELECT emp_id, full_name, email From employees;
/*
SQL의 경우 예약어 기준으로 세로로 작성하는 경우가 많으며,
세로로 작성하다 작성을 마무리하는 마침표는 반드시 ; 으로 작성
*/

# employee 테이블에서 이름(full_name), 입사일(hiro_date) 만 조회
# ctrl + enter 한줄 코드만 출력
SELECT full_name, hire_date FROM employees;

SELECT * FROM employees;

# Depatments 테이블의 모든 데이터 조회
SELECT * 
FROM departments;

# Departments 테이블에서 부서코드, 부서명 조회 (dept_code, dept_name)
SELECT dept_code, dept_name 
FROM departments;

# Employees 테이블에서 (emp_id, full_name, salary) 사번, 이름, 급여 조회
SELECT emp_id, full_name, salary
FROM employees;

# Training_programs 테이블에서 모든 데이터 조회
SELECT *
FROM training_programs;

# Training_programs 테이블에서 (program_name, duration_hours) 프로그램명, 교육시간 조회
SELECT program_name, duration_hours
FROM training_programs;

/*******************************
컬럼 값 산술 연산자

-- 컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값

SELECT 문 작성시 컬럼명에 산술 연산을 직접 작성하면
조회 결과(RESULT SET)에 연산 결과가 반영되어 조회된다!
********************************/

-- 1. Employee 테이블에서 모든 사원의 이름, 급여, 급여 + 500만원을 했을 때 인상 결과 조회alter
SELECT full_name, salary, salary + 5000000
FROM employees;

-- 2. Employee 테이블에서 모든 사원의 사번, 이름, 연봉(급여 * 12) 조회
SELECT emp_id, full_name, salary * 12
FROM employees;

-- 3. Training_programs 테이블에서 프로그램명, 교육시간, 하루당 8시간 기준 교육일수 조회
SELECT program_name, duration_hours, duration_hours/8
FROM training_programs;

-- Employee 테이블에서 이름, 급여, 급여 * 0.8 조회(세후급여)
SELECT full_name, salary, salary * 0.8
FROM Employees;

-- POSIOTION 테이블 전체 조회
SELECT *
FROM positions;

-- POSITION 테이블에서 직급명, 최소 급여, 최대 급여, 급여차이(최대급여 - 최소급여) 조회
SELECT position_name, min_salary, max_salary, max_salary - min_salary
FROM positions;

-- departments 테이블에서 부서명, 예산, 예산 * 1.1 	예산 + 10%(=예산 * 1.1)의 총액
SELECT dept_name, budget, budget * 1.1
FROM departments;

-- 모든 SQL에서는 DUAL 가상 테이블이 존재함. MySQL에서는 FROM을 생략할 경우 자동으로 DUAL 가상테이블 사용
-- 현재 날짜 확인하기
-- (가상 테이블 필요 없음)
SELECT NOW(), current_timestamp();

SELECT NOW(), current_timestamp
from dual;

CREATE DATABASE IF NOT EXISTS 네이버;
CREATE DATABASE IF NOT EXISTS 라인;
CREATE DATABASE IF NOT EXISTS 스노우;

USE 네이버;
USE 라인;
USE 스노우;


-- 날짜 데이터 연산하기 (+, -만 가능)
-- > +1 == 1일 추가
-- > -1 == 1일 감소

SELECT NOW() + interval 1 DAY, now() - interval 1 DAY;

-- 날짜 연산 (시간, 분, 초 단위)
SELECT NOW(),
		NOW() + INTERVAL 1 HOUR,
        NOW() + INTERVAL 1 MINUTE,
        NOW()  + INTERVAL 1 SECOND;

-- 어제, 현재 시간, 내일, 모레 조회
SELECT '2025-09-15', STR_TO_DATE('2025-09-15', '%Y-%m-%d');

SELECT DATEDIFF('2025-09-15', '2025-09-14');

-- CURDATE() : 시간정보를 제외한 년 월 일만 조회가능한 함수
SELECT full_name, hire_date, datediff(curdate(), hire_date)
FROM employees;

-- 컬럼병 별칭 지정하기
/****************
컬럼면 별칭 지정하기
1) 컬럼명 AS 별칭 : 문자OK, 띄어쓰기X, 특수문자X
2) 컬럼명 AS `별칭` : 문자OK, 띄어쓰기OK, 특수문자OK
3) 컬럼명 별칭 : 문자OK, 띄어쓰기X, 특수문자X
4) 컬럼명 `별칭` :  문자OK, 띄어쓰기OK, 특수문자OK

`` 이나 "" 사용 가능
대/소문자 구분 
*****************/

-- 별칭 이용해서 근무일수로 컬럼명 설정 후 조회하기
SELECT full_name, hire_date, datediff(curdate(), hire_date) AS `근무일수`
FROM employees;

-- 1. employees 테이블에서 사번, 이름 이메일 조회 
-- (별칭에서 as ``사용하지않고 조회)
SELECT emp_code as 사번, full_name as 이름, email as 이메일
FROM employees;

-- 2. employees 테이블에서 이름, 급여, 연봉(급여 * 12)로 해당 컬럼  
-- 조회 (별칭에서 as ``사용하고 조회)
SELECT full_name as `이름`, salary as `급여`, ceil(salary*12) as `연봉`
FROM employees;

-- 3. positions 테이블에서 직급명, 최소급여, 최대급여, 급여 차이 명칭으로
-- 해당 컬럼 데이터 조회(별칭에서 as "" 사용하고 조회)
SELECT position_name as "직급명", ceil(min_salary) as "최소급여", ceil(max_salary) as "최대급여", ceil(max_salary - min_salary) as "급여 차이"
FROM positions;

-- training_programs 테이블에서 프로그램명, 교육시간, 교육일수(8시간) 기준 조회
-- 교육일수 반올림 처리하여 정수로 조회
SELECT program_name AS `교육프로그램`,
duration_hours AS 총교육시간,
round(duration_hours / 8) AS "교육일수"
FROM training_programs;


/**************************
DISTINCT(별개의, 전혀 다른)
--> 중복 제거
-- 조회 결과 집합(RESULT SET)에서
   지정된 컬럼의 값이 중복되는 경우
   이를 한 번만 표시할 때 사용
**************************/
-- step1 employees 테이블에서 모든 사원의 부서코드 조회
SELECT dept_id
FROM employees;



-- step2 employees 테이블에서 사원이 존재하는 부서코드만 조회

select * 
FROM departments;

-- 조회한 결과가 존재하지 ㅇ낳는다 조회결과 : 0이 나온순가
-- 에러가 아님!!!
SELECT distinct manager_id
FROM employees;

-- EMPLOYEES 테이블에서 사원이 있는 부서 ID만 중복을 제거한 후 조회
SELECT distinct dept_id
FROM employees;

-- EMPLOYEES 테이블에서 존재하는 position_id 코드의 종류 조회 중복 없이 조회
SELECT distinct position_id
FROM employees;

# error code 1046 : 어떤 DB를 사용할 것인지 지정해주지 않아서 발생하는 문제


/************************
	WHERE 절
테이블에서 조건을 충족하는 행을 조회할 때 사용
WHERE절에는 조건신(true/false)만 작성

비교 연산자 : >, <, >=, <=, =(같다), !=(같지 않다), <>(같지않다)
논리 연산자 : AND, OR, NOT

SELECT 컬럼명, 컬럼명, ...
FROM 테이블명
WHERE 조건식;
************************/
-- employees 테이블에서 급여가 300만원 초과하는 사원의
-- 사번, 이름, 급여, 부서코드 조회
/*3*/SELECT emp_id, full_name, salary, dept_id
/*1*/FROM employees
/*2*/WHERE salary > 3000000;
/* FROM 절에 지정된 테이블에서 
*** WHERE 절로 행을 먼저 추려내고, 추려진 결과 행들 중에서
*SELECT 절에 원하는 컬럼만 조회*/

-- employees 테이블에서 연봉이 5천만원 이상인 사원의 사번 이름 연봉 조회
SELECT emp_id, full_name, salary * 12
FROM employees
WHERE salary * 12 >= 50000000;

-- employees 테이블에서 부서코드가 2번이 아닌 사원의 이름, 부서코드, 전화번호 조회
SELECT full_name, dept_id, phone 
FROM employees
WHERE dept_id != 2;

/* 연결 연산자 CONCAT() */

SELECT CONCAT(emp_id, full_name) as 사번이름연결
FROM employees;


/***********************************
			  LIKE 절
***********************************/

-- EMPLOYEES 테이블에서 성이 '김'씨인 사원의 사번, 이름 조회
SELECT emp_id, full_name
FROM EMPLOYEES
WHERE first_name LIKE '김%';

-- EMPLOYEES 테이블에서 full_name 이름에 '민'이 포함되는 사원의 사번, 이름 조회
SELECT emp_id, full_name
FROM employees
WHERE full_name LIKE '%민%';

SELECT * 
FROM employees;

-- empliyees 테이블에서 전화번호가 02으로 시작하는 사원의 이름, 전화번호 조회
SELECT full_name, phone
FROM employees
WHERE phone LIKE '02%';

-- employees 테이블에서 EMAIL의 아이디(@) 기준 3글자인 사원의 이름, 이메일 조회
SELECT full_name, email
FROM employees
WHERE email LIKE '___@%';

-- employees 테이블에서 사원코드가 EMP로 시작하고 EMP 포함해서 총 6자리인 사원 조회
SELECT full_name, emp_code
FROM employees
WHERE emp_code LIKE 'EMP___';


/************************************
WHERE절
AND OR BETWEEN IN()
************************************/

-- EMPLOYEES 테이블에서
-- 급여가 4000만이상, 7000만 이하인 사원의 사번, 이름, 급여 조회
-- emp_id, full_name, salary
-- AND BETWEEN 구문 이용한 두가지 SQL 문 작성하기
SELECT emp_id, full_name, salary
FROM employees
WHERE salary >= 40000000 AND salary <= 70000000;

SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 AND 70000000;

-- EMPLOYEES 테이블에서
-- 급여가 4000만미만, 8000만 초과인 사원의 사번, 이름, 급여 조회
-- emp_id, full_name, salary
-- OR NOT BETWEEN 구문 이용한 두가지 SQL 문 작성하기
SELECT emp_id, full_name, salary
FROM employees
WHERE salary < 40000000 OR salary > 80000000;

SELECT emp_id, full_name, salary
FROM employees
WHERE salary NOT BETWEEN 40000000 AND 80000000;

-- BETWEEN 구문 이용해서
-- EMPLOYEES 테이블에서
-- 입사일이 2020-01-01부터 2020-12-31 사이인 사원의 이름, 입사일 조회
SELECT full_name, hire_date
FROM employees
WHERE hire_date between '2020-01-01' AND '2020-12-31';

-- BETWEEN 구문 이용해서
-- EMPLOYEES 테이블에서
-- 생년월일(date_of_birth)이 1980년대인 사원 조회
-- emp_id, full_name, date_of_birth
SELECT emp_id, full_name, date_of_birth
FROM employees
WHERE date_of_birth BETWEEN '1980-01-01' AND '1989-12-31';
-- WHERE date_of_birth LIKE '198_%';

-- EMPLOYEES 테이블에서
-- 부서 ID가 4인 사원 중
-- 급여가 4000만이상, 7000만 이하인 사원의 사번, 이름, 급여 조회
SELECT emp_id, full_name, salary, dept_id
FROM employees
WHERE dept_id = 4 AND (salary BETWEEN 40000000 AND 70000000);

-- ORDER절 WHERE 응용 IN()절  JOIN문 alter


-- employees 테이블에서 
-- 부서코드가 2, 4, 5인 사원의 
-- 이름, 부서코드, 급여 조회
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id = 2 OR dept_id = 4 OR dept_id=5;

-- 컬럼의 값이 () 내 값과 일치하면 true 
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id IN(2, 4, 5);

-- employees 테이블에서 
-- 부서코드가 2, 4, 5인 사원을 제외하고  
-- 이름, 부서코드, 급여 조회
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id NOT IN(2, 4, 5);
-- -> dept_id가 NULL인 사람들 또한 제외된 후 조회

-- NULL 값을 가지면서, 부서코드가 2, 4, 5를 제외한 모든 사원들의 결과에 추가하는 구문
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id NOT IN(2, 4, 5) OR dept_id IS NULL;


/*********************************
ORDER BY 절
- SELECT 문의 조회 결과(RESULT SET)를 정렬할 때 사용하는 구문

SELECT 구문에서 가장 마지막에 해석됨
[작성법]
3 : SELECT 컬럼명 AS 별칭, 컬럼명, 컬럼명, ...
1 : FROM 테이블명
2 : WHERE 조건식
4 : ORDER BY 컬럼명 | 별칭 | 컬럼 순서[오름/내림 차순]
	* 컬럼이 오름차순인지 내림차순인지 작성되지 않았을 때는 기본으로 오름차순 정렬
    * ACS : 오름차순(=ascending)  
    * DESC : 내림차순(=descending0) 
*********************************/

-- employees 테이블에서 모든 사원의 이름, 급여 조회
-- 단, 급여 오름차순으로 정렬
/*2*/SELECT full_name, salary
/*1*/FROM employees
/*3*/ORDER BY salary; -- ASC 기본값

/*2*/SELECT full_name, salary
/*1*/FROM employees
/*3*/ORDER BY salary ASC; 

SELECT full_name, salary
FROM employees
ORDER BY salary DESC;

-- employees 테이블에서
-- 급여가 300만원 이상, 600만원 이하인 사람의
-- 사번, 이름, 급여를 이름 내림차순으로 조회
SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 and 1000000000
ORDER BY full_name DESC;  

SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 and 1000000000
ORDER BY 2 DESC; -- 2번째 컬럼(full_name)으로 정렬

/* ORDER BY 절 수식 적용 해서 정렬 가능 */  
-- employees 테이블에서 이름, 연봉을 연봉 내림차순으로 조회
SELECT full_name, salary * 12
FROM employees
ORDER BY salary * 12 DESC;

SELECT full_name, salary * 12 AS 연봉
FROM employees
ORDER BY 연봉 DESC;

SELECT full_name, salary * 12 AS 연봉
FROM employees
ORDER BY salary * 12 DESC;

/* NULL 값 정렬 처리 */
-- 기본적으로 NULL 값은 가장 작은 값으로 처리됨
-- ASC : NULL 최상위 존재
-- DESC : NULL 최하위 존재

/*3*/SELECT full_name, dept_id AS 부서코드
/*1*/FROM employees
/*2*/WHERE dept_id = 4
/*4*/ORDER BY 부서코드 DESC;

-- 모든 사원의 이름 전화번호를 phone 기준으로 오름차순 조회
SELECT full_name, phone
FROM employees
ORDER BY PHONE ASC;

-- employees 테이블에서 
-- 이름, 부서아이디, 급여를
-- 급여 내림차순 정렬
SELECT full_name, dept_id, salary
FROM employees
ORDER BY salary DESC;

/*****************************
JOIN

INNER JOIN : 두 테이블에서 조건을 만족하는 행만 반환
	- 모든 고객과 그들의 최근 주문 번호
    - 주문이 있는 상품만 주문과 주문상품 조회
    - 로그인한 사용자의 권한 정보
    - 결제 완료된 주문 내역
LEFT JOIN : 왼쪽 테이블에 모든 행을 반환하고, 오른쪽에서 일치하는 행이 있으면 함께 반환
	- 모든 상품과 리뷰개수 (리뷰가 없어도 상품은 표시)
    - 모든 고객과 그들의 최근 주문 번호 (주문이 없어도 모든 고객은 표시)
    - 직원과 교육 이수 현황(교육 안 받은 직원도 포함해서 표시)
RIGHT JOIN : 오른쪽 테이블의 모든 행을 반환
	- LEFT JOIN으로도 충분히 사용 가능하기 때문에 실무에서는 거의 사용하지 않음
FULL OUTER JOIN : MYSQL에서 지원하지 않지만, UNION 예약어를 통해 구현 가능
	- 두 테이블의 모든 데이터를 다 보고 싶을 때 사용하지만 거의 드뭄
			- UNION : 중복 제거한 후 조회 (중복을 제거한 후 조회하기 때문에 상대적으로 느림)
            - UNION ALL : 중복 포함한 후 조회 (중복을 포함한 모든 행 반환하기 때문에 빠름)
SELF JOIN : 같은 테이블을 자기 자신과 조인
	- 계층 구조나 같은 테이블 내 관계를 조회할 때
    - 게시글 - 답글 관계
    - 추천인 - 피추천인 관계
CROSS JOIN : 두 테이블의 모든 행을 조합
	- 모든 조합을 만들어야 할 때 
    - 월별 실적 테이블 초기화
    - 모든 사용자에게 기본 권한 부여

JOIN은 테이블간의 기준 컬럼을 통해 하나의 결과를 조회할 때 사용
JOIN을 이용해서 VIEW 테이블을 생성한 후 VIEW 테이블에서 데이터를 읽어오는 것이 효율적임 !!!
*****************************/

/*
USE EMPLOYEE_MANAGEMENT;
다른 데이버베이스에서 잠시 조회하고자하는 테이블을 조회할 때는
SELECT * FROM 다른데이터베이스명칭.테이블명칭;
SELECT * FROM employee.management.employees;
*/
USE EMPLOYEE_MANAGEMENT;
-- 부서가 있는 직원만 조회
SELECT * FROM EMPLOYEES;
SELECT * FROM departments;

-- JOIN 방식
SELECT employees.full_name, departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.dept_id;

SELECT E.full_name, D.dept_name
FROM employees E
INNER JOIN departments D ON E.dept_id = D.dept_id;

-- WHERE 방식
SELECT E.full_name, D.dept_name
FROM employees E, departments D
WHERE E.dept_id = D.dept_id;
