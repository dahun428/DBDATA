SELECT b.employee_id ,b.first_name, b.job_id, b.department_id 
FROM job_history A, employees B
WHERE a.employee_id = b.employee_id
AND a.department_id = 50;

SELECT employee_id, first_name, job_id, department_id
FROM employees
WHERE employee_id IN (SELECT employee_id 
                        FROM JOB_HISTORY A 
                        WHERE a.department_id = 50);

SELECT *
FROM departments A, locations B
WHERE a.location_id = b.location_id
AND B.CITY = 'Seattle';

SELECT employee_id, first_name 
FROM employees
WHERE department_id IN (SELECT a.manager_id 
                        FROM departments A, locations B 
                        WHERE a.location_id = b.location_id 
                        AND b.city = 'Seattle');
SELECT a.employee_id, a.first_name
FROM employees A, departments B, locations C
WHERE a.employee_id = b.manager_id
AND B.LOCATION_ID = c.location_id
AND C.CITY = 'Seattle';

SELECT *
FROM countries;
SELECT *
FROM regions;
SELECT *
FROM locations;

SELECT *
FROM departments A, locations B
WHERE a.location_id = b.location_id
AND CITY = 'Seattle';

select * from employees where employee_id = 100;

