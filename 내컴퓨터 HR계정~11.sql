--1. �޿��� 5000�̻� 12000������ ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary FROM employees WHERE salary BETWEEN 5000 AND 12000 ORDER BY salary DESC;
--2. ������� �Ҽӵ� �μ��� �μ����� �ߺ����� ��ȸ�ϱ�
SELECT DISTINCT b.department_name FROM employees A, departments B WHERE a.department_id = b.department_id AND b.department_name IS NOT NULL; 
--3. 2007�⿡ �Ի��� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT * FROM employees WHERE hire_date BETWEEN TO_DATE('20061231', 'YYYYMMDD') AND TO_DATE('20080101','YYYYMMDD') ORDER BY hire_date DESC;
--4. �޿��� 5000�̻� 12000�����̰�, 20���� 50�� �μ��� �Ҽӵ� ����� ���̵�, �̸�, �޿�, �ҼӺμ����� 
--   ��ȸ�ϱ�
SELECT A.employee_id, A.first_name, A.salary, b.department_name 
FROM employees A, departments B 
WHERE A.salary BETWEEN 5000 AND 12000 
AND A.department_id IN (20,50) 
AND b.department_id = a.department_id ORDER BY salary;
--5. 100�������� �����ϴ� ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, a.salary, b.gra FROM employees A, JOB_GRADES B WHERE manager_id = 100 AND a.salary BETWEEN b.lowest_sal AND b.highest_sal;
--6. 80�� �μ��� �ҼӵǾ� �ְ�, 80�� �μ��� ��ձ޿����� ���� �޿��� �޴� ����� ���̵�, �̸�, 
--   �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary FROM employees WHERE department_id = 80 AND salary < (SELECT TRUNC(AVG(salary)) FROM employees WHERE department_id = 80);
--7. 50�� �μ��� �Ҽӵ� ��� �߿��� �ش� ������ �ּұ޿����� 2�� �̻��� �޿��� �޴� ����� ���̵�, 
--   �̸�, �޿��� ��ȸ�ϱ�

SELECT A.EMPLOYEE_ID, A.FIRST_NAME, A.SALARY 
FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID 
        FROM employees 
        WHERE department_id = 50) A, JOBS B 
WHERE a.salary > (B.min_salary * 2) 
AND a.job_id = b.job_id;
--8. ����� �߿��� �ڽ��� ��纸�� ���� �Ի��� ����� ���̵�, �̸�, �Ի���, ����� �̸�, 
--   ����� �Ի����� ��ȸ�ϱ�

SELECT * FROM employees A, EMPLOYEES B WHERE A.HIRE_DATE < b.hire_date AND a.employee_id = b.manager_id;
SELECT b.employee_id, b.first_name, b.hire_date, a.first_name AS ����̸�, a.hire_date AS ����Ի��� 
FROM employees A, employees B 
WHERE a.employee_id = b.manager_id 
AND b.hire_date < a.hire_date;

--9. Steven King�� ���� �μ����� �ٹ��ϴ� ����� ���̵�� �̸��� ��ȸ�ϱ�
SELECT employee_id, first_name||' '||last_name as name, department_id FROM employees WHERE department_id = (SELECT department_id FROM employees WHERE first_name ||' '|| last_name= 'Steven King');
--10. �����ں� ������� ��ȸ�ϱ�, ������ ���̵�, ������� ����Ѵ�. ������ ���̵������ �������� ����
SELECT a.employee_id,COUNT(A.EMPLOYEE_ID) AS ����� 
FROM employees A, employees B 
WHERE a.employee_id = b.manager_id 
GROUP BY a.employee_id 
ORDER BY a.employee_id ASC;


--11. Ŀ�̼��� �޴� ����� ���̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
SELECT employee_id, first_name, salary, commission_pct 
FROM employees 
WHERE commission_pct 
IS NOT NULL ORDER BY commission_pct DESC;


--12. �޿��� ���� ���� �޴� ��� 3���� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT b.employee_iD, b.first_name, b.salary 
FROM ( SELECT ROWNUM, EMPLOYEE_ID, FIRST_NAME, SALARY 
        FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY 
                FROM employees 
                ORDER BY salary DESC)
        WHERE ROWNUM <=3) A, employees B
WHERE a.employee_id = b.employee_id;
--13. 'Ismael'�� ���� �ؿ� �Ի��߰�, ���� �μ��� �ٹ��ϴ� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees 
where to_char(hire_date, 'yyyy') = (select to_char(hire_date, 'yyyy') 
                                    from employees 
                                    where first_name = 'Ismael')
and department_id = (select department_id
                        from employees
                        where first_name = 'Ismael');
                        
--14. 'Renske'���� ����޴� ����� ���̵�� �̸�, �޿�, �޿� ����� ��ȸ�ϱ�
select * from employees A, employees B where a.employee_id = b.manager_id and b.manager_id = 'Renske';
select employee_id, first_name, salary, b.gra 
from employees A, job_grades B 
where employee_id = (select manager_id 
                        from employees 
                        where first_name = 'Renske') 
and a.salary BETWEEN b.lowest_sal and b.highest_sal;


--15. ������̺��� �޿��� �������� �޿������ ��ȸ���� ��, �޿���޺� ������� ��ȸ�ϱ�
SELECT B.GRA, COUNT(b.gra) 
FROM employees A, JOB_GRADES B 
WHERE a.salary BETWEEN B.LOWEST_SAL AND b.highest_sal 
GROUP BY B.GRA 
ORDER BY B.GRA; 


--16. �Ի��ڰ� ���� ���� �⵵�� �� �ؿ� �Ի��� ������� ��ȸ�ϱ�
SELECT MIN(YEAR_CNT) AS MIN_HIRE_COUNT
FROM (SELECT TO_CHAR(HIRE_DATE,'YYYY') YEAR,COUNT(TO_CHAR(HIRE_DATE, 'YYYY')) YEAR_CNT 
      FROM employees 
      GROUP BY TO_CHAR(HIRE_DATE,'YYYY'));
--17. �����ں� ������� ��ȸ���� �� �������ϴ� ������� 10���� �Ѵ� �������� ���̵�� ������� ��ȸ�ϱ�
SELECT a.employee_id, COUNT(A.EMPLOYEE_ID) CNT 
FROM employees A, employees B 
WHERE a.employee_id = b.manager_id 
GROUP BY a.employee_id 
HAVING COUNT(A.EMPLOYEE_ID) >= 10; 


--18. 'Europe'�������� �ٹ����� ����� ���̵�, �̸�, �ҼӺμ���, ������ ���ø�, �����̸��� ��ȸ�ϱ�
SELECT a.employee_id, a.first_name, b.department_name, c.city, e.region_name FROM employees A, departments B,LOCATIONS C, COUNTRIES D,regions E 
WHERE a.department_id = b.department_id 
AND b.location_id = c.location_id 
AND c.country_id = d.country_id 
AND d.region_id = e.region_id
AND e.region_name = 'Europe';

--19. ��ü ����� ������̵�, �̸�, �޿�, �ҼӺμ����̵�, �ҼӺμ���, ����� �̸��� ��ȸ�ϱ�
select a.employee_id, a.first_name, a.salary, a.department_id, b.department_name, c.first_name
from employees a, departments b, employees c 
where a.department_id = b.department_id 
and a.manager_id = c.employee_id 
order by a.employee_id;

--20. 50�� �μ��� �ٹ����� ������� �޿��� 500�޷� �λ��Ű��
select employee_id, first_name, salary, salary + 500 as Up_sal from employees where department_id = 50;


--21. ����� ���̵�, �̸�, �޿�, ���ʽ��� ��ȸ�ϱ�,
--    ���ʽ��� 20000�޷� �̻��� �޿��� 10%, 10000�޷� �̻��� �޿��� 15%, �� �ܴ� �޿��� 20%�� �����Ѵ�.
select employee_id, first_name, salary,
        case when salary > 20000 then salary * 0.1
             when salary > 10000 then salary * 0.15
        else salary *0.2
        end as bonus
from employees;

--22. �ҼӺμ����� �Ի����� ������, �� ���� �޿��� �޴� ����� �̸�, �Ի���, �ҼӺμ���, �޿��� ��ȸ�ϱ�

select DISTINCT a.employee_id, a.first_name, a.hire_date, a.salary, a.department_id, c.department_name
from employees a, employees b, departments c
where a.department_id = b.department_id
and a.department_id = c.department_id
and a.hire_date > b.hire_date
and a.salary > b.salary
ORDER BY a.employee_id;

--23. �μ��� ��ձ޿��� ��ȸ���� �� �μ��� ��ձ޿��� 10000�޷� ������ �μ��� ���̵�, �μ���, ��ձ޿���
--    ��ȸ�ϱ� (��ձ޿��� �Ҽ��� 1�ڸ������� ǥ��)
select trunc(avg(A.salary),1) from employees A, departments B where a.department_id = b.department_id group by A.department_id having trunc(avg(A.salary),1) < 10000;
select b.department_id, a.department_name, b.average
from departments A, (select a.department_id, trunc(avg(a.salary),1) average 
                        from employees a, departments b 
                        where a.department_id = b.department_id 
                        group by a.department_id
                        having trunc(avg(a.salary),1) < 10000) b 
where a.department_id = b.department_id;

--24. ����� �߿��� �ڽ� �����ϰ� �ִ� ������ �ִ�޿��� ������ �޿��� �޴� ����� ���̵�, �̸�, �޿���
--    ��ȸ�ϱ�
select a.employee_id, a.first_name, a.salary from employees A, jobs B where a.job_id = b.job_id and a.salary = b.max_salary;

----25. �м��Լ��� ����ؼ� ������� �޿������� �����ϰ�, ������ �ο����� �� 6~10��° ���ϴ� ����,
--    ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�

select num, a.employee_id, a.first_name, a.salary, a.gra
from (select row_number() over(order by A.salary desc) num, A.employee_id, A.first_name, A.salary, b.gra 
        from employees A, job_grades B 
        where A.salary between B.lowest_sal and b.highest_sal) A
where num BETWEEN 6 and 10;
