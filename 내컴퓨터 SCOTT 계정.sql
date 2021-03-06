
/* Drop Tables */

DROP TABLE SCHOOL_COURSE_REGISTRATIONS CASCADE CONSTRAINTS;
DROP TABLE SCHOOL_COURSES CASCADE CONSTRAINTS;
DROP TABLE SCHOOL_PROFESSORS CASCADE CONSTRAINTS;
DROP TABLE SCHOOL_STUDENTS CASCADE CONSTRAINTS;
DROP TABLE SCHOOL_SUBJECTS CASCADE CONSTRAINTS;
DROP TABLE SCHOOL_DEPT CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE SCHOOL_COURSES
(
	COURSE_NO number(4,0) NOT NULL,
	SUBJECT_NO number(4,0) NOT NULL,
	-- 교수의 교유한 번호
	PROF_NO number(4,0) NOT NULL,
	COURSE_NAME varchar2(200) NOT NULL,
	-- 과정별 최대 수강 인원수이다.
	-- 기본값은 30이다.
	-- 최대 인원수는 100명이다.
	COURSE_QUATA number(3,0) DEFAULT 30 NOT NULL,
	-- 해당 과정을 신청한 학생 수이다.
	-- 수강신청정보가 추가될때마다, 1씩 증가시켜야한다.
	COURSE_REG_CNT number(3,0) DEFAULT 0,
	-- REG_CNT가 'Y'가 되면 1씩 증가시킨다.
	COURSE_CANCLE_CNT number(3,0) DEFAULT 0,
	COURSE_CLOSED char(1) DEFAULT 'N',
	COURSE_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (COURSE_NO)
);


CREATE TABLE SCHOOL_COURSE_REGISTRATIONS
(
	REG_NO number(5,0) NOT NULL,
	-- 학생의 고유한번호
	STUD_NO number(4,0) NOT NULL,
	COURSE_NO number(4,0) NOT NULL,
	-- 수강 신청취소 여부는 'Y','N'으로 지정한다. 기본값은 'N'이다.
	REG_CANCLED char(1) DEFAULT 'N',
	-- 수강신청 수료여부는 'Y','N'으로 지정한다. 기본값은 'N'이다.
	REG_COMLETED char(1) DEFAULT 'N',
	-- 평가점수는 0.0 ~ 4.5이다. 기본값은 NULL이다.
	REG_SCORE number(2,1),
	REG_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (REG_NO),
	CONSTRAINT COURSE_REG_UK UNIQUE (STUD_NO, COURSE_NO)
);


CREATE TABLE SCHOOL_DEPT
(
	-- 학과의 고유한 번호
	DEPT_NO number(4,0) NOT NULL,
	-- 학과의 고유한 이름
	DEPT_NAME varchar2(100) NOT NULL,
	SUBJECT_NO number(4,0) NOT NULL,
	PRIMARY KEY (DEPT_NO)
);


CREATE TABLE SCHOOL_PROFESSORS
(
	-- 교수의 교유한 번호
	PROF_NO number(4,0) NOT NULL,
	-- 학과의 고유한 번호
	DEPT_NO number(4,0) NOT NULL,
	-- 교수의 고유한 이름
	PROF_NAME varchar2(100) NOT NULL,
	-- 조교수, 부교수, 정교수, 겸임교수 석좌교수 등의 값이 가능하다.
	PROF_POSITION varchar2(50),
	PROF_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (PROF_NO)
);


CREATE TABLE SCHOOL_STUDENTS
(
	-- 학생의 고유한번호
	STUD_NO number(4,0) NOT NULL,
	-- 학과의 고유한 번호
	DEPT_NO number(4,0) NOT NULL,
	STUD_NAME varchar2(100) NOT NULL,
	STUD_GRADE number(1) NOT NULL,
	STUD_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (STUD_NO)
);


CREATE TABLE SCHOOL_SUBJECTS
(
	SUBJECT_NO number(4,0) NOT NULL,
	-- 학과의 고유한 번호
	DEPT_NO number(4,0) NOT NULL,
	SUBJECT_NAME varchar2(200) NOT NULL,
	SUBJECT_CREATE_DATE date,
	PRIMARY KEY (SUBJECT_NO)
);



/* Create Foreign Keys */

ALTER TABLE SCHOOL_COURSE_REGISTRATIONS
	ADD FOREIGN KEY (COURSE_NO)
	REFERENCES SCHOOL_COURSES (COURSE_NO)
;


ALTER TABLE SCHOOL_PROFESSORS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_STUDENTS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_SUBJECTS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_COURSES
	ADD FOREIGN KEY (PROF_NO)
	REFERENCES SCHOOL_PROFESSORS (PROF_NO)
;


ALTER TABLE SCHOOL_COURSE_REGISTRATIONS
	ADD FOREIGN KEY (STUD_NO)
	REFERENCES SCHOOL_STUDENTS (STUD_NO)
;


ALTER TABLE SCHOOL_COURSES
	ADD FOREIGN KEY (SUBJECT_NO)
	REFERENCES SCHOOL_SUBJECTS (SUBJECT_NO)
;



