SELECT department_id, ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id;

SELECT department_id, COUNT(*)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

SELECT manager_id ,COUNT(*)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

SELECT a.department_name, COUNT(*)
FROM departments A, employees B
WHERE a.department_id = b.department_id
AND b.department_id IS NOT NULL
GROUP BY a.department_name;
SELECT *
FROM employees A, departments B
WHERE a.department_id = b.department_id
AND b.department_name = 'Administration';

SELECT C.CITY, b.department_name, COUNT(*)
FROM employees A, departments B, locations C
WHERE a.department_id = b.department_id
AND b.location_iD = c.location_id
GROUP BY c.city, b.department_name;
SELECT a.first_name, C.CITY
FROM employees A, departments B, locations C
WHERE a.department_id = b.department_id AND b.location_id = c.location_id
AND C.CITY = 'London'
ORDER BY C.CITY;

SELECT TRUNC(A.SALARY, -3) AS SAL ,COUNT(*)
FROM employees A  
GROUP BY TRUNC(A.SALARY, -3)
HAVING count(*) >= 10
ORDER BY SAL DESC;

SELECT b.department_name, TRUNC(AVG(A.SALARY))
FROM employees A, departments B
WHERE a.department_id = b.department_id
GROUP BY b.department_name
HAVING TRUNC(AVG(A.SALARY)) < 5000;

SELECT AVG(TRUNC(AVG(a.salary)))
FROM employees A,departments B
WHERE a.department_id = b.department_id
GROUP BY b.department_id;

SELECT AVG(salary)
FROM employees;

SELECT MAX(COUNT(*))
FROM employees
GROUP BY department_id;

SELECT B.GRA, COUNT(*)
FROM employees A, JOB_GRADES B
WHERE a.salary BETWEEN B.LOWEST_SAL AND b.highest_sal
GROUP BY B.GRA
ORDER BY B.GRA ASC;

SELECT B.GRA, TRUNC(AVG(a.salary))
FROM employees A, JOB_GRADES B
WHERE a.salary BETWEEN B.LOWEST_SAL AND b.highest_sal
GROUP BY B.GRA
ORDER BY B.GRA ASC;

SELECT *
FROM employees A
WHERE a.salary > (SELECT B.salary FROM employees B WHERE LAST_NAME = 'Abel');

SELECT * 
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') IN (SELECT TO_CHAR(hire_date,'YYYY') FROM employees WHERE first_name = 'Neena');

SELECT employee_id, first_name, JOb_id, salary
FROM employees
WHERE JOB_ID IN (SELECT JOB_ID 
                FROM employees
                WHERE FIRST_NAME = 'Stephen');




SELECT employee_id, first_name, salary
FROM employees
WHERE JOB_ID IN (SELECT JOB_ID
                FROM employees
                WHERE first_name = 'Mozhe')
AND salary > (SELECT SALARY
                FROM EMPLOYEES
                WHERE FIRST_NAME = 'Mozhe');

SELECT TRUNC(AVG(salary))
FROM employees;

SELECT employee_id, first_name, salary
FROM employees
WHERE salary < (SELECT AVG(salary) 
                FROM employees)
ORDER BY salary;

SELECT employee_id, first_name, salary
FROM employees
WHERE salary IN (SELECT MIN(SALARY)
                FROM employees);
                

SELECT employee_id, first_name 
FROM employees
WHERE department_id = (SELECT DEPARTMENT_ID
                        FROM employees
                        GROUP BY department_id
                        HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                                            FROM EMPLOYEES
                                            GROUP BY DEPARTMENT_ID));
WITH DEPTCNT
AS (SELECT DEPARTMENT_ID, COUNT(*) CNT
    FROM employees
    GROUP BY department_id)
SELECT DEPARTMENT_ID, CNT
FROM DEPTCNT
WHERE CNT = (SELECT MAX(CNT) FROM DEPTCNT);
