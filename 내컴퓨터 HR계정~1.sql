UPDATE employees
SET SALARY = salary + 500;
SELECT * FROM employees;

UPDATE employees
SET salary = salary + 500
WHERE department_id = 90;

SELECT * FROM employees WHERE department_id = 90;

SELECT * FROM sample_books;

UPDATE sample_books
SET
    BOOK_TITLE = '이것이 자바 개정판',
    book_price = 40000,
    book_discount_price = 38000,
    book_write = '정',
    BOOK_GENRE = '공포',
    BOOK_PUBLISHER = '정출판사'
WHERE BOOK_NO = 10009;

SELECT employee_id, salary, department_id
FROM employees
WHERE salary IN (SELECT MIN(SALARY)
                FROM employees);
UPDATE employees
SET 
    salary = ( SELECT TRUNC(AVG(SALARY))
                FROM employees
                WHERE department_id = 50)
WHERE employee_id = 132
;

UPDATE employees
SET 
    salary = ( SELECT TRUNC(AVG(SALARY))
            FROM employees
            WHERE department_id = 50 )
WHERE employee_id IN (SELECT EMPLOYEE_ID 
                        FROM employees
                        WHERE salary IN (SELECT MIN(salary)
                                        FROM employees));             
SELECT TRUNC(AVG(SALARY))
FROM employees
WHERE department_id = 50;
SELECT *
FROM employees
WHERE department_id = 50;
       
UPDATE employees
SET
    department_id = 500
WHERE department_id = 100;
SELECT *
FROM employees;
SELECT *
FROM sample_book_USERS;
DELETE FROM sample_book_users
WHERE USER_ID = 'dahun427';

CREATE TABLE COPY_SAMPLE_BOOK_USERS (
    USER_ID VARCHAR2(50) PRIMARY KEY,
    USER_PASSWORD VARCHAR2(50),
    USER_NAME VARCHAR2(100), 
    USER_EMAIL VARCHAR2(256),
    USER_POINT NUMBER(10,0),
    USER_REGISTERED_DATE DATE
);
INSERT INTO copy_sample_book_users(
USER_ID, USER_PASSWORD, USER_NAME, USER_EMAIL, USER_POINT, user_registered_date)
SELECT USER_ID, user_password, user_name, user_email, user_point, user_registered_date
FROM sample_book_users;

SELECT * FROM COPY_SAMPLE_BOOK_USERS;

INSERT INTO sample_book_USERS
VALUES ('RU','456','김장철','DFD@FMM',10,SYSDATE);
INSERT INTO sample_book_USERS
VALUES ('LA','GALBI','또또비','FFF@W',100,SYSDATE);

SELECT * FROM sample_book_users;

MERGE INTO COPY_SAMPLE_BOOK_USERS B
      USING SAMPLE_BOOK_USERS A
      ON ( A.USER_ID = B.USER_ID)
WHEN MATCHED THEN
    UPDATE SET
        B.USER_PASSWORD = A.USER_PASSWORD,
        B.USER_NAME = A.USER_NAME,
        B.USER_EMAIL = A.USER_EMAIL,
        B.USER_POINT = A.USER_POINT,
        B.USER_REGISTERED_DATE = A.USER_REGISTERED_DATE
WHEN NOT MATCHED THEN
    INSERT VALUES ( A.USER_ID ,A.USER_PASSWORD, A.USER_NAME, A.USER_EMAIL, A.USER_POINT, A.USER_REGISTERED_DATE);

SELECT * FROM copy_sample_book_users;
commit;

UPDATE SAMPLE_BOOK_USERS
SET 
    user_password = 'fff',
    user_email='fff'
WHERE USER_ID = 'dd';
SELECT *
FROM SAMPLE_BOOK_USERS;
SELECT *
FROM SAMPLE_BOOKS;

SELECT *
FROM SAMPLE_BOOK_ORDERS;

SELECT a.order_no, a.user_id, b.user_name,a.book_no, c.book_title, c.book_discount_price, a.order_registered_date, a.order_price, a.order_amount
FROM sample_book_orders A, sample_book_users B, SAMPLE_BOOKS C
WHERE a.user_id = b.user_id
AND A.USER_ID = 'dahun428'
AND c.book_no = a.book_no;

INSERT INTO SAMPLE_BOOK_USERS (
    USER_ID,USER_PASSWORD, USER_NAME, USER_EMAIL, USER_REGISTERED_DATE)
    VALUES ( '하양','깜장','다훈','어럴',SYSDATE);
COMMIT;
SELECT * FROM SAMPLE_BOOKS;
UPDATE SAMPLE_BOOKS
SET
    BOOK_TITLE = '이',
    BOOK_WRITE ='2',
    BOOK_GENRE ='3',
    BOOK_DISCOUNT_PRICE =40000,
    book_publisher = '5',
    BOOK_PRICE =300000,
    BOOK_STOCK =99
WHERE BOOK_NO = 10004;    
