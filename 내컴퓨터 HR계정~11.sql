--1. 급여가 5000이상 12000이하인 사원의 아이디, 이름, 급여를 조회하기
SELECT employee_id, first_name, salary FROM employees WHERE salary BETWEEN 5000 AND 12000 ORDER BY salary DESC;
--2. 사원들이 소속된 부서의 부서명을 중복없이 조회하기
SELECT DISTINCT b.department_name FROM employees A, departments B WHERE a.department_id = b.department_id AND b.department_name IS NOT NULL; 
--3. 2007년에 입사한 사원의 아이디, 이름, 입사일을 조회하기
SELECT * FROM employees WHERE hire_date BETWEEN TO_DATE('20061231', 'YYYYMMDD') AND TO_DATE('20080101','YYYYMMDD') ORDER BY hire_date DESC;
--4. 급여가 5000이상 12000이하이고, 20번과 50번 부서에 소속된 사원의 아이디, 이름, 급여, 소속부서명을 
--   조회하기
SELECT A.employee_id, A.first_name, A.salary, b.department_name 
FROM employees A, departments B 
WHERE A.salary BETWEEN 5000 AND 12000 
AND A.department_id IN (20,50) 
AND b.department_id = a.department_id ORDER BY salary;
--5. 100직원에게 보고하는 사원의 아이디, 이름, 급여, 급여등급을 조회하기
SELECT a.employee_id, a.first_name, a.salary, b.gra FROM employees A, JOB_GRADES B WHERE manager_id = 100 AND a.salary BETWEEN b.lowest_sal AND b.highest_sal;
--6. 80번 부서에 소속되어 있고, 80번 부서의 평균급여보다 적은 급여를 받는 사원의 아이디, 이름, 
--   급여를 조회하기
SELECT employee_id, first_name, salary FROM employees WHERE department_id = 80 AND salary < (SELECT TRUNC(AVG(salary)) FROM employees WHERE department_id = 80);
--7. 50번 부서에 소속된 사원 중에서 해당 직종의 최소급여보다 2배 이상의 급여를 받는 사원의 아이디, 
--   이름, 급여를 조회하기

SELECT A.EMPLOYEE_ID, A.FIRST_NAME, A.SALARY 
FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID 
        FROM employees 
        WHERE department_id = 50) A, JOBS B 
WHERE a.salary > (B.min_salary * 2) 
AND a.job_id = b.job_id;
--8. 사원들 중에서 자신의 상사보다 먼저 입사한 사원의 아이디, 이름, 입사일, 상사의 이름, 
--   상사의 입사일을 조회하기

SELECT * FROM employees A, EMPLOYEES B WHERE A.HIRE_DATE < b.hire_date AND a.employee_id = b.manager_id;
SELECT b.employee_id, b.first_name, b.hire_date, a.first_name AS 상사이름, a.hire_date AS 상사입사일 
FROM employees A, employees B 
WHERE a.employee_id = b.manager_id 
AND b.hire_date < a.hire_date;

--9. Steven King과 같은 부서에서 근무하는 사원의 아이디와 이름을 조회하기
SELECT employee_id, first_name||' '||last_name as name, department_id FROM employees WHERE department_id = (SELECT department_id FROM employees WHERE first_name ||' '|| last_name= 'Steven King');
--10. 관리자별 사원수를 조회하기, 관리자 아이디, 사원수를 출력한다. 관리자 아이디순으로 오름차순 정렬
SELECT a.employee_id,COUNT(A.EMPLOYEE_ID) AS 사원수 
FROM employees A, employees B 
WHERE a.employee_id = b.manager_id 
GROUP BY a.employee_id 
ORDER BY a.employee_id ASC;


--11. 커미션을 받는 사원의 아이디, 이름, 급여, 커미션을 조회하기
SELECT employee_id, first_name, salary, commission_pct 
FROM employees 
WHERE commission_pct 
IS NOT NULL ORDER BY commission_pct DESC;


--12. 급여를 가장 많이 받는 사원 3명의 아이디, 이름, 급여를 조회하기
SELECT b.employee_iD, b.first_name, b.salary 
FROM ( SELECT ROWNUM, EMPLOYEE_ID, FIRST_NAME, SALARY 
        FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY 
                FROM employees 
                ORDER BY salary DESC)
        WHERE ROWNUM <=3) A, employees B
WHERE a.employee_id = b.employee_id;
--13. 'Ismael'과 같은 해에 입사했고, 같은 부서에 근무하는 사원의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees 
where to_char(hire_date, 'yyyy') = (select to_char(hire_date, 'yyyy') 
                                    from employees 
                                    where first_name = 'Ismael')
and department_id = (select department_id
                        from employees
                        where first_name = 'Ismael');
                        
--14. 'Renske'에게 보고받는 사원의 아이디와 이름, 급여, 급여 등급을 조회하기
select * from employees A, employees B where a.employee_id = b.manager_id and b.manager_id = 'Renske';
select employee_id, first_name, salary, b.gra 
from employees A, job_grades B 
where employee_id = (select manager_id 
                        from employees 
                        where first_name = 'Renske') 
and a.salary BETWEEN b.lowest_sal and b.highest_sal;


--15. 사원테이블의 급여를 기준으로 급여등급을 조회했을 때, 급여등급별 사원수를 조회하기
SELECT B.GRA, COUNT(b.gra) 
FROM employees A, JOB_GRADES B 
WHERE a.salary BETWEEN B.LOWEST_SAL AND b.highest_sal 
GROUP BY B.GRA 
ORDER BY B.GRA; 


--16. 입사자가 가장 적은 년도와 그 해에 입사한 사원수를 조회하기
SELECT MIN(YEAR_CNT) AS MIN_HIRE_COUNT
FROM (SELECT TO_CHAR(HIRE_DATE,'YYYY') YEAR,COUNT(TO_CHAR(HIRE_DATE, 'YYYY')) YEAR_CNT 
      FROM employees 
      GROUP BY TO_CHAR(HIRE_DATE,'YYYY'));
--17. 관리자별 사원수를 조회했을 때 관리자하는 사원수가 10명을 넘는 관리자의 아이디와 사원수를 조회하기
SELECT a.employee_id, COUNT(A.EMPLOYEE_ID) CNT 
FROM employees A, employees B 
WHERE a.employee_id = b.manager_id 
GROUP BY a.employee_id 
HAVING COUNT(A.EMPLOYEE_ID) >= 10; 


--18. 'Europe'지역에서 근무중이 사원의 아이디, 이름, 소속부서명, 소재지 도시명, 나라이름을 조회하기
SELECT a.employee_id, a.first_name, b.department_name, c.city, e.region_name FROM employees A, departments B,LOCATIONS C, COUNTRIES D,regions E 
WHERE a.department_id = b.department_id 
AND b.location_id = c.location_id 
AND c.country_id = d.country_id 
AND d.region_id = e.region_id
AND e.region_name = 'Europe';

--19. 전체 사원의 사원아이디, 이름, 급여, 소속부서아이디, 소속부서명, 상사의 이름을 조회하기
select a.employee_id, a.first_name, a.salary, a.department_id, b.department_name, c.first_name
from employees a, departments b, employees c 
where a.department_id = b.department_id 
and a.manager_id = c.employee_id 
order by a.employee_id;

--20. 50번 부서에 근무중이 사원들의 급여를 500달러 인상시키기
select employee_id, first_name, salary, salary + 500 as Up_sal from employees where department_id = 50;


--21. 사원의 아이디, 이름, 급여, 보너스를 조회하기,
--    보너스는 20000달러 이상은 급여의 10%, 10000달러 이상은 급여의 15%, 그 외는 급여의 20%를 지급한다.
select employee_id, first_name, salary,
        case when salary > 20000 then salary * 0.1
             when salary > 10000 then salary * 0.15
        else salary *0.2
        end as bonus
from employees;

--22. 소속부서에서 입사일이 늦지만, 더 많은 급여를 받는 사원의 이름, 입사일, 소속부서명, 급여를 조회하기

select DISTINCT a.employee_id, a.first_name, a.hire_date, a.salary, a.department_id, c.department_name
from employees a, employees b, departments c
where a.department_id = b.department_id
and a.department_id = c.department_id
and a.hire_date > b.hire_date
and a.salary > b.salary
ORDER BY a.employee_id;

--23. 부서별 평균급여를 조회했을 때 부서별 평균급여가 10000달러 이하인 부서의 아이디, 부서명, 평균급여를
--    조회하기 (평균급여는 소숫점 1자리까지만 표시)
select trunc(avg(A.salary),1) from employees A, departments B where a.department_id = b.department_id group by A.department_id having trunc(avg(A.salary),1) < 10000;
select b.department_id, a.department_name, b.average
from departments A, (select a.department_id, trunc(avg(a.salary),1) average 
                        from employees a, departments b 
                        where a.department_id = b.department_id 
                        group by a.department_id
                        having trunc(avg(a.salary),1) < 10000) b 
where a.department_id = b.department_id;

--24. 사원들 중에서 자신 종사하고 있는 직종의 최대급여와 동일한 급여를 받는 사원의 아이디, 이름, 급여를
--    조회하기
select a.employee_id, a.first_name, a.salary from employees A, jobs B where a.job_id = b.job_id and a.salary = b.max_salary;

----25. 분석함수를 사용해서 사원들을 급여순으로 정렬하고, 순번을 부여했을 때 6~10번째 속하는 순번,
--    사원의 아이디, 이름, 급여, 급여등급을 조회하기

select num, a.employee_id, a.first_name, a.salary, a.gra
from (select row_number() over(order by A.salary desc) num, A.employee_id, A.first_name, A.salary, b.gra 
        from employees A, job_grades B 
        where A.salary between B.lowest_sal and b.highest_sal) A
where num BETWEEN 6 and 10;
