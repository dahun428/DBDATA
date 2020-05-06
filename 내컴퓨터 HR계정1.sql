SELECT employee_id, first_name, salary, hire_date
FROM employees
WHERE department_id = 60
ORDER BY first_name ASC;
SELECT employee_id, first_name, salary, hire_date
FROM employees
WHERE department_id = 60
ORDER BY first_name ASC, employee_id ASC, salary ASC;

SELECT employee_id, first_name, salary,(salary * 4 * 12) AS YEAR_SAL, hire_date
FROM employees
WHERE department_id = 60
ORDER BY YEAR_SAL DESC;
SELECT employee_id, first_name, salary,(salary * 4 * 12) AS YEAR_SAL, hire_date
FROM employees
WHERE department_id = 50
AND (salary * 4 * 12) >= 250000
ORDER BY YEAR_SAL DESC;

SELECT employee_id, first_name, salary
    , salary*4*12 AS ANNUAL_SAL , hire_date
FROM employees
WHERE department_id = 50
AND salary * 4 * 12 >= 200000
ORDER BY ANNUAL_SAL DESC;

SELECT first_name, salary
FROM employees
WHERE department_id = 50
ORDER BY salary DESC, first_name ASC;

SELECT SUBSTR(last_name,2,4)
FROM employees;
SELECT TRIM('A' FROM first_name || ' ' || LAST_NAME)
FROM employees;
SELECT employee_id, first_name, LENGTH(first_name), INSTR(first_name, 'A') AS "CONTAINS A ?"
FROM employees
WHERE INSTR(FIRST_NAME, 'A') >= 1;

select employee_id, upper(first_name)
    , lower(first_name)
    , length(first_name)
    , concat(first_name, concat(' ', last_name))
    , Lpad(first_name, 10, '#')
    , rpad(first_name, 10, '@')
from employees;


