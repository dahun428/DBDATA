SELECT * FROM JOB_HISTORY;
--���� ������ ����ϱ�
--��� ����� ���� �� ������ �ٹ��ߴ� ������ ��ȸ�ϱ�
--��� ���� �ѹ� ���� ǥ���ϱ�
SELECT EMPLOYEE_ID , JOB_ID  -- ���� �ٹ� ���� ���� ��ȸȭ��
FROM employees 
UNION 
SELECT employee_id, job_id  -- ������ �ٹ��ߴ� ���� ��ȸ�ϱ�
FROM job_history;

-- ��� ����� ���� �μ� ���̵�� ���� �Ҽ� �μ� ���̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID , employees.department_id  -- ���� �ٹ� ���� ���� ��ȸȭ��
FROM employees 
UNION all
SELECT employee_id, job_history.department_id  -- ������ �ٹ��ߴ� ���� ��ȸ�ϱ�
FROM job_history;

-- ���� �����ϴ� ������ ���� �������� �����ϰ� �ִ� ����� ���̵�� �������̵� ��ȸ�ϱ�
SELECT employees.employee_id, JOB_ID FROM employees INTERSECT SELECT job_history.employee_id,JOB_ID FROM job_history;

SELECT a.employee_id, a.job_id FROM employees A, JOB_HISTORY B WHERE a.employee_id = b.employee_id AND A.JOB_ID = b.job_id ORDER BY a.employee_id;
SELECT * FROM job_history ;
SELECT a.employee_id, b.first_name FROM (
SELECT employees.employee_id FROM employees MINUS SELECT job_history.employee_id FROM job_history) A, employees B WHERE a.employee_id = b.employee_id ORDER BY 1;

--¡���� ����� ������ ����� ���̵�, �̸� ��ȸ
SELECT a.employee_id, b.first_name, b.job_id, c.department_name FROM(SELECT employees.employee_id FROM employees MINUS SELECT job_history.employee_id FROM job_history) A, employees B, departments C
WHERE a.employee_id = b.employee_id AND b.department_id = c.department_id;

--��� ����� ���� �� ������ �ٹ��ߴ� ������ ��ȸ�ϱ�
--��� ���̵�,����, �޿��� ��ȸ�ϱ�
SELECT a.employee_id, a.job_id, b.salary FROM (
SELECT employees.employee_id, employees.job_id FROM employees
UNION
SELECT job_history.employee_id, job_history.job_id FROM JOB_HISTORY) A , employees B WHERE a.employee_id = b.employee_id;
