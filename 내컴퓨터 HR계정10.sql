SELECT * FROM JOB_HISTORY;
--집합 연산자 사용하기
--모든 사원의 현재 및 이전에 근무했던 직종을 조회하기
--사원 별로 한번 씩만 표시하기
SELECT EMPLOYEE_ID , JOB_ID  -- 현재 근무 중인 직종 조회화기
FROM employees 
UNION 
SELECT employee_id, job_id  -- 이전에 근무했던 직종 조회하기
FROM job_history;

-- 모든 사원의 현재 부서 아이디와 이전 소속 부서 아이디를 조회하기
SELECT EMPLOYEE_ID , employees.department_id  -- 현재 근무 중인 직종 조회화기
FROM employees 
UNION all
SELECT employee_id, job_history.department_id  -- 이전에 근무했던 직종 조회하기
FROM job_history;

-- 현재 종사하는 직종과 같은 직종에서 종사하고 있는 사원의 아이디와 직종아이디 조회하기
SELECT employees.employee_id, JOB_ID FROM employees INTERSECT SELECT job_history.employee_id,JOB_ID FROM job_history;

SELECT a.employee_id, a.job_id FROM employees A, JOB_HISTORY B WHERE a.employee_id = b.employee_id AND A.JOB_ID = b.job_id ORDER BY a.employee_id;
SELECT * FROM job_history ;
SELECT a.employee_id, b.first_name FROM (
SELECT employees.employee_id FROM employees MINUS SELECT job_history.employee_id FROM job_history) A, employees B WHERE a.employee_id = b.employee_id ORDER BY 1;

--징족이 변경된 적없는 사원의 아이디, 이름 조회
SELECT a.employee_id, b.first_name, b.job_id, c.department_name FROM(SELECT employees.employee_id FROM employees MINUS SELECT job_history.employee_id FROM job_history) A, employees B, departments C
WHERE a.employee_id = b.employee_id AND b.department_id = c.department_id;

--모든 사원의 현재 및 이전에 근무했던 직종을 조회하기
--사원 아이디,직종, 급여를 조회하기
SELECT a.employee_id, a.job_id, b.salary FROM (
SELECT employees.employee_id, employees.job_id FROM employees
UNION
SELECT job_history.employee_id, job_history.job_id FROM JOB_HISTORY) A , employees B WHERE a.employee_id = b.employee_id;
