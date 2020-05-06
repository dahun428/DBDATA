SELECT a.employee_id, a.first_name, a.salary, b.gra
FROM employees A, JOB_GRADES B
WHERE a.salary BETWEEN b.lowest_sal AND b.highest_sal
ORDER BY a.salary ASC;

SELECT a.employee_id, a.first_name, a.salary, b.gra
FROM employees A, JOB_GRADES B
WHERE a.salary BETWEEN b.lowest_sal AND b.highest_sal
AND b.gra = 'A'
ORDER BY a.salary ASC;

SELECT a.employee_id, a.first_name, a.salary, b.gra
FROM employees A, JOB_GRADES B
WHERE a.salary >= b.lowest_sal AND a.salary <= b.highest_sal
ORDER BY a.salary ASC;

SELECT a.employee_id, a.first_name, b.highest_sal,a.salary, b.lowest_sal , b.gra, a.department_id
FROM employees A, JOB_GRADES B
WHERE a.department_id = '50'
AND a.salary BETWEEN B.LOWEST_SAL AND b.highest_sal
ORDER BY a.employee_id ASC;

SELECT a.job_id, a.job_title, a.min_salary, b.gra MIN_SALARY_GRA
FROM JOBS A, JOB_GRADES B
WHERE a.min_salary >= b.lowest_sal
AND a.MIN_salary <= b.highest_sal;

SELECT a.job_id, a.job_title, a.min_salary, c.gra MIN_SALARY_GRA, a.MAX_salary, b.gra MAX_SALARY_GRA
FROM JOBS A, JOB_GRADES B, JOB_GRADES C
WHERE
a.min_salary BETWEEN c.lowest_sal AND c.highest_sal
AND a.max_salary BETWEEN b.lowest_sal AND b.highest_sal
;

SELECT j.job_id AS ID
    , j.job_title AS TITLE
    , j_min.lowest_sal AS MIN_LOWEST
    , j.min_salary AS MIN_SAL
    , j_min.highest_sal AS MIN_HIGHEST
    , j_min.gra AS MIN_GRADE
    , j_max.lowest_sal AS MAX_LOWEST
    , j.max_salary AS MAX_SAL
    , j_max.highest_sal AS MAX_HIGHEST
    , j_MAX.GRA AS MAX_GRADE
FROM JOBS J , JOB_GRADES J_MIN , JOB_GRADES J_MAX
WHERE j.min_salary BETWEEN j_min.lowest_sal AND j_min.highest_sal
AND J.MAX_SALARY BETWEEN J_MAX.LOWEST_SAL AND J_MAX.HIGHEST_SAL
ORDER BY j.job_id;