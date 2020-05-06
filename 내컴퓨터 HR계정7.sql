SELECT * FROM SAMPLE_BOOK_ORDERS;
SELECT * FROM SAMPLE_BOOK_USERS;
SELECT * FROM SAMPLE_BOOKS;

SELECT * FROM SAMPLE_BOOK_USERS;

INSERT INTO SAMPLE_BOOK_USERS(
    USER_ID, USER_PASSWORD, USER_NAME, USER_EMAIL, USER_POINT, USER_REGISTERED_DATE
)VALUES(
    'dahun428', '1234', '������', 'dahun428@naver.com', 1000, sysdate);
INSERT INTO SAMPLE_BOOK_USERS(
    USER_ID, USER_PASSWORD, USER_NAME, USER_EMAIL, USER_REGISTERED_DATE
)VALUES(
    'dahun427', '1234', '������', 'dahun428@naver.com', sysdate);

SELECT * FROM SAMPLE_BOOK_USERS WHERE USER_ID = 'dahun428';

create SEQUENCE sample_order_Seq start with 50000;
INSERT INTO SAMPLE_BOOK_ORDERS(
    ORDER_NO, USER_ID, BOOK_NO, ORDER_PRICE, ORDER_AMOUNT, ORDER_REGISTERED_DATE
)VALUES(
    SAMPLE_ORDER_SEQ.nextval, 'dahun428', 10009, 20000, 3, SYSDATE
);

SELECT * FROM SAMPLE_BOOK_ORDERS WHERE ORDER_NO = '50000';
SELECT * FROM SAMPLE_BOOK_ORDERS WHERE user_id = 'dahun428';

SELECT * FROM SAMPLE_BOOK_ORDERS;
SELECT * FROM SAMPLE_BOOKS;
SELECT * FROM SAMPLE_BOOK_USERS;