--1. 모든 직원들의 모든 업무아이디를 조회하기
SELECT employee_id, first_name, job_id
FROM employees
ORDER BY employee_id;
--2. 급여를 12,000달러 이상 받는 직원의 이름과 급여를 조회하기
SELECT first_name, salary
FROM employees
WHERE salary >= 12000 
ORDER BY employee_id;

--3. 직원번호가 176번 직원과 같은 부서에서 근무하는 직원의 아이디와 이름 직종아이디를 조회하기
SELECT employee_id, first_name, job_id
FROM employees
WHERE JOB_ID = (SELECT job_id FROM employees WHERE EMPLOYEE_ID = 176);

--4. 급여를 12,000달러 이상 15,000달러 이하 받는 직원들의 직원 아이디와 이름과 급여를 조회하기
SELECT employee_id, first_name, salary
FROM employees
WHERE salary BETWEEN 12000 AND 15000
ORDER BY employee_id;


--5. 2005년 1월 1일부터 2000년 6월 30일 사이에 입사한 직원의 아이디, 이름, 업무아이디, 입사일을 조회하기
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('2000-06-30', 'YYYY-MM-DD') AND TO_DATE('2005-01-01', 'YYYY-MM-DD')
ORDER BY HIRE_DATE;

--6. 급여가 5,000달러와 12,000달러 사이이고, 부서번호가 20 또는 50인 직원의 이름과 급여를 조회하기
SELECT first_name, salary, department_id
FROM employees
WHERE salary BETWEEN 5000 AND 12000
AND department_id IN (20, 50)
ORDER BY department_id;

--7. 관리자가 없는 직원의 이름과 업무아이디를 조회하기
SELECT first_name, job_id
FROM employees
WHERE manager_id IS NULL;

--8. 커미션을 받는 모든 직원의 이름과 급여, 커미션을 급여 및 커미션의 내림차순으로 정렬해서 조회하기
SELECT employee_id, first_name, salary, commission_pct 
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY SALARY DESC, commission_pct DESC;

--9. 이름의 2번째 글자가 e인 모든 직원의 이름을 조회하기
SELECT first_name
FROM employees
WHERE first_name LIKE '_e%';

--10. 업무아이디가 ST_CLERK 또는 SA_REP이고 급여를 2,500달러, 3,500달러, 7,000달러 받는 모든 직원의 이름과 업무아이디, 급여를 조회하기
SELECT first_name, job_id, salary
FROM employees
WHERE job_id IN ('ST_CLERK', 'SA_REP')
AND salary IN (2500, 3500, 7000)
ORDER BY salary;
--11. 모든 직원의 이름과 입사일, 근무 개월 수를 계산하여 조회하기, 근무개월 수는 정수로 반올림하고, 근무개월수를 기준으로 오름차순으로 정렬하기
SELECT first_name, hire_date, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS WORKING_MONTH
FROM employees
ORDER BY WORKING_MONTH;

--12. 직원의 이름과 커미션을 조회하기, 커미션을 받지 않는 직원은 '없음'으로 표시하기
SELECT first_name, NVL(TO_CHAR(commission_pct), '없음')
FROM employees;
--13. 모든 직원의 이름, 부서번호, 부서이름을 조회하기
SELECT a.first_name, a.department_id, b.department_name
FROM employees A, departments B
WHERE a.department_id = b.department_id
ORDER BY a.department_id;

--14. 80번부서에 소속된 직원의 이름과 업무아이디, 업무제목, 부서이름을 조회하기
SELECT a.employee_id ,a.first_name, a.job_id, c.job_title, b.department_name
FROM employees A, departments B, JOBS C
WHERE a.department_id = b.department_id
AND A.JOB_ID = C.JOB_ID
AND a.department_id = 80
ORDER BY a.employee_id;

--15. 커미션을 받는 모든 직원의 이름과 업무아이디, 업무제목, 부서이름, 부서소재지 도시명을 조회하기
SELECT a.first_name, a.job_id, b.job_title, c.department_name, d.street_address, d.city, a.commission_pct
FROM employees A, JOBS B, departments C, LOCATIONS D
WHERE a.job_id = b.job_id AND a.department_id = c.department_id AND c.location_id = d.location_id 
AND a.commission_pct IS NOT NULL;

--16. 유럽에 소재지를 두고 있는 모든 부서아이디와 부서이름을 조회하기
SELECT b.department_id, b.department_name, c.country_id, d.region_id
FROM departments B, locations C, COUNTRIES D
WHERE b.location_id = c.location_id
AND c.country_id = d.country_id
AND d.region_id = 1;

--17. 직원의 이름과 소속부서명, 급여, 급여 등급을 조회하기
SELECT a.first_name, b.department_name, a.salary, C.GRA
FROM employees A, departments B, JOB_GRADES C
WHERE a.department_id = b.department_id 
AND a.salary BETWEEN C.LOWEST_SAL AND c.highest_sal
ORDER BY c.gra DESC;

--18. 직원의 이름과 소속부서명, 소속부서의 관리자명을 조회하기, 소속부서가 없는 직원은 소속부서명 '없음, 관리자명 '없음'으로 표시하기
SELECT a.first_name, NVL(b.department_name,'없음'), NVL(c.first_name,'없음')
FROM employees A, departments B, employees C
WHERE a.department_id = b.department_id(+)
AND b.manager_id = c.employee_id(+);

--19. 모든 사원의 이름, 직종아이디, 급여, 소속부서명을 조회하기
SELECT a.first_name, a.job_id, a.salary, b.department_name
FROM employees A, departments B
WHERE a.department_id = b.department_id(+);

--20. 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여, 최대급여를 조회하기
SELECT a.first_name, a.job_id, b.job_title, a.salary, b.min_salary, b.max_salary 
FROM employees A, JOBS B
WHERE A.JOB_ID = B.JOB_ID
ORDER BY a.salary DESC;

--21. 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여와 본인 급여의 차이를 조회하기
SELECT a.first_name, a.job_id, b.job_title, a.salary, b.min_salary, a.salary - b.min_salary
FROM employees A, JOBS B
WHERE A.JOB_ID = b.job_id;

--22. 커미션을 받는 모든 사원의 아이디, 부서이름, 소속부서의 소재지(도시명)을 조회하기
SELECT a.first_name, NVL(b.department_name,'없음') AS 부서이름, NVL(c.city, '없음') AS 소재지
FROM employees A, departments B, locations C
WHERE a.department_id = b.department_id(+)
AND b.location_id = c.location_id(+)
AND a.commission_pct IS NOT NULL;

--23. 이름이 A나 a로 시작하는 모든 사원의 이름과 직종, 직종제목, 급여, 소속부서명을 조회하기

SELECT a.first_name, a.job_id, b.job_title, a.salary, c.department_name
FROM EMPLOYEES A, JOBS B, departments C
WHERE A.JOB_ID = b.job_id AND a.department_id = c.department_id 
AND FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'a%';

--24. 30, 60, 90번 부서에 소속되어 있는 사원들 중에서 100에게 보고하는 사원들의 이름, 직종, 급여,
--    급여등급을 조회하기
SELECT a.first_name, a.job_id, a.salary, b.gra
FROM employees A, JOB_GRADES B
WHERE a.department_id IN (30,60,90)
AND a.manager_id = 100
AND a.salary BETWEEN B.LOWEST_SAL AND b.highest_sal;

--25. 80번 부서에 소속된 사원들의 이름, 직종, 직종제목, 급여, 최소급여, 최대급여, 급여등급, 
--    소속부서명을 조회하기
SELECT a.department_id, a.first_name, a.job_id, b.job_title, a.salary, b.min_salary, b.max_salary, c.gra, d.department_name
FROM employees A, JOBS B, JOB_GRADES C, departments D
WHERE A.JOB_ID = B.JOB_ID
AND a.department_id = 80
AND a.department_id = d.department_id
AND a.salary BETWEEN C.LOWEST_SAL AND c.highest_sal
ORDER BY c.gra DESC;

--26. 사원들중에서 자신의 상사보다 먼저 입사한 사원들의 이름, 입사일, 상사의 이름, 상사의 입사일을
--    조회하기
SELECT a.employee_id, a.first_name, a.hire_date, b.first_name, b.hire_date
FROM employees A, employees B
WHERE a.manager_id = b.employee_id
AND a.hire_date < b.hire_date
ORDER BY a.employee_id;

--27. 부서명이 IT인 부서에 근무하는 사원들의 이름과, 직종, 급여, 급여등급, 상사의 이름과 직종을
--    조회하기

SELECT a.first_name, a.job_id, a.salary, c.gra, d.first_name, d.job_id
FROM employees A, departments B, JOB_GRADES C, employees D
WHERE a.department_id = b.department_id
AND a.salary BETWEEN c.lowest_sal AND c.highest_sal
AND a.manager_id = d.employee_id
AND b.department_name = 'IT';

--28. 'ST_CLERK'로 근무하다가 다른 직종으로 변경한 사원의 아이디, 이름, 변경전 부서명,
--     현재 직종, 현재 근무부수명을 조회하기
SELECT a.employee_id, b.first_name, c.department_name, b.job_id, D.department_name 
FROM job_history A, employees B, departments C, departments D
WHERE a.employee_id = b.employee_id
AND a.department_id = c.department_id 
AND b.department_id = D.department_id
AND A.JOB_ID = 'ST_CLERK';
