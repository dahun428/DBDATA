-- 부서테이블의 모든 부서 정보를 조회하기
SELECT department_id, department_name, manager_id, location_id
FROM DEPARTMENTS;

-- 부서테이블에서 위치아이디가 1700번이 아닌 부서 정보 조회하기
SELECT department_id, department_name, manager_id, location_id
FROM departments
WHERE location_id NOT IN(1700);

-- 100사원이 관리하는 부서정보 조회하기
SELECT department_id, department_name, manager_id, location_id
FROM departments
WHERE manager_id = 100;

-- 부서명이 'IT'인 부서의 정보 조회하기
SELECT department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = 'IT';

-- 위치아이디가 1700번인 지역의 주소, 우편번호, 도시명, 국가코드를 조회하기
SELECT street_address AS 지역주소, postal_code AS 우편번호, city AS 도시명, country_id AS 국가코드
FROM locations
WHERE location_id = 1700;

-- 최소급여가 2000이상 5000이하인 직종의 직종아이디, 직종제목, 최소급여, 최대급여 조회하기
SELECT job_id, job_title, min_salary, max_salary
FROM jobs
WHERE min_salary BETWEEN 2000 AND 5000;

-- 최대급여가 20000불을 초과하는 직종의 아이디, 직종제목, 최소급여, 최대급여 조회하기
SELECT job_id, job_title, min_salary, max_salary
FROM jobs
WHERE max_salary > 20000;


-- 100직원에게 보고하는 사원의 아이디, 이름, 부서아이디을 조회하기
SELECT employee_id, first_name, manager_id, department_id
FROM employees
WHERE manager_id = 100;

-- 80번 부서에서 근무하고 급여를 8000불 이상 받는 사원의 아이디, 이름, 급여, 커미션포인트 조회하기
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE department_id = 80
AND salary >= 8000;

-- 직종이 SA_REP이고, 커미션포인트가 0.25이상인 사원의 아이디, 이름, 급여, 커미션포인트를 조회하기
SELECT employee_id, first_name, salary, commission_pct
FROM employees
WHERE job_id = 'SA_REP'
AND commission_pct >= 0.25;


-- 80번 부서에 근무하고, 급여가 10000불 이상인 사원의 아이디, 이름, 급여, 연봉을 조회하기
 --   연봉 = (급여 + 급여*커미션)*12다
 --   연봉의 별칭은 annual_salary다.
SELECT employee_id, first_name, salary, (salary + (salary * COMMISSION_PCT)*12) AS  ANNUAL_SALARY
FROM employees
WHERE department_id = 80
AND salary >= 10000;



-- 80번 부서에 근무하고, 147번 직원에게 보고하는 사원 중에서 커미션이 0.1인 사원의 
  --  사원아이디, 이름, 직종, 급여, 커미션포인트를 조회하기
SELECT employee_id, first_name, job_id, salary, commission_pct
FROM employees
WHERE department_id = 80
AND manager_id = 147
AND commission_pct = 0.1;

-- 사원들이 수행하는 직종을 중복없이 조회하기
SELECT DISTINCT job_id
FROM employees;

-- 사원들이 소속된 부서아이디를 모두 조회하기
SELECT DISTINCT department_id
FROM employees;


-- 급여가 12000을 넘는 사원의 이름과 급여를 조회하기
SELECT first_name, salary
FROM employees
WHERE salary > 12000;


-- 급여가 5000이상 12000이하인 사원의 이름과 급여를 조회하기
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 5000 AND 12000;


-- 2007년에 입사한 사원의 아이디, 이름, 입사일을 조회하기
SELECT employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '07/%';

-- 20과 50번 부서에 소속된 사원의 이름과 부서번호를 조회하고, 이름을 알파벳순으로 정렬해서  조회하기
SELECT first_name, department_id
FROM employees
WHERE department_id IN (20,50)
ORDER BY first_name ASC;


-- 급여가 5000이상 12000이하고, 20번과 50번 부서에 소속된 사원의 이름과 급여, 부서번호를 조회하기
SELECT salary, department_id
FROM employees
WHERE salary BETWEEN 5000 AND 12000
AND department_id IN (20,50);
-- 관리자가 없는 사원의 이름과 직종, 급여를 조회하기
SELECT first_name, salary
FROM employees
WHERE manager_id IS NULL;

-- 직종이 'SA_MAN'이거나 'ST_MAN'인 직원중에서 급여를 8000이상 받는 사원의 아이디, 이름, 직종, 급여를 조회하기
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE job_id IN ('SA_MAN','ST_MAN')
AND salary >= 8000;


