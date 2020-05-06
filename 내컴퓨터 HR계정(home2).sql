-- 1.  시스템의 현재 날짜와 시간 조회하기 (dual 사용)
SELECT SYSDATE
FROM DUAL;

-- 2.  급여를 5000달러 이상받고, 2005년에 입사한 직원의 아이디, 이름, 급여, 입사일을 조회하기
SELECT employee_id, first_name, salary, hire_date
FROM employees
WHERE salary >= 5000 AND hire_date LIKE '05%';

-- 3.  이름에 e나 E가 포함된 직원 중에서 급여를 10000달러 이상 받는 직원의 아이디, 이름, 급여를 조회하기
SELECT employee_id, first_name, salary
FROM employees
WHERE first_name LIKE '%E%' OR FIRST_NAME LIKE '%e%'
AND salary >= 10000;

-- 4.  입사년도와 상관없이 4월에 입사한 직원들의 아이디, 이름, 입사일을 조회하기
SELECT employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '__/04/%';

-- 5.  2006년 상반기(1/1 ~ 6/30)에 입사한 직원들의 아이디, 이름, 입사일 조회하기
SELECT employee_id, first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '06/01/01' AND '06/06/30';

-- 6.  50번 부서에 소속된 직원들의 급여를 13%인상시키려고 한다.
--     직원아이디, 이름, 현재 급여, 인상된 급여를 조회하기
--     인상된 급여는 소숫점 이하는 버린다.
SELECT employee_id, first_name, salary, TRUNC(SALARY * (1.13), 2) AS INCREASED_SAL
FROM employees
WHERE department_id = 50
ORDER BY employee_id;

-- 7.  50번 부서에 소속된 직원들의 급여를 조회하려고 한다.
--     직원 아이디, 이름, 급여 그리고, 급여 1000달러당 *를 하나씩 표시하라.
--     120 Matthew 8000 ********
--     122 Shanta  6500 ******
SELECT employee_id, first_name, salary, RPAD('*',TRUNC(salary/1000),'*') AS RPAD
FROM employees
WHERE department_id = 50
ORDER BY RPAD DESC;

-- 8.  관리자가 지정되어 있지 않는 부서의 
--     부서아이디, 부서명, 위치아이디, 도시명, 주소를 조회하기
SELECT A.department_id, A.department_name, b.location_id, b.city, b.street_address
FROM departments A, locations B
WHERE manager_id IS NOT NULL
AND a.location_id = b.location_id
ORDER BY a.department_id;

-- 9.  90번 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
SELECT a.employee_id, a.first_name, a.job_id, a.salary
FROM employees A
WHERE a.department_id = 90
ORDER BY a.employee_id;

-- 10. 100번 직원이 부서관리자로 지정된 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
SELECT a.employee_id, a.first_name, a.job_id, a.salary
FROM employees A, departments B
WHERE a.department_id = b.department_id AND b.manager_id = 100;


-- 11. 10, 20, 30번 부서에 소속된 직원들의 직원아이디, 이름, 급여, 급여등급을 조회하기
SELECT a.employee_id, a.first_name, a.salary, B.GRA AS GRADE
FROM employees A, job_grades B
WHERE a.salary BETWEEN b.lowest_sal AND b.highest_sal
AND a.department_id IN (10, 20, 30)
ORDER BY a.employee_id;

-- 12. 직원들의 직종정보를 참고했을 때 자신이 종사하고 있는 직종의 최저급여를 받고 있는
--     직원의 아이디, 이름, 급여, 직종아이디, 직종최저급여를 조회하기
SELECT a.employee_id, a.first_name, a.salary, a.job_id, b.min_salary
FROM employees A, JOBS B
WHERE a.salary = b.min_salary AND a.job_id = b.job_id
ORDER BY a.employee_id ASC;

SELECT a.employee_id, a.first_name, a.salary, a.job_id, b.min_salary
FROM employees A, JOBS B
WHERE A.JOB_ID = b.job_id
AND a.salary = b.min_salary;


-- 13. 커미션을 받는 직원들의 직원아이디, 이름, 커미션, 급여, 직종아이디, 직종제목, 급여, 소속부서 아이디, 부서명을 조회하기
SELECT a.employee_id, a.first_name, a.salary, a.job_id, b.job_title, a.department_id, c.department_name
FROM employees A, JOBS B, departments C
WHERE a.job_id = b.job_id AND a.department_id = c.department_id
AND a.commission_pct IS NOT NULL
ORDER BY a.employee_id;
-- 14. 'Canada'에서 근무하고 있는 직원의 아이디, 이름, 소속부서 아이디, 소속부서명, 위치 아이디, 도시명, 주소를 조회하기

SELECT a.employee_id, a.first_name, b.department_id, b.department_name, b.location_id, c.country_id, c.street_address
FROM employees A, departments B, locations C
WHERE a.department_id = b.department_id AND b.location_id = c.location_id
AND c.country_id = 'CA'
ORDER BY a.employee_id;

-- 15. 모든 직원의 직원아이디, 이름, 직종아이디, 직종제목, 급여, 급여등급, 소속부서 아이디, 소속부서명, 도시명을 조회하기
SELECT a.employee_id, a.first_name, a.job_id, b.job_title, a.salary, d.department_id, d.department_name, c.CITY, e.gra
FROM employees A, JOBS B, locations C, departments D, job_grades e
WHERE a.job_id = b.job_id AND a.department_id = d.department_id AND d.location_id = c.location_id
AND a.salary BETWEEN e.lowest_sal AND e.highest_sal
ORDER BY a.employee_id;
-- 16. 급여를 5000달러 이하로 받는 직원들의 아이디, 이름, 직종, 소속부서 아이디, 소속부서명, 소속부서 관리자 직원아이디, 
--     소속부서 관리자 직원이름을 조회하기
SELECT a.employee_id, a.first_name, a.job_id, a.salary, b.department_id, b.department_name, b.manager_id, c.first_name
FROM employees A, departments B, employees C
WHERE A.salary <= 5000
AND a.department_id = b.department_id
AND b.manager_id = c.employee_id
ORDER BY a.employee_id;

-- 17. 'Asia'지역에 소재지를 두고 있는 부서의 아이디, 부서명, 부서관리자 이름을 조회하기

SELECT a.department_id, a.department_name, b.country_id, c.region_id, d.region_name
FROM departments A, locations B, countries C, regions D
WHERE a.location_id = b.location_id AND b.country_id = c.country_id
AND C.REGION_ID = D.REGION_ID
AND D.REGION_NAME = 'Asia';

-- 18. 101번 직원이 근무했던 부서에서 근무중이 직원의 아이디, 이름, 부서아이디, 부서명을 조회하기

SELECT distinct c.employee_id, c.first_name, b.department_id, B.DEPARTMENT_NAME
FROM job_history A, DEPARTMENTS B, EMPLOYEES C
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID AND B.DEPARTMENT_ID = C.DEPARTMENT_ID
AND A.EMPLOYEE_ID = 101;


-- 19. 직원중에서 자신이 종사하고 있는 직종의 최고급여 50%이상을 급여로 받고 있는 
--     직원의 아이디, 이름, 급여, 직종아이디, 직종 최고급여를 조회하기

SELECT a.employee_id, a.first_name, a.salary, a.job_id, b.max_salary
FROM employees A, JOBS B
WHERE A.JOB_ID = B.JOB_ID AND a.salary >= (b.max_salary / 2);

-- 20. 미국(US)에 위치하고 있는 부서의 아이디, 이름, 위치번호, 도시명, 주소를 조회하기

SELECT b.department_id, b.department_name, a.location_id, a.city, a.street_address
FROM locations A, departments B
WHERE a.location_id = b.location_id 
AND A.country_id = 'US';


