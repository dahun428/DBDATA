SELECT * FROM BBS_USER;

UPDATE BBS_USER SET user_password = '5678', user_email = '11@22' WHERE USER_ID = 'dahun427' AND USER_PASSWORD = '1234';

--50�� �μ��� �Ҽӵ� ��� �߿��� �޿��� ���� ���� �޴� ���� 3����ȸ
SELECT ROWNUM, SALARY, FIRST_NAME
FROM (SELECT SALARY, FIRST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID = 50 ORDER BY SALARY DESC)
WHERE ROWNUM <=3;

-- �μ��� ������� ������� �� ������� ���� ���� �μ� 3���� ��ȸ�ϱ�

SELECT ROWNUM, DEPARTMENT_ID, CNT
FROM (SELECT department_id, COUNT(*) CNT
        FROM employees
    GROUP BY department_id
    ORDER BY CNT DESC)
WHERE ROWNUM <=3;

--�μ��� ������� ������� �� ������� ���� ���� �μ� 3���� ��ȸ�ϱ�
--�μ� ���̵�, �μ���, �����
SELECT ROWNUM, A.DEPARTMENT_ID, b.department_name, A.CNT
FROM (SELECT department_id, COUNT(*) CNT
        FROM employees
    GROUP BY department_id
    ORDER BY CNT DESC) A, departments B
WHERE ROWNUM <=3
AND a.department_id = b.department_id;

SELECT b.ranking, b.cnt, a.department_id, a.department_name
FROM departments A, (SELECT ROWNUM RANKING, DEPARTMENT_ID, CNT
                    FROM (SELECT department_id, COUNT(*) CNT
                            FROM employees
                        GROUP BY department_id
                        ORDER BY CNT DESC)
                    WHERE ROWNUM <=3) B
WHERE a.department_id = b.department_id;

select * from sample_books;
select book_no, book_title, book_price 
from sample_books 
order by book_price desc;

select rownum, book_no, book_title, book_price
from (select book_no, book_title, book_price 
        from sample_books 
        order by book_price desc)
where rownum <= 3;

select * from sample_books;
select *
from sample_book_users;
select * from sample_book_orders;

select a.user_id, c.user_name, b.book_title, a.order_amount, a.order_registered_date, b.book_price
from sample_book_orders a, sample_books b, sample_book_users c
where a.book_no = b.book_no
and a.user_id = c.user_id
order by book_price desc;

select ROWNUM, user_id, user_name, book_title, order_amount, order_registered_date
from ( select a.user_id, c.user_name, b.book_title, a.order_amount, a.order_registered_date, b.book_price
        from sample_book_orders a, sample_books b, sample_book_users c
        where a.book_no = b.book_no
        and a.user_id = c.user_id
        order by book_price desc)
where ROWNUM <= 3
and order_registered_date > sysdate - 10;

select * from sample_book_orders where order_registered_date > sysdate -7;
select order_registered_date > sysdate - 7 from sample_book_orders where order_registered_date > sysdate - 7;

--���� �Ѿ��� ������� �� �����Ѿ��� ���� ���� ������� 
-- ���̵�, �̸�, �� ���� �ݾ��� ��ȸ�ϱ�

SELECT ROWNUM, USER_ID, USER_NAME, TOTAL
FROM (SELECT A.USER_ID, B.USER_NAME, TOTAL
        FROM (SELECT USER_ID, SUM(order_price) TOTAL 
                FROM SAMPLE_BOOK_ORDERS
                GROUP BY USER_ID) A, SAMPLE_BOOK_USERS B 
        WHERE a.user_id = B.USER_ID
        ORDER BY TOTAL DESC)
WHERE ROWNUM = 1;



SELECT A.USER_ID, B.USER_NAME, TOTAL
FROM (SELECT USER_ID, SUM(order_price) TOTAL 
        FROM SAMPLE_BOOK_ORDERS
        GROUP BY USER_ID) A, SAMPLE_BOOK_USERS B 
WHERE a.user_id = B.USER_ID
ORDER BY TOTAL DESC;


SELECT * FROM SAMPLE_BOOK_ORDERS;
SELECT * FROM SAMPLE_BOOK_USERS;

SELECT *
FROM SAMPLE_BOOK_ORDERS A, SAMPLE_BOOK_USERS B
WHERE A.USER_ID = B.USER_ID;


SELECT SUM(A.ORDER_PRICE)
FROM SAMPLE_BOOK_ORDERS A, SAMPLE_BOOK_USERS B
WHERE A.USER_ID = B.USER_ID;

SELECT DISTINCT(A.USER_ID), B.USER_NAME, A.ORDER_PRICE
FROM SAMPLE_BOOK_ORDERS A, SAMPLE_BOOK_USERS B
WHERE A.USER_ID = B.USER_ID
GROUP BY DISTINCT(A.USER_ID);

SELECT * FROM SAMPLE_BOOK_USERS;
SELECT * FROM employees GROUP BY;
SELECT * FROM employees;


--���� �Ѿ��� ������� �� �����Ѿ��� ���� ���� ������� 
-- ���̵�, �̸�, �� ���� �ݾ��� ��ȸ�ϱ�

SELECT USER_ID, SUM(ORDER_PRICE*ORDER_AMOUNT) TOTAL_PRICE
FROM SAMPLE_BOOK_ORDERS
GROUP BY USER_ID
ORDER BY TOTAL_PRICE DESC;

SELECT USER_ID, TOTAL_PRICE
FROM (SELECT USER_ID, SUM(ORDER_PRICE*ORDER_AMOUNT) TOTAL_PRICE
        FROM SAMPLE_BOOK_ORDERS
        GROUP BY USER_ID
        ORDER BY TOTAL_PRICE DESC)
WHERE ROWNUM = 1;

SELECT *
FROM SAMPLE_BOOK_USERS A, (SELECT USER_ID, TOTAL_PRICE
                            FROM (SELECT USER_ID, SUM(ORDER_PRICE*ORDER_AMOUNT) TOTAL_PRICE
                                    FROM SAMPLE_BOOK_ORDERS
                                    GROUP BY USER_ID
                                    ORDER BY TOTAL_PRICE DESC)
                            WHERE ROWNUM = 1) B
WHERE A.USER_ID = B.USER_ID;

--�м� �Լ� ����ϱ�
--�޿��� �������� �����ؼ� ���� �ο��ϱ�
SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC), SALARY, FIRST_NAME
FROM EMPLOYEES;

--�޿��� �������� �������� �����ؼ� ������ �ο����� �� �ְ� �޿��� �޴� 3����
-- ����, ���̵�, �̸�, �޿��� ��ȸ�ϱ�

SELECT * 
FROM( SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) RANKING,employee_id, FIRST_NAME, SALARY
        FROM EMPLOYEES)
WHERE RANKING BETWEEN 11 AND 20;

SELECT * FROM employees;
--�μ����� �޿��� �������� �������� �����ؼ� ������ �ο��ϱ�
SELECT LANK, DEPARTMENT_ID FROM(
SELECT ROW_NUMBER() OVER(ORDER BY A.SALARY DESC) LANK, A.SALARY, A.FIRST_NAME, A.DEPARTMENT_ID, b.department_name FROM EMPLOYEES A, DEPARTMENTS B WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID 
) GROUP BY DEPATMENT_ID;

SELECT * FROM EMPLOYEES;

SELECT
    ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) NUM, DEPARTMENT_ID, SALARY, FIRST_NAME
FROM
    EMPLOYEES;
--�μ����� �޿��� �������� �������� �����ؼ� ������ �ο����� ��
--�ش� �μ����� ���� �޿��� ���� �޴� ������
--�̸�, �޿�, �μ� ���̵� ��ȸ�ϱ�
SELECT * FROM(
SELECT ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) RANKING, FIRST_NAME, SALARY, DEPARTMENT_ID FROM EMPLOYEES
) WHERE RANKING = 1;

SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) ROW_NUMBER,
             RANK() OVER(ORDER BY SALARY DESC) RANK,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) DENSE_RANK,
            SALARY
FROM EMPLOYEES;

--row_number() over()�� Ȱ���ؼ� �����͸� Ư�� �÷����� �������� �������� ������ ��ȸ�ϱ�
SELECT *
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY EMPLOYEE_ID ASC) NUM, EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES)
WHERE NUM BETWEEN 1 AND 10;
SELECT *
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY EMPLOYEE_ID ASC) NUM, EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES)
WHERE NUM BETWEEN 11 AND 20;

SELECT FIRST_VALUE(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC), DEPARTMENT_ID, SALARY, FIRST_NAME FROM EMPLOYEES ORDER BY DEPARTMENT_ID DESC;
commit;

select sample_order_seq.nextval from dual;
select sample_order_seq.currval from dual;
select * from bbs_user;

select employee_id, rowid
from employees;

select * from bbs_user;

select * from employees where first_name = 'Steven';
select * from employees where last_name = 'King';

create index sample_user_name_idx
on sample_book_users (user_name);

select * from sample_book_users where user_name = 'ȫ�浿';
select * from bbs_user;

drop index sample_user_name_idx;

create index sample_order_date_idx
on sample_book_orders (to_char(order_registered_date, 'yyyy-mm-dd'));

select * from sample_book_orders
where to_char(order_registered_date, 'yyyy-mm-dd')= '2020-04-23';
select * from sample_book_orders;

SELECT user_password FROM BBS_USER WHERE USER_ID = 'dahun424';
select * from bbs_user;

COMMIT;

