SELECT USER_ID, USER_NAME, USER_GENDER, USER_EMAIL FROM BBS_USER WHERE USER_ID = 'dahun428';

--책에 대한 리뷰와 평점을 담은 테이블
CREATE TABLE SAMPLE_BOOK_REVIEWS(
    REVIEW_NO NUMBER(7,0) CONSTRAINT BOOK_REVIEWNO_PK PRIMARY KEY,
    REVIEW_CONTENT VARCHAR2(2000) CONSTRAINT REVIEWCONTENT_NN NOT NULL,
    REVIEW_POINT NUMBER(1,0) CONSTRAINT REVIEW_POINT_CK CHECK (REVIEW_POINT >=0 AND REVIEW_POINT <=5),
    REVIEW_REGISTERED_DATE DATE default sysdate,
    BOOK_NO NUMBER(7,0) constraint review_bookno_fk references sample_books (book_no),
    USER_ID VARCHAR2(50) constraint review_userid_fk references sample_book_users (user_id),
    constraint reviews_uk unique (book_no, user_id)
);
CREATE SEQUENCE SAMPLE_REVIEW_SEQ NOCACHE;
INSERT INTO SAMPLE_BOOK_REVIEWS
(REVIEW_NO, review_content, review_point, BOOK_NO, USER_ID)
VALUES
(SAMPLE_REVIEW_SEQ.NEXTVAL, 'GOOD' , 5, 10004, 'dahun428');
SELECT * FROM SAMPLE_BOOKS;
SELECT * FROM SAMPLE_BOOK_REVIEWS;
SELECT * FROM SAMPLE_BOOK_USERS;
INSERT INTO SAMPLE_BOOK_REVIEWS
(REVIEW_NO, review_content, review_point, BOOK_NO, USER_ID)
VALUES
(SAMPLE_REVIEW_SEQ.NEXTVAL, 'GOOD' , 4, 10009, 'HONG');
COMMIT;

select *from bbs_user;
select trunc(avg(review_point))
from sample_book_reviews;

CREATE TABLE SAMPLE_BOOK_QUESTION_LIKES (
    BOOK_NO NUMBER(7,0) NOT NULL, 
    USER_ID VARCHAR2(50) NOT NULL,
    CONSTRAINT LIKES_BOOKNO_FK FOREIGN KEY(BOOK_NO) REFERENCES SAMPLE_BOOKS(BOOK_NO),
    CONSTRAINT LIKES_USERID_FK FOREIGN KEY(USER_ID) REFERENCES SAMPLE_BOOK_USERS(USER_ID),
    CONSTRAINT LIKES_UK UNIQUE (BOOK_NO, USER_ID)
);
COMMIT;
select * from bbs_user;
INSERT INTO BBS_USER
VALUES('dahun429','1234','정다훈','남자','dahun428@naver.com');

ALTER TABLE BBS_USER ADD CONSTRAINT GENDER_CK CHECK(USER_GENDER IN('남자','여자'));
COMMIT ;

CREATE OR REPLACE VIEW EMP_SALARY_GRADE_VIEW 
AS SELECT A.EMPLOYEE_ID, A.FIRST_NAME, A.SALARY, B.GRA 
FROM employees A, job_grades B
WHERE A.SALARY BETWEEN B.LOWEST_SAL AND b.highest_sal; 

SELECT *
FROM emp_salary_grade_view;

CREATE OR REPLACE VIEW EMP_SALARY_VIEW 

AS SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY * 4 *12 + SALARY*NVL(commission_pct, 0) * 4 * 12 AS ANNUAL_SALARY 

FROM EMPLOYEES; 
SELECT * 
FROM emp_salary_view;

SELECT user_id
FROM BBS_USER
WHERE USER_ID = 'dahun428';

--인라인뷰 사용하기
--자신이 소속된 부서의 평균 급여보다 급여를 적게 받는 사원의 아이디, 이름, 급여, 부서

select * 
from employees
where department_id = 50
and salary < (select trunc(avg(salary)) from employees);

select trunc(avg(salary))
from employees;

select department_id, trunc(avg(salary))
from employees
group by department_id;

select a.employee_id, a.first_name || ' '|| a.last_name as fullname, a.salary, b.avg_sal
from employees a, (select department_id, trunc(avg(salary)) as avg_sal from employees where department_id is not null group by department_id) b
where a.department_id = b.department_id
and a.salary < b.avg_sal;

select * from employees a, avg_sal_deptId b where a.salary < b.avg_sal and a.department_id = b.department_id;

create or replace view avg_sal_deptId
as select department_id, trunc(avg(salary)) as avg_sal
from employees
where department_id is not null
group by department_id;

select *
from avg_sal_deptId;

select * 
from (select employee_id, first_name || ' ' || last_name fullname, salary, employees.department_id from employees)
where department_id = 50;

select * from bbs_user;

select a.department_id , a.department_name, b.city, c.cnt
from departments a, locations b, (select department_id dept_id, count(*) cnt from employees group by department_id) c
where a.department_id = c.dept_id
and a.location_id = b.location_id
order by a.department_id asc;

SELECT *
FROM sample_book_reviews;

COMMIT;
SELECT A.BOOK_NO, B.BOOK_TITLE, A.USER_ID, c.user_name, a.review_content, A.REVIEW_POINT, a.review_registered_date
FROM SAMPLE_BOOK_REVIEWS A, SAMPLE_BOOKS B, SAMPLE_BOOK_USERS C
WHERE a.book_no = B.BOOK_NO
AND A.USER_ID = C.USER_ID;  

SELECT A.BOOK_NO, B.BOOK_TITLE, A.USER_ID, c.user_name, a.review_content, A.REVIEW_POINT, a.review_registered_date
FROM SAMPLE_BOOK_REVIEWS A, SAMPLE_BOOKS B, SAMPLE_BOOK_USERS C
WHERE a.book_no = B.BOOK_NO
AND A.USER_ID = C.USER_ID
AND a.book_no = '10004';  
INSERT INTO sample_book_reviews VALUES (SAMPLE_REVIEW_SEQ.nextval, 'HI',4,SYSDATE,10009,'dahun428');

select * from sample_books;
select * from sample_books;
select * from sample_book_users;
SELECT A.BOOK_NO, B.BOOK_TITLE, A.USER_ID, c.user_name, a.review_content, 
								 A.REVIEW_POINT, a.review_registered_date 
						  FROM SAMPLE_BOOK_REVIEWS A, SAMPLE_BOOKS B, SAMPLE_BOOK_USERS C 
						  WHERE a.book_no = B.BOOK_NO AND A.USER_ID = C.USER_ID 
						  and A.user_id = 'dahun428';
UPDATE SAMPLE_BOOKS 
				SET 
			    BOOK_TITLE = ?, BOOK_WRITE = ?, BOOK_GENRE = ?, BOOK_DISCOUNT_PRICE = ?, 
			    book_publisher = ?, BOOK_PRICE = ?, BOOK_STOCK =?, BOOK_POINT = ? WHERE BOOK_NO =? ;
INSERT INTO sample_book_reviews 
				 VALUES 
				 (SAMPLE_REVIEW_SEQ.nextval, 'GOOD',4,SYSDATE,10004,'HONG');                 
                
SELECT * FROM SAMPLE_BOOK_REVIEWS;
SELECT * FROM SAMPLE_BOOKS;

SELECT * FROM BBS_USER;
DELETE FROM BBS_USER WHERE USER_ID = 'dahun429' AND USER_PASSWORD = '1234';

commit;



