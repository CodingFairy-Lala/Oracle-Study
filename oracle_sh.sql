--========================================
-- sh계정
--========================================
-- 사용자가 가진 table 조회

select * from tab;

-- 사원테이블
select * from employee;
-- 부서테이블
select * from department;
-- 지역테이블
select * from location;
-- 국가테이블
select * from nation;
-- 직급테이블
select * from job;
-- 급여등급테이블
select * from sal_grade;

-- table(entity, relation)데이터를 담고 있는 객체. 반드시 특정 사용자의 소유. 행/열로 구분
-- column (field, attribute) 열(속성). 테이블의 구조. 자료형/크기를 지정
-- row (record, tuple) 행. 테이블에 저장된 데이터 단위
-- domain 하나의 속성이 가질 수 있는 원자값의 집합

-- 테이블컬럼(열) 정보
desc employee;
--==================================================
-- DATA TYPE
--==================================================
-- 특정 열은 반드시 상응하는 자료형이 지정되어야 한다.
-- 문자형/숫자형/날짜형 등의 자료형을 제공한다.
----------------------------------------------------
-- 1. 문자형
----------------------------------------------------
-- (영문자/숫자 글자당 1byte, 한글 xe버전 3byte, ee버전 2byte)
-- char 고정길이 문자형(최대 2000byte)
   -- char(10) "korea" 입력시 "korea   " 실제 데이터는 5byte지만, 저장시에는 10byte로 처리
   -- char(10) "한국" 입력시 실제데이터는 6byte지만, 저장시에는 10byte로 처리
   -- char(10) "대한민국" 입력시 실제데이터는 12byte라서 최대크기 초과로 저장 실패!
-- varchar2 가변길이 문자형 (최대 4000byte)
   -- varchar(10) "korea" 입력시 "korea   " 실제 데이터는 5byte이고, 저장시에도 5byte로 처리
   -- varchar(10) "한국" 입력시 실제데이터는 6byte이고, 저장시에도 6byte로 처리
   -- varchar(10) "대한민국" 입력시 실제데이터는 12byte라서 최대크기 초과로 저장 실패!

-- long 가변길이 문자형 (최대 2gb)
-- clob character large object 가변길이 문자형 (최대 4gb)
-- nchar 글자수지정 고정길이 문자형
--   글자수지정 고정길이 문자형
   
create table tb_datatype_string(
 col_a char(10),
 col_b varchar(10)
);

select
 col_a,
 lengthb(col_a),
 col_b,
 lengthb(col_b),
 col_b
from
 tb_datatype_string;
 
-- 자동정렬 Ctrl + F7

-- 데이터추가 (행단위)
insert into
    tb_datatype_string
values (
    'korea','korea'
);

insert into
    tb_datatype_string
values (
    '한국','한국'
);

insert into
    tb_datatype_string
values (
    '대한민국','대한민국'
);


-----------------------------------------------------
-- 숫자형
-----------------------------------------------------
-- number 정수/실수를 모두 표현
-- number(p,s)
    --p 표현가능한 전체 자리수
    --s 소수점이하 자리수

-- 1234.567 값 처리시 반올림 적용
-- number(7,3) 1234.567
-- number(7,1) 1234.6
-- number(7) 1234
-- number(7, -1) 1230

create table tb_datatype_number (
    col_a number,
    col_b number(7, 3),
    col_c number(7, 1),
    col_d number(7),
    col_e number(7, -1)
);

select * from
    tb_datatype_number;

insert into
    tb_datatype_number
values(
    1234.567, 1234.567, 1234.567, 1234.567, 1234.567
);

----------------------------------------------------
-- 3. 날짜형
----------------------------------------------------
-- date 년/월/일/시/분/초  화면상에 년/월/일 정보만 표시
    -- date와 숫자 사이 연산 지원
        -- date +/- n n일 이후/이전 date 반환
    -- date와 date사이의 빼기 연산 지원
        -- date - date 두 날짜 사이의 일수 차이 반환
        
-- timestamp

--dual 1행짜리 가상테이블
select
    sysdate as "현재날짜", -- 현재날짜
    to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') as "now",
    to_char(sysdate +1, 'yyyy/mm/dd hh24:mi:ss') as "tomorrow",
    to_char(sysdate -1, 'yyyy/mm/dd hh24:mi:ss') as "yesterday",
    to_date('2023/04/07') as "수료일",
    to_date('2023/04/07') - sysdate as "d-day",
    systimestamp
from
    dual;
    
-- 변경된 내용을 실제 DB서버에 반영
commit; -- 변경사항 적용
--rollback; -- 변경사항 취소

