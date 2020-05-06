-- 1.  �ý����� ���� ��¥�� �ð� ��ȸ�ϱ� (dual ���)
SELECT SYSDATE
FROM DUAL;

-- 2.  �޿��� 5000�޷� �̻�ް�, 2005�⿡ �Ի��� ������ ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
SELECT employee_id, first_name, salary, hire_date
FROM employees
WHERE salary >= 5000 AND hire_date LIKE '05%';

-- 3.  �̸��� e�� E�� ���Ե� ���� �߿��� �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary
FROM employees
WHERE first_name LIKE '%E%' OR FIRST_NAME LIKE '%e%'
AND salary >= 10000;

-- 4.  �Ի�⵵�� ������� 4���� �Ի��� �������� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT employee_id, first_name, hire_date
FROM employees
WHERE hire_date LIKE '__/04/%';

-- 5.  2006�� ��ݱ�(1/1 ~ 6/30)�� �Ի��� �������� ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
SELECT employee_id, first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '06/01/01' AND '06/06/30';

-- 6.  50�� �μ��� �Ҽӵ� �������� �޿��� 13%�λ��Ű���� �Ѵ�.
--     �������̵�, �̸�, ���� �޿�, �λ�� �޿��� ��ȸ�ϱ�
--     �λ�� �޿��� �Ҽ��� ���ϴ� ������.
SELECT employee_id, first_name, salary, TRUNC(SALARY * (1.13), 2) AS INCREASED_SAL
FROM employees
WHERE department_id = 50
ORDER BY employee_id;

-- 7.  50�� �μ��� �Ҽӵ� �������� �޿��� ��ȸ�Ϸ��� �Ѵ�.
--     ���� ���̵�, �̸�, �޿� �׸���, �޿� 1000�޷��� *�� �ϳ��� ǥ���϶�.
--     120 Matthew 8000 ********
--     122 Shanta  6500 ******
SELECT employee_id, first_name, salary, RPAD('*',TRUNC(salary/1000),'*') AS RPAD
FROM employees
WHERE department_id = 50
ORDER BY RPAD DESC;

-- 8.  �����ڰ� �����Ǿ� ���� �ʴ� �μ��� 
--     �μ����̵�, �μ���, ��ġ���̵�, ���ø�, �ּҸ� ��ȸ�ϱ�
SELECT A.department_id, A.department_name, b.location_id, b.city, b.street_address
FROM departments A, locations B
WHERE manager_id IS NOT NULL
AND a.location_id = b.location_id
ORDER BY a.department_id;

-- 9.  90�� �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, a.job_id, a.salary
FROM employees A
WHERE a.department_id = 90
ORDER BY a.employee_id;

-- 10. 100�� ������ �μ������ڷ� ������ �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, a.job_id, a.salary
FROM employees A, departments B
WHERE a.department_id = b.department_id AND b.manager_id = 100;


-- 11. 10, 20, 30�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, a.salary, B.GRA AS GRADE
FROM employees A, job_grades B
WHERE a.salary BETWEEN b.lowest_sal AND b.highest_sal
AND a.department_id IN (10, 20, 30)
ORDER BY a.employee_id;

-- 12. �������� ���������� �������� �� �ڽ��� �����ϰ� �ִ� ������ �����޿��� �ް� �ִ�
--     ������ ���̵�, �̸�, �޿�, �������̵�, ���������޿��� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, a.salary, a.job_id, b.min_salary
FROM employees A, JOBS B
WHERE a.salary = b.min_salary AND a.job_id = b.job_id
ORDER BY a.employee_id ASC;

SELECT a.employee_id, a.first_name, a.salary, a.job_id, b.min_salary
FROM employees A, JOBS B
WHERE A.JOB_ID = b.job_id
AND a.salary = b.min_salary;


-- 13. Ŀ�̼��� �޴� �������� �������̵�, �̸�, Ŀ�̼�, �޿�, �������̵�, ��������, �޿�, �ҼӺμ� ���̵�, �μ����� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, a.salary, a.job_id, b.job_title, a.department_id, c.department_name
FROM employees A, JOBS B, departments C
WHERE a.job_id = b.job_id AND a.department_id = c.department_id
AND a.commission_pct IS NOT NULL
ORDER BY a.employee_id;
-- 14. 'Canada'���� �ٹ��ϰ� �ִ� ������ ���̵�, �̸�, �ҼӺμ� ���̵�, �ҼӺμ���, ��ġ ���̵�, ���ø�, �ּҸ� ��ȸ�ϱ�

SELECT a.employee_id, a.first_name, b.department_id, b.department_name, b.location_id, c.country_id, c.street_address
FROM employees A, departments B, locations C
WHERE a.department_id = b.department_id AND b.location_id = c.location_id
AND c.country_id = 'CA'
ORDER BY a.employee_id;

-- 15. ��� ������ �������̵�, �̸�, �������̵�, ��������, �޿�, �޿����, �ҼӺμ� ���̵�, �ҼӺμ���, ���ø��� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, a.job_id, b.job_title, a.salary, d.department_id, d.department_name, c.CITY, e.gra
FROM employees A, JOBS B, locations C, departments D, job_grades e
WHERE a.job_id = b.job_id AND a.department_id = d.department_id AND d.location_id = c.location_id
AND a.salary BETWEEN e.lowest_sal AND e.highest_sal
ORDER BY a.employee_id;
-- 16. �޿��� 5000�޷� ���Ϸ� �޴� �������� ���̵�, �̸�, ����, �ҼӺμ� ���̵�, �ҼӺμ���, �ҼӺμ� ������ �������̵�, 
--     �ҼӺμ� ������ �����̸��� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, a.job_id, a.salary, b.department_id, b.department_name, b.manager_id, c.first_name
FROM employees A, departments B, employees C
WHERE A.salary <= 5000
AND a.department_id = b.department_id
AND b.manager_id = c.employee_id
ORDER BY a.employee_id;

-- 17. 'Asia'������ �������� �ΰ� �ִ� �μ��� ���̵�, �μ���, �μ������� �̸��� ��ȸ�ϱ�

SELECT a.department_id, a.department_name, b.country_id, c.region_id, d.region_name
FROM departments A, locations B, countries C, regions D
WHERE a.location_id = b.location_id AND b.country_id = c.country_id
AND C.REGION_ID = D.REGION_ID
AND D.REGION_NAME = 'Asia';

-- 18. 101�� ������ �ٹ��ߴ� �μ����� �ٹ����� ������ ���̵�, �̸�, �μ����̵�, �μ����� ��ȸ�ϱ�

SELECT distinct c.employee_id, c.first_name, b.department_id, B.DEPARTMENT_NAME
FROM job_history A, DEPARTMENTS B, EMPLOYEES C
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID AND B.DEPARTMENT_ID = C.DEPARTMENT_ID
AND A.EMPLOYEE_ID = 101;


-- 19. �����߿��� �ڽ��� �����ϰ� �ִ� ������ �ְ�޿� 50%�̻��� �޿��� �ް� �ִ� 
--     ������ ���̵�, �̸�, �޿�, �������̵�, ���� �ְ�޿��� ��ȸ�ϱ�

SELECT a.employee_id, a.first_name, a.salary, a.job_id, b.max_salary
FROM employees A, JOBS B
WHERE A.JOB_ID = B.JOB_ID AND a.salary >= (b.max_salary / 2);

-- 20. �̱�(US)�� ��ġ�ϰ� �ִ� �μ��� ���̵�, �̸�, ��ġ��ȣ, ���ø�, �ּҸ� ��ȸ�ϱ�

SELECT b.department_id, b.department_name, a.location_id, a.city, a.street_address
FROM locations A, departments B
WHERE a.location_id = b.location_id 
AND A.country_id = 'US';


