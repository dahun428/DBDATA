SELECT employee_id, first_name, salary,
    DECODE(TRUNC(SALARY, -4), 20000, 'A'
                            , 10000, 'B'
                            , DECODE(TRUNC(SALARY/5000)*5000, 5000 , 'C'
                                                                   , 'D')) AS 등급                    
FROM employees
ORDER BY 등급 ASC;
