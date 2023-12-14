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
rollback; -- 변경사항 취소


--=====================================
-- DQL
--=====================================
-- Data Query Language
-- DML의 하위 개념. 테이블의 데이터를 검색하기 위한 SQL
-- 0행 이상의 결과집합(Result Set)이 반환됨.
-- 특정 행/특정 컬럼에 대해서 조회가 가능하다.
-- 특정 컬럼 기준으로 정렬이 가능하다.


/*
    (5) select 컬럼... -> 조회하고자 하는 컬럼
    (1) from 테이블명 -> 조회하고자 하는 테이블
    (2) where 조건절 -> 조회하고자 하는 행을 필터링 할 수 있는 조건절
    (3) group by 컬럼... -> 행 단위 그룹핑
    (4) having 조건절 -> 그룹핑 된 결과에 대해 필터링
    (6) order by 컬럼... -> 특정 컬럼 기준으로 정렬
*/

-- job에서 job name 컬럼만 출력
select
    job_name
from
    job;
    
-- department에서 내용 전체 출력
select
    *
from
    department;

-- employee에서 이름, 이메일, 전화번호, 입사일 출력
select
    EMP_NAME, EMAIL, PHONE, HIRE_DATE
from
    employee;

-- employee에서 사번, 이름, 급여 출력
select
    EMP_no, emp_name, salary
from
    employee;

-- employee에서 급여가 250만원 이상인 사원들의 사번, 이름, 급여 출력
select
    *
from
    employee
where
    salary >= 2500000;


-- employee에서 현재 근무중인 사원의 이름을 오름차순으로 출력 asc : 오름차순 / dexc : 내림차순
select
    *
from
    employee
where
    quit_yn = 'N'
order by
    emp_name asc;

----------------------------------------------------------
-- select
----------------------------------------------------------
-- 가상 컬럼(산술 연산)이 가능
select
    emp_name, salary, salary*12, 100
from
    employee;
-- 별칭(alias) 가능
-- as "별칭" : as 생략 가능, 쌍타옴표 생략 가능
-- 숫자로 시작하거나, 공백/특수문자가 포함된 경우는 쌍다옴표를 반드시 작성해야 한다.
select
    emp_name as "이 름",
    salary as 급여
from
    employee;

-- null 값에 대한 처리
-- null값과는 산술연산 (+ - * /) 할 수 없다.

-- 보너스 포함 급여 조회
select
    emp_name, salary, bonus,
    nvl(bonus, 0),
    salary + (salary * nvl(bonus, 0)) "보너스 포함 급여"
from
    employee;

-- nvl() null 처리 함수
-- nvl(col, value) : col 값이 null인 경우, value 반환

-- employee에서 사번, 사원명, 급여, 보너스, 연봉(보너스 적용) 출력
select
    emp_id, emp_name, salary, bonus,
    (salary + (salary * nvl(bonus,0)))*12 "ANNUAL SALARY"
from
    employee;

-- 중복값 제거 distinct
-- 컬럼에 중복된 값을 한번씩만 표현. select 뒤에 단 한번만 사용
select distinct
    job_code,
    dept_code
from
    employee;

-- 문자열 연결연산자 || 
select
    emp_name,
--  salary + '원'
    salary || '원'
from
    employee;

select
    12+34,
    '12' + '34' -- 문자열이지만, 숫자로 자동형변환 처리 된 후 더하기 연산됨
from
    dual;

----------------------------------------------------------
-- where
----------------------------------------------------------
-- 특정 테이블의 행을 필터링. 특정 컬럼의 값의 조건절을 작성.
-- boolean 으로 처리가 되며, true 가 나온 행만 결과 집합에 포함된다.
-- 동등연산 = 
-- 부정 동동연산 !=  <>  ^=
-- 비교연산 > < >= <=
-- 범위연산 between and
-- 문자패턴 비교연산 [not] like
-- null 여부 연산 is [not] null
-- 포함여부 연산 [not] in
-- 논리연산 and or
-- 반전연산 not

-- 부서코드가 D6이고 급여가 300만원보다 많은 사원의 사번, 사원명, 부서코드, 급여 조회
select
    emp_id, emp_name, dept_code, salary
from
    employee
where
    dept_code = 'D6' and salary > 3000000;

-- 부서코드가 D5 또는 D6이고 급여가 300만원보다 많은 사원의 사번, 사원명, 부서코드, 급여 조회
select
    emp_id, emp_name, dept_code, salary
from
    employee
where
    (dept_code =  'D5' or dept_code = 'D6') and salary > 3000000;

-- 부서코드가 D9 이 아닌 사원 조회
select
    *
from
    employee
where
    dept_code != 'D9';
--  dept_code <> 'D9';
--  dept_code ^= 'D9';

-- 20년 이상 근속한 사원의 사원명과 입사일 조회
-- 날짜 - 날짜 = 숫자(1 = 하루)
select
    emp_name, hire_date
from
    employee
where
    sysdate - hire_date > (365*20) 
    and
    quit_yn = 'N';

-- 직급코드가 J1이 아닌 사원들의 급여등급(sal_level)을 중복없이 출력
select distinct
    sal_level
from
    employee
where
    job_code != 'J1';
    
-- 급여가 3500000 이상 6000000원 이하인 사원의 사원명, 급여 조회
select
    emp_name, salary
from
    employee
where
    salary >= 3500000 
    and 
    salary <= 6000000;

-- between 최소값 and 최대값
-- 최소값 이상이면서 최대값 이하인 값에 대해 true를 반환
select
    emp_name, salary
from 
    employee
where
    salary between 3500000 and 6000000;

-- 날짜에 대한 범위 조회
-- 입사일이 1990/01/01 ~ 2000/12/31 인 사원 조회
select
    emp_name, hire_date
from 
    employee
where
--    hire_date between to_date('1990/01/01') and to_date('2000/12/31');
    hire_date between '1990/01/01' and '2000/12/31';

-- 오라클이 처리 가능한 기본 날짜형식 - 다음과 같이 문자열 작성하면 날짜타입으로 처리 가능
-- yyyy/mm/dd
-- yyyy-mm-dd
-- yyyymmdd
-- yyyy mm dd

-- 날짜타입은 크기비교 연산 가능
-- 2000/01/01 이후 입사자 조회
select
    emp_name, hire_date
from
    employee
where
    hire_date > '2000/01/01';
    
-- 문자열 패턴 비교연산 like
-- 비교하려는 컬럼값이 특정 패턴을 만족시키면 true를 반환
-- % _ 와일드카드(파싱될 때 특수한 의미를 지니는 문자) 사용
-- % : 0 개 이상의 문자를 의미
-- _ : 딱 1 개의 아무 문자를 의미 

-- 전씨 성을 가진 사원 조회
select
    emp_name
from
    employee
where
    emp_name like '전%'; -- 전으로 시작하고 0 개 이상의 문자열이 뒤따르는 값 검색. 

-- 이름에 '옹'이 들어가는 사원조회
select
    *
from
    employee
where
    emp_name like '%옹%';

-- 이메일 _ 앞글자가 3개인 이메일 조회
select
    email
from 
    employee
where
    email like '___\_%' escape '\'; -- escape 문자 선택은 자유롭지만, 보통 \(역슬래시) 사용할 것.
    
-- 전화번호 앞자리가 010 이 아닌 사원 조회
select
    emp_name, phone
from 
    employee
where
    phone not like '010%';

-- 이메일 '_' 앞 문자가 4글자이고, 부서코드는 D9 또는 D5이면서, 입사일은 1990/01/01 ~ 2001/12/31 이고, 급여가 270만원 이상인 사원 조회
select
    *
from 
    employee
where
    email like '____\_%' escape '\'
    and
    (dept_code = 'D9' or dept_code = 'D5')
    and
    hire_date between '1990/01/01' and '2001/12/31'
    and
    salary >= 2700000;

-- in 연산자 : 제시된 값 목록에 컬럼값이 포함되어 있으면 true 반환
-- D6, D8, D9 사원 조회 
select
    emp_name, dept_code
from
    employee
where
--    dept_code = 'D6' or dept_code = 'D8' or dept_code = 'D9';
    dept_code in ('D6', 'D8', 'D9');

select
    emp_name, dept_code
from
    employee
where
--    dept_code not in ('D6', 'D8', 'D9');
    dept_code != 'D6' and dept_code <> 'D8' and dept_code ^= 'D9';

-- dept_code가 null인 사원 조회 : is null
select
    *
from
    employee
where
    dept_code is not null;

-- D6, D8 부서원과 인턴사원을 조회
select
    *
from
    employee
where
--    dept_code in('D6', 'D8') or dept_code is null;
    nvl(dept_code, 'D0') in('D6', 'D8', 'D0');


------------------------------------------------------------
-- order by
------------------------------------------------------------
-- DQL 처리중 가장 마지막에 정렬 지원
-- 특정 컬럼 기준 오름차순/내림차순, null값을 처음/마지막에 배치
-- 컬럼명/별칭/컬럼순서를 통해 특정 컬럼 지정 가능

-- 오름차순(asc) 기본값
-- 숫자 오름차순 / 내림차순
-- 문자열 오름차순 (사전 등재순) / 내림차순 (사전 등채 역순)
-- 날짜셩 오름차순 (과거 ~ 미래) / 내림차순 (미래 ~ 과거)
select
    *
from
    employee
order by
    emp_name desc;

-- 급여 내림차순
select
    *
from
    employee
order by
    salary desc;

-- 부서 오름차순
select
    *
from
    employee
order by
--    dept_code asc nulls first;
    dept_code, emp_name;

-- 별칭, 컬럼 순서로 지정
select
    emp_id 사번,
    emp_name 사원명,
    salary 급여
from
    employee
where
    salary >= 2000000
order by
--    급여 desc;
    2 asc;

--=========================================================
-- functions
--=========================================================
-- 일련의 수행 절차를 함수 객체로 만들고, 이를 호출해 사용함.
-- SQL의 function 은 무조건 하나의 값을 반환함.

-- 단일행 처리 함수 : 행별로 처리되는 함수
    -- 1. 문자 처리 함수
    -- 2. 숫자 처리 함수수
    -- 3. 날짜 처리 함수
    -- 4. 형변환 함수
    -- 5. 기타 함

-- 그룹 함수 : 여러 행을 그룹짓고, 그룹당 한번만 실행되는 함수

------------------------------------------------------------
-- 단일행 처리 함수
------------------------------------------------------------

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 1. 문자 처리 함수
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- length(col) : 컬럼값의 길이를 반환
select
    emp_name, length(emp_name),
    email, length(email)
from
    employee;
    
-- 이메일의 길이가 15글자 미만인 사원 조회
select
    emp_name, email
from
    employee
where
    15 > length(email);

-- instr(col, search, [start], [occurence]) : col에서 검색된 search 의 인덱스를 반환
-- SQL의 인덱스는 1부터 시작
select
    instr('kh정보교육원 국가정보원 정보문화사', '정보'), -- 3
    instr('kh정보교육원 국가정보원 정보문화사', '정보', 5), -- 11
    instr('kh정보교육원 국가정보원 정보문화사', '정보', 5, 2), -- 15
    instr('kh정보교육원 국가정보원 정보문화사', '정보', -1), -- 15환
    instr('kh정보교육원 국가정보원 정보문화사', 'ㅋㅋㅋ') -- 값이 없을때에는 0을 반환
from
    dual;

-- @실습문제 1. EMPLOYEE 테이블에서 이름, 연봉(월급*12), 총수령액(보너스포함연봉), 실수령액(총 수령액-(월급*세금 3%))가 출력되도록 하시오 (컬럼명을 지정한 별칭으로 변경)
select 
    emp_name 연봉,
    (salary +(salary*nvl(bonus, 0)))*12 총수령액,
    ((salary +(salary*nvl(bonus, 0)))*12) - (salary*0.3) 실수령액
from
    employee;

-- @실습문제 2. EMPLOYEE 테이블에서 이름, 입사일, 근무 일수(입사한지 몇일인가)를 출력해보시오.
select 
    emp_name 이름,
    hire_date 입사일,
    sysdate - hire_date 근무일수
from
    employee;
    
-- @실습문제 3. tbl_escape_watch 테이블에서 description 컬럼에 99.99% 라는 글자가 들어있는 행만 추출하세요.
    create table tbl_escape_watch(
        watchname   varchar2(40)
        ,description    varchar2(200)
    );
    --drop table tbl_escape_watch;
    insert into tbl_escape_watch values('금시계', '순금 99.99% 함유 고급시계');
    insert into tbl_escape_watch values('은시계', '고객 만족도 99.99점를 획득한 고급시계');
    commit;
    select * from tbl_escape_watch;
    
select
    description
from
    tbl_escape_watch
where
    description like '%99.99\%%' escape '\';

commit;


-- substr 문자열의 일부를 잘라내 반환하는 함수
-- substr(col,position, [length])
select
    substr('show me the money', 6,2), -- me
    substr('show me the money', 6), -- me the money
    substr('show me the money', 13), -- money
    substr('show me the money', -5) -- money
from
    dual;

-- email 컬럼의 @앞의 아이디값만 조회
-- instr - substr

select
    email,
    instr(email, '@') -1 "아이디 글자수",
    substr(email, 1, instr(email, '@')-1) "아이디"
from
    employee;

-- 여백채우기 함수 : lpad - 왼쪽 채우기 | rpad - 오른쪽 채우기
-- lpad(col, n, pad_str) 왼쪽에 여백으로 채워진 문자열 반환
select
    email,
    lpad(email, 20, '#'),
    rpad(email, 20, '#'),
    lpad(email, 20),
    rpad(email, 20)
from
    employee;

-- 주문전표 생성
-- kh-221025-0001
select
    'kh-'||to_char(sysdate,'yymmdd')||'-'||lpad(1,4,'0'),
    'kh-'||to_char(sysdate,'yymmdd')||'-'||lpad(10,4,'0'),
    'kh-'||to_char(sysdate,'yymmdd')||'-'||lpad(999,4,'0')
from
    dual;

-- replace 특정문자열을 대체해서 반환
-- replace(col, old_str, new_str)
select
    replace('hello world', 'hello', 'byebye'),
    replace('honggd@naver.com', 'naver.com', 'gamil.com')
from
    dual;

select
    email,
    replace(email, 'kh.or.kr', 'kh.com')
from
    employee;

-- employee에서 남자사원만 사번, 사원명, 주민번호 출력
-- 주민번호는 뒤 6자리는 *로 처리 900909-1******
select
    emp_id,
    emp_name,
    substr(emp_no,1,8)||'******' emp_no
from
    employee
where
    emp_no like '%-1%'
    or
    emp_no like '%-3%' ;

select
    emp_id,
    emp_name,
    substr(emp_no,1,8)||'******' emp_no
from
    employee
where
    substr(emp_no, 8, 1) in ('1', '3');

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 2. 숫자처리
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- abs : 절대값 반환함수
select
    abs(123), abs(-123)
from
    dual;

-- mod : 나머지 함수
-- % 나머지 연산자 대신 사용
-- mod(피젯수, 제수)
select
    mod(10,3), mod(4,2)
from
    dual;

-- 생일이 짝수인 사원만 조회 (사번, 사원명, 생년월일)
select
    emp_id,
    emp_name,
    substr(emp_no,1,6) birthday
from
    employee
where
    mod(substr(emp_no,5,2),2) = 0;
    
-- ceil : 올림함수
-- floor : 버림함수
-- round : 반올림함수, 소수점 이하 처리 가능
-- trunc : 버림함수, 소수점 이하 처리 가능
select
    ceil(123.456), -- 124
    ceil(123.456*100) / 100, -- 123.46
    floor(123.456), -- 123
    floor(123.456*100) / 100 -- 123.45
from
    dual;
    
select
    round(123.456), -- 123
    round(123.456, 1), -- 123.5
    round(123.456, 2), -- 123.46
    round(123.456, -1), -- 120
    trunc(123.456), -- 123
    trunc(123.456, 1), -- 123.4
    trunc(123.456, -1) -- 120
from
    dual;
    
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 날짜처리함수
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- sysdate
-- systimestamp
select
    sysdate,
    systimestamp
from
    dual;
    
-- add_months : 특정 날짜에 인자만큼 더하거나 뺀 날짜 반환
-- add_months(date, n)
select
    add_months(sysdate, 1),
    add_months(sysdate, -1),
    add_months(sysdate, 12),
    add_months(to_date('220131'), 1),
    add_months(to_date('220228'), 1),
    add_months(to_date('220329'), -1)
from
    dual;

-- months_between : 두 날짜의 개월수 차이(숫자)를 반환
-- months_between(미래날짜, 과거날짜)
select
    months_between(to_date('221125'), sysdate), -- 1
    trunc(months_between(to_date('230407'), sysdate))
from
    dual;
    
-- employee 에서 근무개월수 조회(사원명, 근무개월1, 근무개월수2)
-- 근무개월수1 (n개월)
-- 근무개월수2 (k년 i개월)
select
    emp_name,
    trunc(months_between(sysdate, hire_date))||'개월' "근무개월1",
    trunc(months_between(sysdate, hire_date)/12)||'년 '||mod(trunc(months_between(sysdate, hire_date)),12)||'개월' "근무개월2"
from
    employee
where
    quit_yn = 'N';

-- extract 날짜에서 특정 단위의 정보만 추출해 숫자를 반환하는 함수
-- extract(단위 from date | timestamp)
select
    extract(year from sysdate) year,
    extract(month from sysdate) month,
    extract(day from sysdate) day,
    extract(hour from cast(sysdate as timestamp)) hour,
    extract(minute from cast(sysdate as timestamp)) minute,
    extract(second from cast(sysdate as timestamp)) second
from
    dual;

-- 2001년 입사자만 조회
select
    emp_name,
    hire_Date
from
    employee
where
    extract(year from hire_Date) = 2001;

-- trunc : 날짜관련 특정 단위를 제거하는 함수
-- trunc(날짜, [단위]) : 시분초 제거
select
    to_char(sysdate, 'yyyy-mm--dd hh24:mi:ss'),
    to_char(trunc(sysdate), 'yyyy-mm--dd hh24:mi:ss')
from
    dual;

select
    sysdate - hire_date
from
    employee;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 4. 형변환 함수
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
        to_char      to_date
        -------->   -------->
    number      char        date
        <-------    <--------
        to_number    to_char

*/

-- to_char(number, foramt_str)
-- 0 숫자 하나. 해당 자리의 숫자가 없을때 소수점 이상 0, 소수점 이하 0으로 표시.
-- 9 숫자 하나. 해당 자리의 숫자가 없을때 소수점 이상 공백, 소수점 이하 0으로 표시.
-- L 지역 화폐 단위
-- FM 포멧팅으로 생긴 공백 문자, 0 등을 제거
select
    1234567890,
    to_char(1234567890, 'FML999,999,999,999'),
    to_char(1234567890, 'FML000,000,000,000'),
    123.456,
    to_char(123.456, 'FM999,999.999999'),
    to_char(123.456, 'FM000,000,000000'),
    to_char(123.456, '999,999.999999')
from
    dual;

-- 사원명, 급여, 보너스율 조회
-- 급여 3자리 콤마 적용
-- 보너스율 % 로 표시
-- 입사일은 1999년 9월 9일 (목)
select
    emp_name 사원명,
    to_char(salary, 'FML999,999,999,999') 급여,
    nvl(bonus, 0)*100 || '%' 보너스율,
    to_char(hire_date, 'FMyyyy"년" mm"월" dd"일 ("dy")"') 입사일
from
    employee;


-- to_char(date, format_str)
select
    to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')
from
    dual;

-- to_date 특정 형식의 문자열을 날짜로 변환
-- to_date(date_Str, [format_str])
select
    to_date('1999/09/09 11:25:30', 'yyyy/mm/dd/hh24:mi:ss'),
    to_char(to_date('1999/09/09 11:25:30', 'yyyy/mm/dd/hh24:mi:ss'), 'hh24:mi:ss')
from
    dual;
    
-- "2018/02/08 12:23:50"을 날짜타입으로 변환하고, 3시간 뒤를 출력하라
select
    to_char(
        to_date('2018/02/08 12:23:50', 'yyyy/mm/dd/hh24:mi:ss') + 3/24,
        'yyyy/mm/dd hh24:mi:ss'
    )
from
    dual;

-- to_number 문자열을 숫자로 변환하는 함수
-- to_number(num_str, format_str)
select
    to_char(1234567, 'FML999,999,999'),
    to_number('￦1,234,567', 'L999,999,999') +1
from
    dual;

-- 현재 시각으로부터 1년 2개월 3일 4시간 5분 6초 뒤를 출력하라
-- yyyy/mm/dd hh24:mi:ss
select
    to_char(
        add_months(sysdate, 14)+ 3 + 4/24 + 5/24/60 + 6/24/60/60,
        'yyyy/mm/dd hh24:mi:ss'
    )
--    to_char(
--        to_date(sysdate, 'yyyy/mm/dd hh24:mi:ss') + 365 + 60 + 3 + 4/24 + 5/24/60 + 6/24/60/60,
--        'yyyy/mm/dd hh24:mi:ss'
--    )
from
    dual;

-- interval 자료형
-- 기간을 나타내는 자료형
-- interval year to month
-- interval day to second

-- to_yminterval(부호 yy-mm)
-- to_dsinterval (부호 day hh:mi:ss)
select
    to_char(
        current_date + to_yminterval('+1-02') + to_dsinterval('+03 04:05:06'),
        'yyyy/mm/dd hh24:mi:ss'
    )
from
    dual;
    
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 기타함수
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- null 처리 함수
-- nvl(col, value)
-- nvl2 (col, value1, value2) : col값이 null이 아니면 value1 반환, null이면 value2 반환
select
    emp_name,
    bonus,
    nvl2(bonus, 'O', 'X') "보너스 여부"
from
    employee;
    
-- 선택함수 decode여별
-- decode(표현식, 표현식값1, 결과값1, 표현식값2, 결과값2, ..., [(optional)기본값])

--  성별 출력
select
    emp_name,
    emp_no,
    decode(substr(emp_no, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여') 성별,
    decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') 성별
from
    employee;

-- 여자만 출력
select
    emp_name,
    emp_no,
    decode(substr(emp_no, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여') 성별
from
    employee
where  
    decode(substr(emp_no, 8, 1),'1', '남', '2', '여', '3', '남', '4', '여') = '여' ;
    
select
    emp_name,
    job_code,
    salary,
    decode(job_code, 'J7', salary*1.08, 'J6', salary*1.07, 'J5', salary*1.05, salary*1.03) 인상급여
from
    employee;
    
-- 선택함수 case
-- 타입 1 : 조건식 사용
/*
    case
        when 조건식1 then 결과값1
        when 조건식2 then 결과값2
        ...
        [else 기본값]
    end
*/
select
    emp_name,
    emp_no,
    case
        when substr(emp_no, 8, 1) = '1' then '남'
        when substr(emp_no, 8, 1) = '2' then '여'
        when substr(emp_no, 8, 1) = '3' then '남'
        when substr(emp_no, 8, 1) = '4' then '여'
    end "성별",
        case
        when substr(emp_no, 8, 1) = '2' then '여'
        when substr(emp_no, 8, 1) = '4' then '여'
        else '남'
    end "성별"
from
    employee;

select
    merit_rating,
    salary,
    case
        when merit_rating = 'A' then salary*0.2
        when merit_rating = 'B' then salary*0.15
        when merit_rating = 'C' then salary*0.1
        else 0
    end "BONUS"
from
    employee;

-- 타입 2 : 표현식 사용
/*
    case 표현식
        when 표현식값1 then 결과값1
        when 표현식값2 then 결과값2
        ...
        [else 기본값]
    end
*/

select
    emp_name,
    case substr(emp_no, 8, 1)
        when '1' then '남'
        when '2' then '여'
        when '3' then '남'
        when '4' then '여'
    end as "성별",
    case substr(emp_no, 8, 1)
        when '2' then '여'
        when '4' then '여'
        else '남'
    end "성별"
from
    employee;

-- 나이 조회
-- 현재 나이 = 현재 년도 - 출생 년도 + 1
select
    emp_name,
    extract(year from sysdate) 현재년도,
    extract(year from to_date(substr(emp_no, 1, 2), 'yy')) 실패_출생년도,
    extract(year from to_date(substr(emp_no, 1, 2), 'rr')) 실패_출생년도,
    decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2) 출생년도,
    extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1 "(한국)나이"
from
    employee;

select 
  to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss'), 
  to_char(current_date, 'yyyy/mm/dd hh24:mi:ss')
from dual;

------------------------------------------------------------------
-- 그룹함수
------------------------------------------------------------------
-- 그룹단위로 실행하는 함수.
-- 총합, 평균, 개수, 최대값, 최소값
-- group by 없이 사용하면 모든 행을 하그룹으로 간주해 처리
-- 그룹함수와 일반 컬럼값은 동시에 사용할 수 없다.

-- sum 총합을 반환하는 함수
-- sum(col)
-- col 값이 null인 경우 계산에서 아예 제외
select
    sum(salary)
from
    employee;

-- 부서코드가 D5인 사원들의 급여 합을 조회
select
    sum(salary),
    sum(salary+(salary * nvl(bonus, 0))) -- 가상컬럼
from
    employee
where
    dept_code = 'D5';

-- 남자사원/여자사원의 급여 합계 조회
-- 남자사원     여자사원
-----------------------
-- xxxxxx    yyyyyy

select
    emp_name,
    emp_no,
    salary,
    decode(substr(emp_no, 8, 1), '1', salary, '3', salary, 0) "salary of men", -- 가상컬럼
    decode(substr(emp_no, 8, 1), '2', salary, '4', salary, 0) "salary of wemen" -- 가상컬럼

from
    employee;

select
    sum(decode(substr(emp_no, 8, 1), '1', salary, '3', salary, 0)) "남자 급여의 합",
    sum(decode(substr(emp_no, 8, 1), '2', salary, '4', salary, 0)) "여자 급여의 합"
from
    employee;
    
-- avg 특정 컬럼의 평균값을 구하는 그룹함수
-- avg(col)
select
    trunc(avg(salary)),
    avg(bonus), -- 보너스를 받는 사원들의 평균
    avg(nvl(bonus, 0)) -- 전체사원의 보너스 평균
from
    employee;

-- 남자사원의 급여평균, 여자사원의 급여평균
select
    trunc(avg(decode(substr(emp_no, 8, 1), '1', salary, '3', salary))) "남자 급여 평균",
    trunc(avg(decode(substr(emp_no, 8, 1), '2', salary, '4', salary))) "여자 급여 평균"
    --avg(case when substr(emp_no, 8, 1) in 
from
    employee;

-- D5/D9 부서원 급여 평균 조회
select
    trunc(avg(decode(substr(dept_code, 1), 'D5', salary))) "D5 부서원 급여 평균",
    trunc(avg(decode(substr(dept_code, 1), 'D9', salary))) "D9 부서원 급여 평균"
from
    employee;

-- count : 값이 있는 컬럼 수를 반환
-- count(col)
select
    count(*), -- 행의 수
    count(salary),
    count(bonus)
from
    employee;

-- 부서에 속한 사원 수
select
    count(dept_code),
    sum(case when dept_code is not null then 1 end)
from
    employee;

-- max/min 해당 컬럼에서 최대값/최소값을 반환
-- max(col) min(col)
-- 숫자/날짜/문자열
select
    max(salary), min(salary),
    max(hire_date), min(hire_date),
    max(emp_name), min(emp_name)
from
    employee;


--===========================================================
-- DQL2
--===========================================================
-- group by 컬럼 : 특정 컬럼 값이 동일한 행을 하나의 그룹으로 묶어서 처리. 
    -- group by 를 사용하면 select절에는 그룹함수와 지정한 컬럼만 사용 가능.
-- having 조건절 : 그룹핑된 결과에 대한 조건절

-------------------------------------------------------------
-- group by
-------------------------------------------------------------
-- 지정한 컬럼별로 행을 그룹핑
-- 예) 부서별 급여 평균. 성별 인원수. 부서별 직급별 급여평균. 입사년도별 인원수...

-- 부서별 평균급여
select
    dept_code,
    trunc(avg(salary)),
    count(*)
from
    employee
group by
    dept_code;

-- 직급별 인원수 조회
select
    job_code,
    count(*)
from 
    employee
group by
    job_code
order by
    job_code;
    
-- 부서별 보너스를 받는 사원 조회
select
    dept_code,
    count(bonus)
from 
    employee
group by
    dept_code
order by
    dept_code;
    
select
    dept_code,
    count(*)
from 
    employee
where
    bonus is not null
group by
    dept_code
order by
    dept_code;

-- 입사년도 별 사원수 조회
select
    extract(year from hire_date)"입사년도",
    count(*)
from
    employee
group by
    extract(year from hire_date)
order by
    입사년도;
    
-- 성별 인원수 조회
SELECT
    decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') "성별",
    count(*)
FROM
    employee
group by
    decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여');

-- 두개 이상의 컬럼을 대상으로 그룹핑 가능 (컬럼 순서는 중요치 않다)
-- 부서별 직급별 인원수 조회
select
    dept_code,
    job_code,
    count(*)
from
    employee
group by
    dept_code, job_code
order by
    1, 2;

-- 부서별 성별 인원수 조회
select
    dept_code,
    decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여') "성별",
    count(*)
from
    employee
group by
    dept_code, decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여')
order by
    1, 2;

--------------------------------------------------------------
-- having
--------------------------------------------------------------
-- 그룹핑된 결과집합에 대한 조건절
-- where 실제 테이블 행에 대한 조건절

-- 부서별 급여평균을 조회하되 300만원 이상인 부서만 조회
SELECT
    dept_code,
    trunc(avg(salary)) "부서별 급여 평균"
FROM
    employee
group by
    dept_code
having
    trunc(avg(salary)) >= 3000000
order by
    1;

-- 부서별 인원수가 3명 이상인 부서와 인원수 조회
select
    dept_code,
    count(*) "부서별 인원 수"
from
    employee
group by
    dept_code
having
    count(*) >= 3
order by
    1;

-- 부하직원이 2명 이상인 관리자 사원의 아이디와 부하 직원수 조회
SELECT
    manager_id,
    count(*)
FROM
    employee
where
    manager_id is not null
group by
    manager_id
having
    count(*) >= 2
order by
    1;
    
SELECT
    manager_id,
    count(*)
FROM
    employee
group by
    manager_id
having
    count(manager_id) >= 2
order by
    1;

-------------------------------------------------------------------
-- rollup | cube
-------------------------------------------------------------------
-- 그룹핑된 결과에 대한 소계를 계산하는 함수
-- rollup 지정한 컬럼에 대해서 단방향 소계 제공
-- cube 지정한 컬럼에 대해서 양방향 소계 제공
-- 그룹핑 컬럼이 하나인 경우, rollup과 cube는 같다.
select
    nvl(job_code, '총계'),
    count(*)
from
    employee
group by
    rollup(job_code)
order by
    1, 2;

-- grouping 함
-- 실제 데이터와 rollup/cube에 의해 생성된 집계데이터를 구분하는 함수수
-- 실제 데이터인 경우 0을 반환, 집계 데이터인 경우에는 1을 반환턴
select
    decode(grouping(dept_code), 0, nvl(dept_code, '인턴'), 1, '합계'),
    -- grouping(dept_code),
    count(*)
from
    employee
group by
    rollup(dept_code)
order by
    1;

-- 성별 인원수 조회 (총계를 포함)
select
    nvl(decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여'),'합계') 성별,
    count(*)
from
    employee
group by
    rollup(decode(substr(emp_no, 8, 1), '1', '남', '3', '남', '여'));

-- 부서별 직급별 인원수 조회 (소계 포함)
-- rollup : dept_code, job_code 에 대해 전체, dept_code에 대한 소계를 제공
-- cube : dept_code, job_code 에 대해 전체, dept_code, job_code에 대한 소계를 제공
select
    decode(grouping(dept_code), 0, nvl(dept_code,'인턴'),1,'합계') dept_code,
    nvl(job_code, '합계') job_code,
    count(*)
from
    employee
group by
    rollup(dept_code, job_code)
order by
    1, 2;

select
    dept_code,
    job_code,
    count(*)
from
    employee
group by
    cube(dept_code, job_code)
order by
    1, 2;
    
    -- chun계정 생성
alter session set "_oracle_script" = true;

create user chun
identified by cchhuunn1324A
default tablespace users; 

alter user chun quota unlimited on users;

grant connect, resource to chun;

commit;

--=======================================================
-- join
--=======================================================
-- 두개 이상의 테이블(entity)의 레코드를 연결해서 가상테이블(relation)을 생성
-- 기준 컬럼을 비교해서 행단위로 합쳐지게 된다.

-- 조인구분
    -- 1. equi join : 조인 조건절에 동등비교연산(=)을 사용한 조인
    -- 2. non_equi join : 조인 조건절에 동등비교연산을 사용하지 않은 조인 (!=, >, <, between and, in...)

-- 조인문법 구분
    -- 1. DBMS 전용문법 - 오라클 전용문법
    -- 2. ANSI 표준문법 - 모든 DBMS에서 사용 가능한 문법

-- equi join 구분
    -- 1. inner join 내부조인
    -- 2. outer join 외부조인
        -- LEFT OUTER JOIN
        -- RIGHT OUTER JOIN
        -- FULL OUTER JOIN
    -- 3. cross join 크로스조인
    -- 4. self join 자기조인
    -- 5. multiple join 다중조인


-- 송중기가 근무하는 부서는?
-- employee.dept_code
select
    *
from
    employee
where
    emp_name = '송종기';

select
    *
from
    department
where
    dept_id = 'D9';

-- 조인을 통한 relation 생성
select
    dept_title
from
    employee join department
        on dept_code = dept_id
where
    emp_name = '송종기';

-------------------------------------------------------------
-- INNER JOIN
-------------------------------------------------------------
-- 기본조인
-- inner 키워드 생략가능
-- 좌우측 테이블에서 기준컬럼이 null이거나, 상대테이블에 매칭되는 행이 없다면 결과집합에서 제외된다.
select
    *
from
    employee e join department d -- 테이블 별칭 (as 사용 불가)
        on e.dept_code = d.dept_id;
-- employee.dept_code가 null인 2행 재외
-- department의 D2, D3, D7 3행은 매칭되는 행이 없어 제외됨

--[oracle 전용 문법]
select
    *
from
    employee e, department d
where
    e.dept_code = d.dept_id;

-------------------------------------------------------------
-- OUTER JOIN
-------------------------------------------------------------
-- 외부조인. 좌우측 한쪽 테이블의 행을 포함시키는 조인
-- outer 키워드 생략 가능
-- left outer join : 왼쪽 테이블의 모든 행을 포함
-- right outer join : 오른쪽 테이블의 모든 행을 포함
-- full outer join : 양쪽 테이블의 모든 행을 포함

-- left outer join
-- 상대테이블에 상응하는 행이 없는 경우, 모두 null값 처리해서 연결한다.
-- 24행 : 22행 + 2행(하동운, 이오리)
select
    *
from
    employee e left outer join department d
        on e.dept_code = d.dept_id;

--[oracle 전용 문법]
select
    *
from
    employee e, department d
where
    e.dept_code = d.dept_id(+); -- 기준 테이블 반대쪽 컬럼에 (+)를 작성


-- right outer join
-- 25행 : 22행 + 3행 (D3, D4, D7)
select
    *
from
    employee e right outer join department d
        on e.dept_code = d.dept_id;
--[oracle 전용 문법]
select
    *
from
    employee e, department d
where
    e.dept_code(+) = d.dept_id; -- 기준 테이블 반대쪽 컬럼에 (+)를 작성


-- full outer join
-- 27행 : 22행 + 2행 + 3행
select
    *
from
    employee e full outer join department d
        on e.dept_code = d.dept_id;
--[oracle 전용 문법]
-- full outer join은 지원하지 않는다.
    
    
-- chun 계정
-- 1. 의학계열 학과 학생들의 학번/학생명/학과명 조회

-- 2. 2005학년도 입학생의 학생명/담당교수명 조회

-- 3. 자연과학계열의 수업명, 학과명 조회

-- 4. 담당학생이 한명도 없는 교수 조회

----------------------------------------------------------
-- cross join
----------------------------------------------------------합
-- Cartesian's product (카테시안의 곱)
-- 모든 경우의 수, 두 테이블의 조인 가능한 모든 경우를 결과집합으로 집
select
    *
from
    employee e cross join department d -- 216행 (24 * 9)
order by
    e.emp_id, d.dept_id;
--[oracle 전용 문법]
select
    *
from
    employee e, department d;


-- 사원별 평균급여와의 차이 조회 (사원명, 급여, 평균급여, 급여차)
select 
    trunc(avg(salary)) avg_sal
from
    employee;

select
    e.emp_name,
    e.salary,
    v.avg_sal,
    e.salary - v.avg_sal diff
from
    employee e cross join (select trunc(avg(salary)) avg_sal from employee) v;

-- 부서별 평균급여와의 차이 조회
-- employee join 부서별 평균급여 가상 테이블
-- 사원명 / 급여 / 부서코드 / 부서별평균급여 / 급여차이
select
    e.emp_name 사원명,
    e.salary 급여,
    nvl(e.dept_code, '인턴') 부서코드,
    v.avg_sal "부서별 평균급여",
    e.salary - v.avg_sal 급여차이
from
    employee e left join (select nvl(dept_code, 'D0') dept_code, trunc(avg(salary)) avg_sal from employee group by dept_code) v
        on nvl(e.dept_code, 'D0') = v.dept_code
order by
    e.dept_code;

----------------------------------------------------------
-- SELF JOIN
----------------------------------------------------------
-- 같은 테이블을 좌우에 두고 조인
-- 같은 테이블의 다른 행과 조인하게 된다.

-- 외부조인을 한 경우, 끝까지 외부조인을 유지해야 한다.
-- 조인되는 테이블의 순서가 중요하다.

-- 사번 / 사원명 / 관리자사번 / 관리자명 조회
select
    e1.emp_id,
    e1.emp_name,
    e2.emp_id,
    e2.emp_name
from
    employee e1 left join employee e2
        on e1.manager_id = e2.emp_id;
--[oracle 전용 문법]
select
    e1.emp_id,
    e1.emp_name,
    e2.emp_id,
    e2.emp_name
from
    employee e1, employee e2
where
    e1.manager_id = e2.emp_id(+); -- 기준 테이블 반대쪽 컬럼에 (+)를 작성


-------------------------------------------------------------
-- MULTIPLE JOIN
-------------------------------------------------------------
-- 다중조인. 2개 이상의 테이블 조인
-- 한번에 두개씩 여러번 조인

-- 사원명 / 부서명 / 지역명 / 국가명 조회
select * from employee;
select * from department;
select * from location;
select * from nation;

select 
    e.emp_name,
    j.job_name,
    d.dept_title,
    l.local_name,
    n.national_name
from 
    employee e 
    join job j
        on e.job_code = j.job_code
    left join department d
        on e.dept_code = d.dept_id
    left join location L
        on d.location_id = L.local_code
    left join nation n
        on L.national_code = n.national_code;

-- 사원명 / 직급명
select
    e.emp_name,
    j.job_name,
--    j.job_code -- ORA-25154: USING 절의 열 부분은 식별자를 가질 수 없음
    job_code
from
    employee e join job j
--        on e.job_code = j.job_code;
        using (job_code); -- 기존 컬럼명이 같은 경우에만 using 사용가능.
--[oracle 전용 문법]
-- from 절의 테이블 조인 순서를 상관치 않는다.
select
    *
from
    employee e, department d, location l, nation n, job j
where
    e.dept_code = d.dept_id (+)
    and
    d.location_id = L.local_code (+)
    and
    l.national_code = n.national_code (+)
    and
    e.job_code = j.job_code;


SELECT
    EMP_NAME, EMP_NO, DEPT_CODE, SALARY
FROM
    EMPLOYEE
WHERE
    (DEPT_CODE='D9' OR DEPT_CODE='D6')
    AND
    SALARY > 3000000
    AND
    EMAIL LIKE '___\_%' escape '\'
    AND
    BONUS IS not NULL
    AND
    (emp_no like '%-1%' or emp_no like '%-3%');

SELECT
    EMP_NAME, EMP_NO, DEPT_CODE, SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE='D9' OR DEPT_CODE='D6' AND SALARY > 3000000
AND
    EMAIL LIKE '____%' AND BONUS IS NULL;

SELECT
    *
FROM
    EMPLOYEE
WHERE
    BONUS IS NULL
    AND
    MANAGER_ID IS NOT NULL;

--========================================================
--SET OPERATOR
--========================================================
-- 집합 연산자
-- 여려개의 질의결과(결과 집합)을 세로 방향으로 합치거나 뺀 후 하나의 결과집합을 반환하는 연산자

-- 조건 
-- 1. select 절의 컬럼수가 동일해야 한다.
-- 2. select 절의 동일위치의 컬럼끼리는 자료형이 같아햐한다. (호환 가능한 타입까지 가능)
-- 3. order by 절은 마지막에 한번만 사용 가능
-- 4. 컬럼명이 다른 경우, 첫 번째 결과집합의 컬럼명 사용

-- 연산자 종류
-- 중복된 행의(한 행의 모든 컬럼값이 동일한 경우) 처리에 따라 나뉜다.
-- union (합집합) : 중복을 제거하고, 첫 번째 컬럼 기준 오름차순 정렬
-- union all (합집합) : 중복을 제거하지 않고 그대로 연결
-- intersect (교집합) : 중복된 행만 반환 
-- minus (차집합) : 첫 번째 결과집합에서 두번째 결과집합과 중복된 행을 제거한 후 반환

-- 부서코드 D5인 사원 조회
select emp_id, emp_name, dept_code, salary from employee where dept_code = 'D5';
-- 급여가 300만원보다 많은 사원 조회
select emp_id, emp_name, dept_code, salary from employee where salary > 3000000;

--union all
select emp_id, emp_name, dept_code, salary from employee where dept_code = 'D5'
union all
select emp_id, emp_name, dept_code, salary from employee where salary > 3000000;

--union
-- 중복제거, 첫 번째 컬럼 오름차준 정렬
select emp_id, emp_name, dept_code, salary from employee where dept_code = 'D5'
union
select emp_id, emp_name, dept_code, salary from employee where salary > 3000000;

--intersect
select emp_id, emp_name, dept_code, salary from employee where dept_code = 'D5'
intersect
select emp_id, emp_name, dept_code, salary from employee where salary > 3000000;

--minus
select emp_id, emp_name, dept_code, salary from employee where dept_code = 'D5'
minus
select emp_id, emp_name, dept_code, salary from employee where salary > 3000000;

select emp_id, emp_name, dept_code, salary from employee where salary > 3000000
minus
select emp_id, emp_name, dept_code, salary from employee where dept_code = 'D5';

-- 컬럼 수가 다르면 오류
-- 상응하는 컬럼의 자료형이 호환불가라면 오류
-- order by를 마지막 질의 외에서 사용하면 오류

-- 판매데이터 예제
create table tbl_sales(
    sale_Date date,
    p_name varchar2(50),
    p_count number
);

-- 8월 판매 데이터
insert into tbl_sales values('220801', '새우깡', 10);
insert into tbl_sales values('220803', '썬칩', 15);
insert into tbl_sales values('220810', '홈런볼', 7);
insert into tbl_sales values('220815', '빼빼로', 20);
insert into tbl_sales values('220820', '꼬북칩', 5);
insert into tbl_sales values('220825', '홈런볼', 10);
insert into tbl_sales values('220830', '썬칩', 30);

-- 9월 판매데이터
insert into tbl_sales values('220904', '양파링', 20);
insert into tbl_sales values('220908', '썬칩', 5);
insert into tbl_sales values('220913', '홈런볼', 20);
insert into tbl_sales values('220919', '썬칩', 10);
insert into tbl_sales values('220923', '새우깡', 7);
insert into tbl_sales values('220928', '홈런볼', 30);
insert into tbl_sales values('220929', '빼빼로', 20);

-- 10월 판매데이터
insert into tbl_sales values('221002', '홈런볼', 12);
insert into tbl_sales values('221006', '새우깡', 20);
insert into tbl_sales values('221008', '홈런볼', 20);
insert into tbl_sales values('221013', '빼빼로', 5);
insert into tbl_sales values('221016', '새우깡', 7);
insert into tbl_sales values('221019', '양파링', 13);
insert into tbl_sales values('221026', '썬칩', 14);

commit;

select * from tbl_sales;

-- 2달 전에 판매 데이터만 조회
-- 언제 조회해도 2달전 데이터가 나올 수 있는 쿼리 작성
-- 1월에 조회하면 전년 11월
-- 22.10월에 조회하면 22.08 데이터만 조회
select
    *
from
    tbl_sales 
where
    extract(year from add_months(sysdate, -2)) = extract(year from sale_date)
    and
    extract(month from add_months(sysdate, -2)) = extract(month from sale_date);

select
    *
from
    tbl_sales 
where
    to_char(add_months(sysdate, -2), 'yyyy-mm') = to_char(sale_date, 'yyyy-mm');
    
--migration 작업
-- tbl_sales | tbl_sales_2209 | tbl_salse_2208 테이블 나누기
create table tbl_sales_2209
as
select
    *
from
    tbl_sales 
where
    to_char(add_months(sysdate, -1), 'yyyy-mm') = to_char(sale_date, 'yyyy-mm');
    
select * from tbl_sales_2209;
desc tbl_sales_2209;

create table tbl_sales_2208
as
select
    *
from
    tbl_sales 
where
    to_char(add_months(sysdate, -2), 'yyyy-mm') = to_char(sale_date, 'yyyy-mm');
    
select * from tbl_sales_2208;
desc tbl_sales_2208;

--tbl_sales에서 지난 달 데이터 제거하기
select * from tbl_sales;
delete from
    tbl_sales
where
    to_char(sale_Date,'yyyy-mm') != to_char(sysdate,'yyyy-mm');

select * from tbl_sales;

commit;

-- 지난 3개월간의 판매 데이터 조회
select * from tbl_sales_2208
union all
select * from tbl_sales_2209
union all
select * from tbl_sales;

-- 지난 3개월간 월벌 제품별 총 판매량 조회
select
    to_char(sale_Date,'yyyy-mm'), 
    p_name, 
    sum(p_count)
from (
    select * from tbl_sales_2208
    union all
    select * from tbl_sales_2209
    union all
    select * from tbl_sales
)
group by
    to_char(sale_Date,'yyyy-mm'), p_name
order by
    1;

select
    substr(sale_date,1,5),
    p_name,
    sum(p_count)
from(
select * from tbl_sales_2208
union all
select * from tbl_sales_2209
union all
select * from tbl_sales 
)
group by
    substr(sale_date,1,5),p_name;

--===========================================================
--SUB-QUERY
--===========================================================
-- 하나의 SQL 안에 포함된 다른 SQL문
-- 존재하지 않는 값에 근거한 조회가 필요할때 유용함
-- 메인 쿼리에 종속된 쿼리. (메인 쿼리 실행중에 서브 쿼리가 실행되고, 그 결과를 다시 메인퀘리에 전달해서 진행함) 

-- 조건
-- 1. 서브 쿼리는 반드시 소괄호로 묶어야 한다.
-- 2. 서브 쿼리 내에서는 order by 문법 사용 불가
-- 3. 서브 쿼리를 연산자 우측에 위치 시킬 것.

-- 서브쿼리 종류
-- 1. 일반 서브쿼리 : 메인쿼리에서 제공받는 값 없음. 블럭을 잡아 단독으로 실행 가능.
-- 2. 상호연관 커리 : 메인 쿼리에서 제공받는 값 있음. 블럭을 잡아 단독으로 실행 불가능.

--반환되는 결과 집합에 따라
-- 1. 단일행 단일컬럼 서브쿼리 (1행 1열)
-- 2. 다중행 단일컬럼 서브쿼리 
-- 3. 

-- 노옹철 사원의 관리자명 조회
-- 1. 셀프 조인
select * from employee;

select
    e1.emp_name 사원명,
    e2.emp_name 관리자명
from
    employee e1, employee e2
where
    e1.manager_id = e2.emp_id (+)
    and
    e1.emp_name = '노옹철';

-- 2. sub-query
-- 노옹철 manager_id -> 일치하는 emp_id 행 -> 그 행의 emp_name
select manager_id from employee where emp_name = '노옹철';
select emp_name from employee where emp_id = '201';

select 
    emp_name
from
    employee
where
    emp_id = (select manager_id from employee where emp_name = '노옹철');

-- 평균급여보다 많은 급여를 받는 사원 조회
select
    *
from
    employee
where
    salary > (select avg(salary) from employee);

-- 최소 급여를 받는 사원 조회 (사원명, 급여)
select
    emp_name,
    salary
from
    employee
where
    salary = (select min(salary) from employee);

------------------------------------------------------------
-- 단일행 단일컬럼 서브쿼리
------------------------------------------------------------
-- 서브쿼리의 결과집합이 1행1열일때

-- 윤은해 사원의 급여와 동일한 급액을 받는 사원 조회 (사번, 사원명, 급여)
-- 윤은해 제외
select
    emp_id 사번,
    emp_name 사원명,
    salary 급여
from
    employee
where
    salary = (select salary from employee where emp_name = '윤은해')
    and
    emp_id != (select emp_id from employee where emp_name = '윤은해');

-- 기본급여가 제일 많은 사원, 제일 적은 사원 조회(사번, 사원명, 급여)
select
    emp_id 사번,
    emp_name 사원명,
    salary 급여
from
    employee
where
    salary = (select min(salary) from employee)
    or
    salary = (select max(salary) from employee);

------------------------------------------------------------
-- 다중행 단일컬럼 서브쿼리
------------------------------------------------------------
-- 서브쿼리 조회결과 n행 1열인 경우
-- 사용 가능한 연산자 in, all, any/some, exists...

-- 송종기, 하이유와 같은 부서에 일하는 사원 조회
select
    emp_name, dept_code
from
    employee
where
    dept_code in (select dept_code from employee where emp_name in ('송종기', '하이유'));

-- 차태연, 박나라, 이오리와 같은 직급의 사원을 모두 조회 (사원명, 직급명)
select
    emp_name 사원명, job_name 직급명
from
    employee, job
where
    employee.job_code = job.job_code
    and
    employee.job_code in (select job_code from employee where emp_name in ('차태연', '박나라', '이오리'));

-- 직급이 대표, 부사장이 아닌 모든 사원 조회 (사원명, 부서명)
-- employee, job 조인 없이 처리
-- job_code를 통해 서브쿼리 조회
select
    emp_name 사원명, nvl(dept_title, '인턴') 부서명
from
    employee, department
where
    employee.dept_code = department.dept_id (+)
    and
    job_code not in (select job_code from job where job_name in ( '대표', '부사장' ));

----------------------------------------------------------------------
-- 다중열 서브쿼리
----------------------------------------------------------------------
-- 조회된 서브춰리의 컬럼수가 2개 이상인 경우
-- 행의 수가 1개라면 = 연산자 사용, 2개 이상이라면 in 연산자를 사용해야 한다.

-- 퇴사직원 1명 있는데, 그 사원과 같은 부서, 같은 직급의 사원 조회 (사원명, 부서코드, 직급코드)

select
    emp_name, dept_code, job_code
from
    employee
where
    (dept_code, job_code) = (select
                                dept_code, job_code
                             from
                                employee
                             where
                                quit_yn = 'Y')
    and
    quit_yn = 'N';

-- 유하진 사원 퇴사
update
    employee
set
    quit_yn = 'Y',
    quit_date = current_date
where
    emp_name = '유하진';

commit;

-- 직급별 최소 급여를 받는 사원 조회 (사번, 이름, 직급코드, 급여)
select
    emp_id 사번, emp_name 사원명, job_code 직급코드, salary 급여
from
    employee
where
    (job_code, salary) in (select job_code, min(salary) from employee group by job_code)
order by
    job_code;

select min(salary) from employee group by job_code;

select * from employee;

-- 부서별 최대급여 받는 사원조회 (사번, 사원명, 부서코드, 급여)
-- (부서 지정이 안된 사원중에 최대급여자도 포함)

select
    emp_id 사번, emp_name 사원명, nvl(dept_code, '인턴') 부서코드, salary 급여
from
    employee
where
    (nvl(dept_code, '인턴'), salary) in (select nvl(dept_code, '인턴'), max(salary) from employee group by dept_code)
order by
    dept_code;

-------------------------------------------------------------
-- 상관 서브쿼리
-------------------------------------------------------------
-- 상호연관 서브쿼리
-- 메인쿼리에서 값을 얻어와 서브쿼리 실행. 실행 결과를 다시 메인쿼리에 반환
-- 메인쿼리의 매 행마다 다른 서브쿼리를 실행해야할 때 유용하다.
-- 서브쿼리만 단독 실행이 불가능함. (메인쿼리의 값이 없기 때문에)

-- 직급별 평균급여보다 많은 급여를 받는 사원 조회
-- 1. join 이용
-- 직급별 평균급여 가상테이블, employee 조인
select
    emp_name, job_code, salary, avg_sal
from
    employee e join (select job_code, trunc(avg(salary)) avg_sal from employee group by job_code) v
    using(job_code)  -- 기존 컬럼명이 같은 경우에만 using 사용가능.
where
    e.salary > v.avg_sal
order by
    job_code;

select avg(salary) from employee group by job_code;

-- 2. 상관 서브쿼리
select
    emp_name, job_code, salary
from
    employee
where
    salary > (select trunc(avg(salary)) avg_sal from employee where job_code = employee.job_code)
order by
    job_code;

select trunc(avg(salary)) avg_sal from employee where job_code = 'J1';
select trunc(avg(salary)) avg_sal from employee where job_code = 'J2';
select trunc(avg(salary)) avg_sal from employee where job_code = 'J3';
-- ...

-- 부서별 평균급여보다 적은 급여를 받는 사원 조회
-- (인턴 사원 중에서 처리되도록 할 것)
select
    emp_name, nvl(dept_code, '인턴') dept_code, salary
from
    employee e
where
    salary < (select trunc(avg(salary)) avg_sal from employee where nvl(dept_code, '인턴') = nvl(e.dept_code, '인턴'))
order by
    dept_code;
    
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- EXISTS
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- where절에서 사용하는 boolean을 반환하는 연산자

-- where exists (서브쿼리) : 서브쿼리에서 반환된 행이 1행 이상인 경우 true, 0행이면 false
-- where [not] exists (서브쿼리) : 서브쿼리에서 반환된 행이 1행 이상인 경우 false, 0행이면 true

-- where 조건절 : 행별로 true / false 를 판단해서 결과 집합에 포함여부를 결정함
select
    *
from
    employee
where 
    1 = 1; -- 무조건 true

select
    *
from
    employee
where 
    1 = 2; -- 무조건 false

-- 부하직원이 한명이라도 있는 관리자사원 조회
select
    *
from
    employee e
where
    exists (select * from employee where manager_id = e.emp_id);

select * from employee where manager_id = emp_id;

-- 부서테이블에서 실제 부서원이 존재하는 부서만 조회
-- department.dept_id
select
    *
from
    department d
where
    exists (select * from employee where dept_code = d.dept_id);

-- 최대급여를 받는 사원 조회
-- not exists ()
select
    *
from
    employee e
where
    not exists (select 1 from employee where salary > e.salary);

--------------------------------------------------------------
-- 스칼라 서브쿼리
--------------------------------------------------------------
-- scala 란 : 단일값을 의미함. 1행1열 상관서브쿼리
-- select 절에 사용된 1행1열 상관서브쿼리를 보통 의미한다.

-- 사번, 사원명, 관리자 사번, 관리자명 조회
select
    emp_id,
    emp_name,
    manager_id,
    (select emp_name from employee where emp_id = e.manager_id) manager_name
from
    employee e;

-- 사번, 사원명, 부서명, 직급명 조회
select
    emp_id 사번,
    emp_name 사원명,
    (select dept_title from department where dept_id = e.dept_code) 부서명,
    (select job_name from job where job_code = e.job_code) 직급명
from
    employee e;

-------------------------------------------------------
-- INLINE VIEW
-------------------------------------------------------
-- from 절에 사용한 subquery

-- view란
-- 실제 테이블을 제한적으로 활용하기 위한 논리적 가상테이블.
-- 존재하지는 않지만 실재하는 테이블처럼 사용 가능하다.

-- 1. inline view : from절에서 사용. 저장되지 않는 1회용 view.
-- 2. stored view : 저장된 view. db 객체. view 이름을 갖고 있고, 이름을 통해 언제든 재호출 가능.

-- 가상컬럼을 단순하게 이용하기 위한 용도로 inline-view 사용 추천
select
    emp_name,
    decode(substr(emp_no, 8, 1), '1', '남','3', '남','여') gender
from
    employee
where
    decode(substr(emp_no, 8, 1), '1', '남','3', '남','여') = '여';

select
    *
from
    (
    select
        e.*,
        decode(substr(emp_no, 8, 1), '1', '남','3', '남','여') gender
    from
        employee e
    )
where
    gender = '여';
    
-- 30대, 40대 남자 사원만 조회 (사번, 사원명, 부서명, 성별, 나이)
select
    emp_id,
    emp_name,
    dept_title,
    gender,
    age
from
    (
    select
        e.*,
        decode(substr(emp_no, 8, 1), '1', '남','3', '남','여') gender,
        (select dept_title from department where dept_id = e.dept_code) dept_title,
        extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1 age
    from
        employee e
    )
where
    gender = '남'
    and
    age between 30 and 49;

SELECT
*
FROM 
employee;

--===========================================================
-- 고급쿼리
--===========================================================

-------------------------------------------------------------
-- TOP-N 분석
-------------------------------------------------------------
-- TOP-N 질의는 특정 결과집합에서 최대/최소 n개의 행을 반환하는 쿼리

-- rowid | rownum
-- rowid : 레코드에 접근하기 위한 논리적 주소값
-- rownum : 결과집합의 각 행에 대한 일련번호. 질의한 결과행에 대해 순차적으로 부여된 값.
    -- from/where 절이 끝마쳐질 때 부여가 완료됨. (*where절에서 offset 이 있는 경우는 사용 불가)
    -- order by 행의 순서를 변경시에는 rownum은 변경되지 않는다.
    -- rownum 새로 부여하기 위해서는 from/where를 새로 지정하거나, 혹은 inlinview를 사용
select
    rownum,
    e.emp_name,
    e.salary
from
    (
    select 
        -- rowid,
        -- rownum,
        e.*
    from
        employee e
    order by
        salary desc
        ) e
where
    rownum between 1 and 5;
    
-- 최근 입사한 5명을 조회 (순번, 사번, 이름, 입사일)
select
    rownum,
    e.emp_id,
    e.emp_name,
    e.hire_Date
from
    (
    select 
        e.*
    from
        employee e
    order by
        hire_Date desc
        ) e
where
    rownum between 1 and 5;
    
-- 급여 상위 6~10위 사원조회 (사번 사원명 급여)
select
    rnum,
    emp_id,
    emp_name,
    salary
from
    (
    select
        rownum rnum,
        e.*
    from
        (
        select 
            -- rowid,
            -- rownum,
            e.*
        from
            employee e
        order by
            salary desc
        ) e
    ) e
where
    rnum between 2 and 10;
    
-- 최근 입사한 6위~10위 5명 조회 (순번, 사번, 이름, 입사일) 
select
    rnum,
    emp_id,
    emp_name,
    hire_Date
from
    (
    select
        rownum rnum,
        e.*
    from
        (
        select 
            e.*
        from
            employee e
        order by
            hire_Date desc
            ) e
    )e
where
    rnum between 6 and 10;
    
-- 부서별 급여평균 top-3 조회
select
    rownum,
    e.*
from
    (
    select 
        dept_code,
        trunc(avg(salary)) avg_sal
    from
        employee e
    group by
        dept_code
    order by
        avg_sal desc
    ) e
where
    rownum <= 3;

-- 직급이 대리인 사원중에서 연봉상위 3명 정보 출력
-- 순위, 사번, 사원명, 직급명, 연봉(포맷팅)
select
    rownum 순위,
    emp_id 사번,
    emp_name 사원명,
    (select job_name from job where job_code = e.job_code) 직급명,
    to_char((salary + (salary * nvl(bonus,0))) * 12, 'FML999,999,999,999') 연봉
from
    (
    select 
        e.*
    from
        employee e
    where
    (select job_name from job where job_code = e.job_code) = '대리'
    order by
        salary desc
    ) e
where
    rownum <= 3;
    
-- join 이용
select
    rownum 순위,
    emp_id 사번,
    emp_name 사원명,
    job_name 직급명,
    to_char(annual_sal, 'FML999,999,999,999') 연봉
from
    (
    select
        e.*,
        j.*,
        (salary + (salary * nvl(bonus,0))) * 12 annual_sal
    from
        employee e join job j
            on e.job_code = j.job_code
    where
        job_name = '대리'
    order by
        annual_sal desc
    ) e
where
    rownum <= 3;

-- 직급별 급여평균 top3 (직급명, 급여평균)
select
    rownum 순위,
    (select job_name from job where job_code = e.job_code) 직급명,
    급여평균
from
    (
    select 
        job_code,
        trunc(avg(salary)) 급여평균
    from
        employee e
    group by
        job_code
    order by
        급여평균 desc
    ) e
where
    rownum <= 3;

-- join
select
    rownum 순위, job_name 직급, avg_sal 급여평균
from (
    select
        j.job_name,
        trunc(avg(salary)) avg_sal
    from    
        employee e join job j
            on e.job_code = j.job_code
    group by
        job_name
    order by 
        avg_sal desc
) e
where
    rownum between 1 and 3;

-----------------------------------------------------------------
-- WITH
-----------------------------------------------------------------
-- inline-view에 대한 별칭을 미리 선언
/*
with 별칭
as (서브쿼리)
메인쿼리;
*/

-- 급여 top3 조회
with emp_sal_desc
as (
    select * from employee order by salary desc
)
select
    rownum, emp_name, salary
from
    emp_sal_desc e
where
    rownum between 1 and 3;
    
------------------------------------------------------------------
-- WINDOW FUNCTION
------------------------------------------------------------------
--

-- 순위관련 rank | dense_rank | row_number
-- 집계관련 sum | avg | min | max | count
-- 순서관련 first_value | last_value | lag | lead
-- 비율관련 cume+dist | percent_rank | ntitle | ratio_to_report ....
-- 통계관련 corr | covar_pap | covar_samp ...

/*
    윈도우함수 (매개인자) over ([partition by 절] | [order by 절] | [windowing 절])
    
    - 매개인자 : 컬럼값 등 0개 이상 전달가능
    - over 절
        - oder by 절 : 정렬기준
        - partition by 절 : 윈도우 함수의 group by
        - windowing 절 : 대상 행을 제한

*/

--------------------------------------------------------------
-- 순위 관련
--------------------------------------------------------------
-- rank () over ()
-- 행의 순위를 부여
-- 동일한 값이 있다면, 동일한 순위를 부여 후 , 다음 순위는 중복된 행의 수만큼 건너뛴다.

-- dense_rank () over ()
-- 행의 순위를 부여
-- 동일한 값이 있다면, 동일한 순위를 부여하고, 다음 순위는 건너뛰지 않는다.

-- row_number () over ()
-- 행의 순위를 부여
-- 동일한 값이 있어도 중복되지 않는 순위를 부여.

select
    emp_name,
    salary,
    rank() over (order by salary desc) rank,
    dense_rank() over (order by salary desc) rank,
    row_number() over (order by salary desc) rank
from
    employee;

select
    *
from
    (
    select
        emp_name,
        salary,
        row_number() over(order by salary desc) rnum
    from
        employee
    )
where
    rnum between 6 and 10;

-- 직급이 '사원'인 사원의 급여 top3를 조회
-- 사원, 직급명, 급여
select
    *
from
    (
    select
        dense_rank () over(order by salary desc) rnum,
        emp_name,
        (select job_name from job where job_code = e.job_code) job_name,
        salary
    from
        employee e
    where
        (select job_name from job where job_code = e.job_code) = '사원'
    )
where
    rnum between 1 and 3;
    
-- 그룹핑된 순위
select
    dept_code,
    emp_name,
    salary,
    dense_rank () over (partition by dept_code order by salary desc) rank
from
    employee;

-- 직급별 나이순 조회 (사번, 사원명, 직급명, 나이, 나이순서)
select
    emp_id,
    emp_name,
    (select job_name from job where job_code = e.job_code) job_name,
    extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1 age,
    dense_rank () over (partition by job_code order by (extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1) desc) rank
from
    employee e;

-- join
select
    emp_id,
    emp_name,
    job_name,
    extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1 age,
    dense_rank () over (partition by e.job_code order by (extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1) desc) rank
from
    employee e join job j
        on e.job_code = j.job_code;
        
--------------------------------------------------------------
-- 집계함수
--------------------------------------------------------------
-- 그룹함수에 대한 기능을 지원하는 윈도우 함수

-- sum() over()
select
    emp_name,
    dept_code,
    sum(salary) over (partition by dept_code) sum,
    sum(salary) over (partition by dept_code order by emp_id) sum,
    trunc(avg(salary) over (partition by dept_code)) avg
from
    employee;

--------------------------------------------------------------
-- 기타 윈도우 함수
--------------------------------------------------------------
-- listagg
-- 특정 컬럼값을 구분자로 합쳐서 하나의 컬럼값으로 반환
select
    listagg(emp_name, ', ') within group (order by emp_name) 전사원이름
from
    employee;

-- 부서별 사원명
select
    dept_code,
    count(*),
    listagg(emp_name, ' ') within group (order by emp_id) 부서원
from
    employee
group by
    dept_code;


select
    level, sysdate + level
from
    dual
connect by
    level <= 10;
    
-- 년도별 입사자 조회 (년도, 명수)
select
    extract(year from hire_date) hire_year,
    count(*),
    listagg(emp_name, ' ') within group (order by extract(year from hire_date)) 부서원
from
    employee
group by
    extract(year from hire_date);

select level
    + 1989 hire_year
from
    dual
connect by 
    level <= 2022 - 1990+1;


select
    v.hire_year,
    nvl(e.cnt, 0) cnt
from
    (
    select
        extract(year from hire_date) hire_year,
        count(*) cnt
    from
        employee
    group by
        extract(year from hire_date)
    order by 
        hire_year) e
    right join
    (select
        level + 1989 hire_year
    from
        dual
    connect by 
        level <= 2022 - 1990+1) v
    on e.hire_year = v.hire_year
order by
    v.hire_year;

--===========================================================
-- DML
--===========================================================
-- Data Manipulation Language 데이터 조작어
-- 테이블 데이터에 대해 등록, 조회, 수정, 삭제를 처리하는 명령어
-- Create - insert
-- Read - select (DQL)
-- Uupdate - update
-- Delete - delete

-------------------------------------------------------------
-- INSERT
-------------------------------------------------------------
-- 테이블에 레코드 (행)을 추가하는 명령어

/*

    <타입 1>
    - 테이블에 정의된 모든 컬럼값을 순서에 맞게 제공해야 한다.
    insert into
        테이블
    values (컬럼1값, 컬럼2값, ...);

    <타입 2>
    - 테이블에 정의된 털럼 중 일부에 대해서만 값을 제공한다.
    - 생략 물가한 컬럼 : not null 컬럼 (단, 기본값이 정의된 경우는 생략 할 수 있다.)
    - 생략 가능한 컬럼 : null 컬럼 (기본값이 자동으로 대이보딤. 기본값이 지정되지 않은 경우, null 값 입력)
    insert into
        테이블 (컬럼 1, 컬럼2, ...)
    values (컬럼1값, 컬럼2값, ...);

*/

create table sample (
    a number,
    b varchar2(20) default 'ㅋㅋㅋ',
    c varchar2(20) not null,
    d date default sysdate not null -- 순서는 디폴트보다 낫 널을 먼저 사용해야한다.
);

-- 타입 1
insert into
    sample
values (
    123, '홍길동', 'honggd', to_date('20000909')
);

insert into
    sample
values (
    123,null, 'sinsa', default
);

select * from sample;

-- 타입 2
insert into
    sample (a, c, d)
values (
    456, 'leess', to_date('19990910')
);

insert into
    sample (c, d)
values (
    'leess', to_date('19990910')
);

-- 연습용 ex_employee 테이블 생성
-- 테이블 구조, 담긴 데이터가 동일하게 생성
create table ex_employee
as
(select * from employee);

select * from ex_employee;
desc ex_employee;

-- 서브쿼리를 사용한 테이블 새엇ㅇ
-- not null 제외하고 기본값, 기타 제역조건이 모두 제거됨.
alter table ex_employee
add constraint pk_ex_employee primary key (emp_id) -- 기본키 제약조건
add constraint uq_ex_employee_emp_no unique (emp_no) -- 유일키 제약조건
add constraint fk_ex_employee_dept_Code foreign key (dept_code) references department(dept_id) -- 외래키 제약조건
add constraint fk_ex_employee_manager_id foreign key (manager_id) references ex_employee(emp_id) -- 외래키 (자기참조) 제약조건
add constraint uq_ex_employee_quit_yn check (quit_yn in('Y', 'N')) -- 체크키
modify quit_yn default 'N'
modify hire_date default sysdate;

/*
@실습문제 : 다음 2명의 사원과 최소정보(필수컬럼)만 채운 사원(임의) 1명을 employee_ex테이블에 insert하세요.

    사번: 301
    이름: 함지민
    주민번호: 781020-2123453
    이메일: hamham@kh.or.kr
    전화번호: 01012343334
    부서코드: D1
    직급코드: J4
    급여등급: S3
    급여: 4300000
    보너스: 0.2
    관리자: 200

    사번: 302
    이름: 장채현
    주민번호: 901123-1080503
    이메일: jang_ch@kh.or.kr
    전화번호: 01033334444
    부서코드: D2
    직급코드: J7
    급여등급: S3
    급여: 3500000
    보너스: 없음
    관리자: 201
*/
insert into
    ex_employee (EMP_ID, EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID)
values(
    301, '함지민', '781020-2123453', 'hamham@kh.or.kr', '01012343334', 'D1', 'J4', 'S3', 4300000, 0.2, 200
);

insert into
    ex_employee (EMP_ID, EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID)
values(
    302, '장채현', '901123-1080503', 'jang_ch@kh.or.kr', '01033334444', 'D2', 'J7', 'S3', 3500000, null, 201
);

insert into
    ex_employee (EMP_ID, EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL)
values(
    303, '세종대왕', '880808-1012345', 'J7', 'S3'
);

-- Data Migration 데이터 이주
-- 1. 



-- 2. insert all 을 사용해 여러 컬럼 추가
-- emp_hire_date
-- emp_manager

create table emp_hire_date
as
select
    emp_id,
    emp_name,
    hire_date
from
    employee
where
    1=0;
select * from emp_hire_date;


create table emp_manager
as
select
    emp_id,
    emp_name,
    manager_id,
    emp_name manager_name
from
    employee
where
    1=0;
select * from emp_manager;

select
    emp_id,
    emp_name,
    manager_id,
    (select emp_name from employee where emp_id = e.manager_id) manager_name,
    hire_date
from
    employee e;

desc emp_manager;
-- emp_manager.manager_name 컬럼을 null로 변경
alter table
    emp_manager
modify
    manager_name null;

insert all
into emp_hire_Date values (emp_id, emp_name, hire_date)
into emp_manager values (emp_id, emp_name, manager_id, manager_name)
select
    emp_id,
    emp_name,
    manager_id,
    (select emp_name from employee where emp_id = e.manager_id) manager_name,
    hire_date
from
    employee e;

----------------------------------------------------------------
-- UPDATE
----------------------------------------------------------------
-- 테이블 데이터에 대해 컬럼값을 수정하는 명령.
-- where 절을 통해 대상 행을 지정함

create table ex_department
as
select * from department;

select * from ex_department;

update
    ex_department
set
    dept_title = '전략기획부',
    location_id = 'L5'
where 
    dept_id = 'D9';

rollback;

-- subquery 를 사용한 update
-- 방명수 사원의 급여/보너스를 유재식 사원과 동일하게 수정

update
    ex_employee
set
    salary = (select salary from employee where emp_name = '유재식'),
    bonus = (select bonus from employee where emp_name = '유재식')
where
    emp_name = '방명수';
    
select * from ex_employee where emp_name in ('방명수', '유재식');

-- 임시환 사원의 직급을 과장, 부서를 해외영업3부로 수정
update
    ex_employee
set
    job_code = (select job_code from job where job_name = '과장'),
    dept_code = (select dept_id from ex_department where dept_title = '해외영업3부')
where
    emp_name = '임시환';
    
select * from ex_employee where emp_name in ('임시환');

---------------------------------------------------------------
-- DELETE
---------------------------------------------------------------
-- 테이블의 행을 삭제하는 명령
-- where절을 적절히 작성할 것!

delete from
    ex_employee
where
    emp_id = '303';
    -- dept_code = 'D2';

select * from ex_employee;

---------------------------------------------------------------
-- TRUNCATE
---------------------------------------------------------------
-- 테이블의 모든 행을 삭제하는 DDL 명령어.
-- DDL은 DML과 달리 before image를 생성하지 않고, 실행 즉시 commit 된다.
-- 처리속도가 빠르다.

select * from ex_department;
delete from ex_department;
rollback;

truncate table ex_department;

--=============================================================
-- DDL
--=============================================================
-- Data Definition Language 데이터 정의어
-- 데이터베이스 객체 (table, user, index, ...) 에 대해서 생성, 수정, 삭제하는 명령어

-- 데이터베이스 객체
-- table, user, sequence, index, function, procedure, trigger, synonym, package, job ...

-- 테이블/컬럼 주석
-- 다수의 테이블/컬럼을 구분 할 수 있도록 핵심적인 내용을 주석으로 달아둔다.

create table member (
    id varchar2(20),
    password varchar2(20),
    name varchar2(50),
    birthday date
);

-- 테이블 주석
select
    *
from
    user_tab_comments -- Data Dictionary
where
    table_name = 'MEMBER';
    
select
    *
from
    user_col_comments
where
    table_name = 'MEMBER';
    
-- 주석 작성
comment on table member is '회원정보 관리테이블';
-- 주석 삭제
comment on table member is ''; --null

comment on column member.id is '회원아이디 (변경불가)';
comment on column member.password is '회원비밀번호 - 영문자/숫자/특수문자 하나씩 필수로 포함';
comment on column member.name is '회원이름';
comment on column member.birthday is '생일';

--------------------------------------------------------------
-- CONSTRAINT
--------------------------------------------------------------
-- 제약조건. 테이블의 컬럼에 대해서 값의 무결성을 지키도록 제한하는 것.

-- 1. not null : null을 허용하지 않음. 필수값
-- 2. unique : 중복값을 허용하지 않음. (예- 계정 아이디 중복불가 등..)
-- 3. primary key : 고유 식별 컬럼. null을 허용하지 앟음. 중복될 수 없음. 테이블당 딱 하나만 허용
-- 4. foreign key : 외래키. 두 케이블간의 데이터 참조관계 설정. 부모테이블의 지정한 컬럼값만 사용하도록 제한.
-- 5. check : 컬럼값을 도메인 (원자값의 묶음) 으로 한정

-- data dictionary : user_constraints | user_cons_columns
select
    *
from
    user_constraints
where
    table_name = 'EMPLOYEE';

select
    *
from
    user_cons_columns
where
    table_name = 'EMPLOYEE';

-- 조인버젼
select
    constraint_name,
    uc.table_name,
    ucc.column_name,
    uc.constraint_type,
    uc.search_condition,
    uc.r_constraint_name -- 참조하는 제약조건 이름 (외래키)
from
    user_constraints uc join user_cons_columns ucc
        using (constraint_name)
where
    uc.table_name = 'EMPLOYEE';
    
    
----------------------------------------------------------------
-- not null
----------------------------------------------------------------
-- 필수 입력값 컬럼.
-- 컬럼 레벨에서만 작성 가능

create table member (
    id varchar2(20) not null,
    password varchar2(20) not null,
    name varchar2(50) not null,
    birthday date
);

-- drop table member;
desc member;
insert into member values (null, '1234', '홍길동', null);
select * from member;

----------------------------------------------------------------
-- UNIQUE
----------------------------------------------------------------
-- 특정 컬럼에 중복값 입력을 허용하비 않는 제약조건
-- 커럼 레벨 / 테이블 레벨 모두 선언 가능
-- 컬럼 n개를 묶어서 복합 unique 제약조건도 사용가능.
-- null 값은 허용함. (여러개도 가능)

create table member (
    id varchar2(20) not null,
    password varchar2(20) not null,
    name varchar2(50) not null,
--    email varchar2(100) constraint uq_member_email unique, -- 컬럼 레벨에 선언
    email varchar2 (100),
    birthday date,
    constraint uq_member_email unique(email) -- 태아불 래밸애 선언
);

-- drop table member;
insert into member values ('honggd', '1234', '홍길동', 'honggd@naver.com', null);
insert into member values ('honggd', '1234', '홍길동', 'honggd@naver.com', null); -- ORA-00001: 무결성 제약 조건(BLOSSOM.UQ_MEMBER_EMAIL)에 위배됩니다
insert into member values ('honggd', '1234', '홍길동', 'honggd@gmail.com', null); 
insert into member values ('honggd', '1234', '홍길동', null, null); 
insert into member values ('honggd', '1234', '홍길동', null, null); 

select * from member;

-----------------------------------------------------------------
-- PRIMARY KEY
-----------------------------------------------------------------
-- 기본키. 테이블에서 한 행의 정보를 구별해내기 위한 식별자 컬럼.
-- not null. unique 특징을 모두 가지고 있고, 테이블당 한개만 설정 가능
-- 컬럼/테이블 레벨 모두 선언 가능
-- 여러 컬럼을 묶어서 복합 기본키 사용가능

create table member (
--    id varchar2(20) constraint pk_member_id primart key, -- 컬럼 레벨에 선언
    id varchar2(20),
    password varchar2(20) not null,
    name varchar2(50) not null,
    email varchar2 (100),
    birthday date,
    constraint pk_member_id primary key(id), -- 테이블 레벨에 선언
    constraint uq_member_email unique(email)
);
-- drop table member;

insert into member values (null, '1234', '홍길동', 'honggd@naver.com', null); --ORA-01400: NULL을 ("BLOSSOM"."MEMBER"."ID") 안에 삽입할 수 없습니다
insert into member values ('honggd', '1234', '홍길동', 'honggd@naver.com', null);
insert into member values ('honggd', '1234', '홍길동', 'honggd@naver.com', null);  -- ORA-00001: 무결성 제약 조건(BLOSSOM.PK_MEMBER_ID)에 위배됩니다

select
    constraint_name,
    uc.table_name,
    ucc.column_name,
    uc.constraint_type,
    uc.search_condition
from
    user_constraints uc join user_cons_columns ucc
        using (constraint_name)
where
    uc.table_name = 'MEMBER';

-- 복합 pk
create table tbl_order(
    product_code varchar2(20), -- 상품코드
    user_code varchar2(20), -- 사용자id
    order_date date default sysdate, -- 구매일시
    num number default 1,
    constraint pk_tbl_order primary key (product_code, user_code, order_date)
);

insert into tbl_order (product_code, user_code) values ('abc12345', 'honggd');
insert into tbl_order (product_code, user_code) values ('xyz12345', 'sinsa');
insert into tbl_order (product_code, user_code) values ('xyz12345', null); -- ORA-01400: NULL을 ("BLOSSOM"."TBL_ORDER"."USER_CODE") 안에 삽입할 수 없습니다


select * from tbl_order;

-----------------------------------------------------------------
-- FOREIGN KEY
-----------------------------------------------------------------
-- 외래키. 참조무결성을 유지하기 위한 제약조건.
-- 부모테이블에서 제공되는 값만 자식테이블의 컬럼에서 사용할 수 있도록 한다.
-- 단, null은 허용이 된다.
-- 부모테이블의 참조하는 컬럼은 PK, UQ 제약조건이 걸려있어야 한다.
-- 관계형 DBMS에서 핵심적인 역할

select
    constraint_name,
    uc.table_name,
    ucc.column_name,
    uc.constraint_type,
    uc.search_condition,
    uc.r_constraint_name -- 참조하는 제약조건 이름 (외래키)
from
    user_constraints uc join user_cons_columns ucc
        using (constraint_name)
where
    uc.table_name = 'EMPLOYEE';

-- 판매회원 테이블
create table shop_member(
    id varchar2(20),
    name varchar2(50) not null,
    constraint pk_shop_member_id primary key(id)
);
insert into shop_member values ('honggd', '홍길동');
insert into shop_member values ('sinsa', '신사임당');
insert into shop_member values ('leess', '리쌍');

select * from shop_member;

-- 판매 테이블
create table shop_buy(
    no number,
    member_id varchar2 (20),
    product_id varchar2 (20),
    cnt number default 1,
    buy_date date default sysdate,
    constraint pk_shop_buy_no primary key(no),
    constraint fk_shop_buy_member_id foreign key(member_id) 
        references shop_member(id)
        --on delete set null 
        on delete cascade
        -- 테이블 레벨 선언
);
-- drop table shop_buy;

insert into shop_buy(no, member_id, product_id) values(1, 'honggd', 'abc1234');
insert into shop_buy(no, member_id, product_id) values(2, 'kimys', 'abc1234'); --ORA-02291: 무결성 제약조건(BLOSSOM.FK_SHOP_BUY_MEMBER_ID)이 위배되었습니다- 부모 키가 없습니다
insert into shop_buy(no, member_id, product_id) values(2, 'sinsa', 'abc1234');
insert into shop_buy(no, member_id, product_id) values(3, 'leess', 'abc1234');
insert into shop_buy(no, member_id, product_id) values(4, null, 'abc1234'); -- null 입력 가능

select * from shop_member; -- id 부모키 (pk, uq)
select * from shop_buy; -- member_id 자식키 (fk)

-- 부모 레코드 삭제
-- 자식 레코드를 먼저 삭제후, 부모레코드 삭제
delete from shop_buy where member_id = 'honggd';
delete from shop_member where id = 'honggd'; --ORA-02292: 무결성 제약조건(BLOSSOM.FK_SHOP_BUY_MEMBER_ID)이 위배되었습니다- 자식 레코드가 발견되었습니다

drop table shop_member; --ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다

-- fk 삭제 옵션
-- on delete restrict (기본값. *아무것도 작성하지 말 것!) : 부모 레코드를 자식 레코드보다 먼저 삭제할 수 없다.
-- on delete set null : 부모 레코드 삭제시, 자식 키값을 null로 설정.
-- on delete cascade : 부 모레코드 삭제시, 자식 레코드도 따라서 삭제한다.
delete from shop_member where id = 'sinsa';
delete from shop_member where id = 'leess';

-- 식별관계 | 비식별관계
-- 식별관계 : fk컬럼을 다시 pk로 사용하는 경우. (부모테이블 : 자식테이블 -> 1:1)
    -- shop_member.id -> shop_nick_name.id
-- 비식별관계 : fk컬럼을 pk로 사용하지 않는 경우. (부모테이블 : 자식테이블 -> 1:N)
    -- employee.dept_code

create table shop_nickname (
    id varchar2(20),
    nickname varchar2(100) not null,
    constraint fk_shop_nickname_id foreign key(id) references shop_member(id),
    constraint pk_shop_nickname primary key(id)
);
--drop table shop_nickname;

insert into shop_nickname values ('honggd', '홍길동길동');
insert into shop_nickname values ('honggd', '홍길이 출동!'); -- ORA-00001: 무결성 제약 조건(BLOSSOM.PK_SHOP_NICKNAME)에 위배됩니다
insert into shop_nickname values ('sinsa', '신사장');

select * from shop_nickname; -- 부모테이블 : 자식테이블 -> 1:1


-----------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------
--
-- 설정된 값 이외의 값 입력시 오류 유발

create table member (
    id varchar2(20),
    password varchar2(20) not null,
    name varchar2(50) not null,
    email varchar2 (100),
    birthday date,
    point number default 1000,
    del_yn char(1) default 'N',
    constraint pk_member_id primary key(id), -- 테이블 레벨에 선언
    constraint uq_member_email unique(email),
    constraint ck_member_point check(point >= 0),
    constraint ck_member_del_yn check (del_yn in ('Y','N'))
);
-- drop table member;

insert into member values ('honggd', '1234', '홍길동', 'honggd@gmail.com', null, default, default);
insert into member values ('honggd', '1234', '홍길동', 'honggd@gmail.com', null, -100, default); -- ORA-02290: 체크 제약조건(BLOSSOM.CK_MEMBER_POINT)이 위배되었습니다
insert into member values ('honggd', '1234', '홍길동', 'honggd@gmail.com', null, default, 'n'); -- ORA-02290: 체크 제약조건(BLOSSOM.CK_MEMBER_DEL_YN)이 위배되었습니다

select * from member;

update member
set
    point = point - 2000
where
    id = 'honggd'; --ORA-02290: 체크 제약조건(BLOSSOM.CK_MEMBER_POINT)이 위배되었습니다 (포인트가 마이너스로 갈 수 없게 오류를 일으킴)

SELECT CONCAT (EMP_ID, ',', EMP_NAME, ',', EMP_DEPT)
FROM USER_TABLE;


SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMP
HAVING FLOOR(AVG(SALARY)) > 2800000
GROUP BY DEPT
ORDER BY DEPT ASC;


-- 부서별 평균급여
select
    dept_code,
    sum(salary) 합계,
    floor(avg(salary)) 평균,
    trunc(avg(salary)) 평균2,
    count(*) 인원수
from
    employee
having
    floor(avg(salary)) >= 3000000
group by
    dept_code
order by
    dept_code asc;

select * from employee;
-- TOP-N 분석
-------------------------------------------------------------
-- TOP-N 질의는 특정 결과집합에서 최대/최소 n개의 행을 반환하는 쿼리

-- rowid | rownum
-- rowid : 레코드에 접근하기 위한 논리적 주소값
-- rownum : 결과집합의 각 행에 대한 일련번호. 질의한 결과행에 대해 순차적으로 부여된 값.
    -- from/where 절이 끝마쳐질 때 부여가 완료됨. (*where절에서 offset 이 있는 경우는 사용 불가)
    -- order by 행의 순서를 변경시에는 rownum은 변경되지 않는다.
    -- rownum 새로 부여하기 위해서는 from/where를 새로 지정하거나, 혹은 inlinview를 사용

SELECT ROWNUM, EMPNAME, SAL
FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL DESC;



SELECT
    ROWNUM,
    e.*
FROM
    (
    SELECT EMPNAME, SAL
    FROM EMP
    ORDER BY SAL DESC
    ) e
WHERE ROWNUM <= 3;

select
    rownum,
    e.*
from
    (
    select EMP_NAME, SALARY
    from employee
    order by SALARY desc
    ) e
where rownum <= 3;


------------------------------------------------------------------
-- ALTER
------------------------------------------------------------------
-- db객체에 대한 수정처리 명령어
-- alter - <sub-command>

-- 테이블 객체에 대해서 컬럼/제약조건에 대한 수정이 가능하다.
-- add 컬럼/제약조건
-- modify 컬럼 (자료형, default값, null여부)
-- rename 컬럼/제약조건
-- drop 컬럼/제약조건

create table tbl_user (
    no number,          -- 회원식별번호  
    id varchar2(20),    -- 아이디 (변경)
    password varchar2(20)
);


select * from tbl_user;

insert into tbl_user values (1, 'honggd', '1234');
insert into tbl_user values (2, 'sinsa', '1234');
insert into tbl_user values (3, 'leessssssssss', '1234');

commit;

-- 컬럼추가
alter table
    tbl_user
add
    name varchar2(50) default ' ' not null;  -- 자료형, 기본값, not null
    
desc tbl_user;

-- age 숫자 기본값 0
alter table
    tbl_user
add
    age number default 0;

-- 제약조건추가
-- no-pk 추가
alter table
    tbl_user
add constraint
    pk_tbl_user_no primary key(no);
    
-- id-uq 추가
alter table
    tbl_user
add constraint
    uq_tbl_user_id unique(id);

select
    constraint_name,
    uc.table_name,
    ucc.column_name,
    uc.constraint_type,
    uc.search_condition,
    uc.r_constraint_name -- 참조하는 제약조건 이름 (외래키)
from
    user_constraints uc join user_cons_columns ucc
        using (constraint_name)
where
    uc.table_name = 'TBL_USER';

-- modify
-- 컬럼 : 자료형, 기본값, null 여부
alter table
    tbl_user
modify
    password char(20) null;

desc tbl_user;

alter table
    tbl_user
modify
    password char(3); -- 01441. 00000 -  "cannot decrease column length because some value is too big"

-- rename
-- 컬럼명 변경
-- 제약조건명 변경
alter table
    tbl_user
rename column password to pw;

alter table
    tbl_user
rename constraint pk_tbl_user_no to tbl_user_no_pk;

desc tbl_user;

-- drop
-- 컬럼/제약조건 삭제
alter table
    tbl_user
drop column age; 

alter table
    tbl_user
drop constraint uq_tbl_user_id;

-- name 컬럼 not null 제약조건 삭제
alter table
    tbl_user
modify name null;

-- 테이블명 변경
alter table
    tbl_user
rename to users;

desc users;

-- rename 명령어
rename users to tbl_user;

--------------------------------------------------------------------
-- DROP
--------------------------------------------------------------------
-- db 객체를 삭제하는 명령어

drop table tbl_user;

select * from shop_member;
select * from shop_buy;

insert into shop_member values ('honggd', '홍길동');
insert into shop_member values ('sinsa', '신사임당');
insert into shop_buy values (1, 'honggd', 'abc1234', 1, sysdate);
insert into shop_buy values (2, 'sinsa', 'abc1234', 1, sysdate);

commit;

drop table shop_member; -- ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다

--============================================================
-- DCL
--============================================================
-- Data Control Language (데이터 제어 언어)
-- 권한 관련 처리하는 명령어 (권한부여 grant / 권한회수 revoke)
-- TCL을 포함하는 개념

--------------------------------------------------------------
-- GRANT
--------------------------------------------------------------
-- 권한/롤을 부여
-- grant 권한/롤 to 사용자 [WITH ADMIN OPTION]
-- 권한 create session, create table, alter table, drop ... (create 권한은 alter/drop권한 포함)
-- 롤 : 권한 묶음. connect, resource, dba, ...
-- WITH ADMIN OPTION : 부여받은 권한/롤을 타 사용자에게 다시 부여가능 여부

-- qwerty 계정 생성 (관리자계정)
alter session set "_oracle_script" = true;

create user qwerty
identified by qqwwee1324AAA
default tablespace data;

grant create session to qwerty;
grant connect to qwerty;

grant create table to qwerty;
grant resource to qwerty;


alter user qwerty
quota unlimited on users;

-- connect, resource 롤에 포함된 권한 확인
select
    *
from
    dba_sys_privs
where
    grantee in ('CONNECT', 'RESOURCE');
    
select
    *
from
    dba_sys_privs
where
    grantee in ('QWERTY');
    
select
    *
from
    dba_role_privs
where
    grantee in ('QWERTY');

-- 특정 테이블에 대한 권한
create table coffee (
    name varchar2(20),
    price number,
    company varchar2(20),
    constraint pk_coffee_name primary key (name)
);

insert into coffee values ('맥심', 2000, '동서식품');
insert into coffee values ('카누', 3000, '동서식품');
insert into coffee values ('네스카페', 2500, '네슬레');

select * from coffee;
commit;

-- blossom에서 qwerty에게 coffee 테이블에 대한 조회권한 부여
-- select
grant select on blossom.coffee to qwerty;
grant insert, update, delete on blossom.coffee to qwerty;

--------------------------------------------------------------
-- REVOKE
--------------------------------------------------------------
-- 부여한 권한/롤을 회수

revoke insert, update, delete on coffee from qwerty;
revoke select on coffee from qwerty;

--============================================================
-- TCL
--============================================================
-- Transacrio nControl Language 트랜잭션 제어 언어

-- 트랜잭션이란?
-- 한꺼번에 처리되어야 할 최소의 작업단위 (원자성 - 더이상 쪼갤 수 없어야 한다.)

-- commit : 변경사항을 영구히 저장.
-- rollback : 변경사항을 취소하고 마지막 commit 상태로 돌아간다.
-- savepoint : 변경사항의 중간지점 기록. rollback 시에 마지막 commit 이 아닌 특정 savepoint로 돌아갈 수 있다.


--============================================================
-- DATABASE OBJECT 1
--============================================================
--------------------------------------------------------------
-- Data Dictionary
--------------------------------------------------------------
-- db객체를 효율적으로 관리하기 위해 객체별 메타정보를 관리하는 테이블(뷰. 가상테이블).
-- 사용자는 DD안의 내용을 직접 수정하거나 삭제할 수 없고, 오직 열람만 가능하다.
-- db객체의 변경사항이 있을때마다 자동으로 반영

-- 사용 가능한 dd 조회
select * from dict; -- 별칭
select * from dictionary;

-- dd의 구분
-- 1. user_xxx : 사용자가 소유한 객체에 대한 dd
-- 2. all_xxx : user_xxx 포함하고, 관리자로부터 사용허가받은 객체에 대한 dd
-- 3. dba_xxx : 관리자가 소유한 모든 객체(일반 사용자의 객체 포함)에 대한 dd

-- user
select * from user_tables;
select * from user_sys_privs; -- 사용자 권한
select * from user_role_privs; -- 롤
select * from role_sys_privs; -- 부여받은 롤이 포함하는 권한
select * from user_constraints;
select * from user_sequences;
select * from user_procedures;

-- all_xxx
select * from all_tables;
select * from all_procedures; -- 함수포함

-- dba_xxx
select * from dba_users;
select * from dba_tables where owner = 'BLOSSOM';
-- 특정 사용자에게 부여된 권한 확인
select * from dba_sys_privs where grantee = 'BLOSSOM';
select * from dba_role_privs where grantee = 'BLOSSOM';
select * from dba_tab_privs where owner = 'BLOSSOM';

grant select on blossom.coffee to qwerty; -- 관리자가 blossom.coffee테이블 권한을 qwerty에게 부여
revoke select on blossom.coffee from qwerty;

--------------------------------------------------------------
-- STORED VIEW
--------------------------------------------------------------
-- 하나 이상의 테이블에서 원하는 데이터를 선택해 만든 가상테이블.
-- 실제 테이비르 데이터를 보여주지만, 데이터를 포함하지 않는다.
-- 실제 테이블과의 링크 개념.
-- create view 권한은 recource 롤에 포함되지 않음.

select * from user_views;
-- 뷰 생성
-- 옵션1) or replace : 객체가 존재하면 replace, 존재하지 않으면 create
create or replace view view_emp
as
select
    emp_id, emp_name, email,
    (select dept_title from department where dept_id = e.dept_code) dept_title,
    (select job_name from job where job_code = e.job_code) job_name,
    decode(substr(emp_no, 8, 1), '1', '남', '3' , '남' , '여') gender
from 
    employee e;

-- 권한부여 (시스템)
grant create view to blossom;

-- qwerty에게 employee 테이블 일부 데이터(일부 컬럼)을 오픈.
grant select on view_emp to qwerty;

-- 옵션2) with check option
-- view도 DML 가능
-- where절에서 사용한 컬럽값 변경 방지
create or replace view view_emp_d5
as
select
    *
from
    employee
where
    dept_code = 'D5'
with check option; -- where 절에 사용한 조건절을 변경불가
select * from view_emp_d5;

--update 시도
update
    view_emp_d5
set
    dept_code = 'D6'
where
    emp_id = '206'; -- ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다

-- 옵션3) read only : 읽기전용 뷰 생성
create or replace view view_emp_d9
as
select
    *
from
    employee
where
    dept_code = 'D9'
with read only; 

--update 시도
update
    view_emp_d9
set
    salary = salary * 1.1
where
    dept_code = 'D9'; -- SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

select * from user_views;

-- 복잡한 가상컬럼 연산식을 미리 작성
create or replace view view_emp_detail
as
select
    e.*,
    decode(substr(emp_no, 8, 1), '1', '남', '3' , '남' , '여') gender,
    extract(year from sysdate) - (decode (substr(emp_no,8,1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1 age
from
    employee e;
    
select * from view_emp_detail where gender = '남';

---------------------------------------------------------------------
-- SEQUENCE
---------------------------------------------------------------------
-- 정수값을 순차적으로 발행하는 객체. 채번기
-- 

/*

    create sequence 시퀀스명
    [start with 시작값] : 기본값 1
    [increment by 증감값] : 기본값 1
    [maxvalue 최대값 | nomaxvalue 최대값 없음]
    [minvalue 최소값 | nominvalue 최소값 없음]
    [cylce 순환 | nocycle] : 순환여부. 최대/최소밗에 다다르면 순환 또는 오류 발생
    [cache 숫자 | nocache] : 메모리캐싱 개수. 기본값 20. 숫자 휘발가능성 있음.

*/


create table tbl_member (
    no number,
    username varchar2(50),
    constraint pk_tbl_member_no primary key(no)
);

create sequence seq_tbl_member_no
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
cache 20;

insert into tbl_member values (seq_tbl_member_no.nextval, 'honggd');
insert into tbl_member values (seq_tbl_member_no.nextval, 'sinsa');
insert into tbl_member values (seq_tbl_member_no.nextval, 'leess');
insert into tbl_member values (seq_tbl_member_no.nextval, 'sejong');
insert into tbl_member values (seq_tbl_member_no.nextval, 'yoogs');

select * from tbl_member;

-- nextval 시퀀스의 다음번호
-- currval 마지막에 발급된 번호
select
    seq_tbl_member_no.currval,
    seq_tbl_member_no.nextval
from
    dual;
    
--숫자의 연속성이 중요한 데이터라면, sequence 보다는 nocach옵션 또는  max(col) +1 방식을 사용하는 것이 좋다.

insert into 
    tbl_member
values (
    (select max(no) + 1 from tbl_member),
    'abcde'
);
select * from tbl_member;

-- user_sequences

select
    *
from
    user_sequences;

-- 문자열과 시퀀스발급 숫자를 복합적으로 사용하기
-- 주문번호 : kh-20221108-0023

create table orders (
    order_no varchar2(20),
    username varchar2(20),
    prod_code varchar2(20),
    cnt number default 1,
    created_at date default sysdate,
    constraint pk_orders_no primary key(order_no)

);

create sequence seq_orders_no;

insert into orders
    (order_no, username, prod_code)
values (
    'kh-' || to_char(sysdate, 'yyyymmdd') ||'-' || to_char(seq_orders_no.nextval, 'fm0000'),
    'honggd',
    'applewatch'
);

insert into orders
    (order_no, username, prod_code)
values (
    'kh-' || to_char(sysdate, 'yyyymmdd') ||'-' || to_char(seq_orders_no.nextval, 'fm0000'),
    'sinsa',
    'soccer_shoes'
);

select * from orders;

-- 시퀀스 수정 : start with 수정불가 | increment by 수정가능 
-- start with은 수정 불가하기 때문에 삭제 후 재생성할 수 밖에 없다.

alter sequence seq_orders_no increment by 10;


--------------------------------------------------------------------
-- INDEX
--------------------------------------------------------------------
-- 색인. sql문 쿼리속도 향상을 위해 테이블 컬럼에 대해 생성하는 객체.
-- key-value 형식으로 구성. key는 실제 컬럼밗. value는 특정행에 대한 주소값을 저장.

-- 장점
-- 1. 검색속도가 빨라지고, 시스템부하를 줄일 수 있다.

-- 단점
-- 1. 인덱스를 위한 별도의 공간이 필요.
-- 2. 인덱스 생성 및 수정에 대한 비용 있음.
-- 3. 단순 조회보다 dml작업이 많은 table인 경우 성능저하가 있을 수 있음.

-- 인덱스에 대상이 될 컬럼 선정하기
-- 1. 선택도가 좋은 컬럼을 선정해야 한다.
-- 선택조(selectiviry)란? 고유한 값을 가지는 정도. 중복값이 없을수록 선택도는 높다.
-- 사번, 주민번호, 이메일, 전화번호 - 선택도 최상 (중복값 없음)
-- 이름 - 선택도 상
-- 부서코드 - 선택도 중상
-- 성별 - 선택도 하

-- 2. whrer절에 자주 사용되는 컬럼
-- 3. 조인시 기준컬럼에 자주 사용되는 컬럼
-- 4. 컬럼값 변경이 자주 일어나지 않는 컬럼
-- 5. 테이블 저장된 데이터가 아주 많은 경우

-- PK, UQ 제약조건 생성시 자동으로 인덱스 생성
select * from user_indexes;

-- 한 행 조회시
select * from employee where job_code = 'J1'; -- table full scan

-- 한 행 조회시
select * from employee where emp_id = '201'; -- index unique scan

select * from employee where emp_name = '송종기';
select * from employee where dept_code = 'D5';

-- 인덱스 생성
create index idx_employee_emp_name on employee (emp_name);
select * from employee where emp_name = '송종기'; -- range scan으로 변경됨

-- 인덱스 사용시 주의사항
-- 인덱스 사용여부는 오라클에 내장된 optimizer가 결정함.
-- optimizer가 인덱스를 사용하지 않는 경우
-- 1. 인덱스 컬럼에 변형이 가해진 경우. substr(emp_no, 8, 1)
-- 2. null 비교하는 경우. emp_name is null
-- 3. not 비교하는 경우. emp_name != '송종기'
-- 4. 인덱스 지정컬럼과 자료형이 다른 값을 비교하는 경우. emp_id = 201
select * from employee where emp_id = '201';
select * from employee where emp_id = 201;

--===============================================================
-- PL/SQL
--===============================================================
-- Procedural Language Extension to SQL
-- 오라클에 내장되어 있는 절차적 언어.
-- 변수선언, 조건처리, 반복처리, 예외처리 등을 지원한다.

-- pl/sql 유형
-- 1. 익명블럭 (1회용)
-- 2. pl/sql 객체 - procedure, function, trigger, job scheduler ...
    -- 컴파일 된 상태로 db server에 저장되므로 호출/실행 속도가 빠르다.

/*
    declare -- 선언부 (선택)
        -- 지역변수/상수 선언
    begin -- 실행부 (필수)
        -- 제어문 작성
    exception -- 예외처리부 (선택)
        -- bigin구문 예외 발생시 예외처리구문 작성
    end;
    /
    익명블럭 종료 의미
*/
-- 매 session마다 출력을 활성화 해야 함.
set serveroutput on;

begin
    dbms_output.put_line('hello world');
end;
/

declare
    v_id number := 100;
begin
    dbms_output.put_line(v_id);

    -- 선동일 사원의 emp_id 조회
    select
        emp_id
    into
        v_id
    from
        employee
    where
        emp_name = '&사원명';
    dbms_output.put_line(v_id);

exception
    when no_data_found then dbms_output.put_line('조회된 사원이 없습니다.');

end;
/

--------------------------------------------------------------
-- 변수/자료형
--------------------------------------------------------------
-- 1. 기본자료형
    -- 문자 : varchar2, char, clob
    -- 숫자 : number, binary indeger, pls_integer 
    -- 날짜 : datd, timestamp
    -- 논리 : boolean
-- 2. 복합자료형
    -- record (컬럼모음)
    -- cursor (행모음)
    -- collection 

-- 스칼라 변수
    -- no number;
    -- name varchar2(20);
    -- email varchar2(50) := 'honggd@naver.com';
-- 스칼라 상수
    -- pi constant number := 3.14;

-- 참조 변수
    -- 미리 선언된 테이블 또는 컬럼의 자료형을 가져와 사용가능.
    -- 1. %type : 특정 컬럼의 자료형
        -- v_emp_no employee.emp_no%type;
    -- 2. %rowtype : 테이블의 자료형 (모든 컬럼 자료형 한번에 참조)
        -- v_emp employee%rowtype;
    -- 3. %record 변수 : 특정 컬럼 모음
declare
    v_no number;
    v_name varchar2(50);
    bonus constant number := 0.01;
    bool boolean;
    
begin
    v_no := 123;
    v_name := '홍길동';
    bool := true;
    
    dbms_output.put_line('v_no = '||v_no);
    dbms_output.put_line('v_name = '||v_name);
    dbms_output.put_line('bonus = '||to_char(bonus, 'fm0.00'));
    
    if bool then
            dbms_output.put_line('bool 은 참입니다. ');
    end if;

end;
/

declare
    v_emp_id employee.emp_id%type := '&사번';
    v_emp_name employee.emp_name%type;
    v_emp_no employee.emp_no%type;
begin
    select
        emp_name, emp_no
    into
        v_emp_name, v_emp_no
    from
        employee
    where
        emp_id = v_emp_id;
    
    dbms_output.put_line('이름 = '||v_emp_name);
    dbms_output.put_line('주민번호 = '||v_emp_no);
    
end;
/

declare
    emp_row employee%rowtype;
begin
    select 
        *
    into   
        emp_row    
    from
        employee
    where
        emp_id = '&사번';

    dbms_output.put_line('사번 = '||emp_row.emp_id);
    dbms_output.put_line('이름 = '||emp_row.emp_name);
    dbms_output.put_line('전화번호 = '||emp_row.phone);
    dbms_output.put_line('급여 = '||emp_row.salary);
end;
/

declare
    type my_emp_rowtype is record (
        emp_name employee.emp_name%type,
        dept_title department.dept_title%type,
        job_name job.job_name%type
    );
    erow my_emp_rowtype;
begin
    select
        emp_name,
        (select dept_title from department where dept_id = e.dept_code) dept_title,
        (select job_name from job where job_code = e.job_code) job_name
    into
        erow
    from
        employee e
    where
        emp_id = '&사번';
    
    dbms_output.put_line('이름 = '||erow.emp_name);
    dbms_output.put_line('부서 = '||erow.dept_title);
    dbms_output.put_line('직급 = '||erow.job_name);
end;
/

-- 사번을 입력받고, 사원명, 직급명, 전화번호를 콘솔출력하는 익명블력을 생성하세요.

declare
    type my_emp_rowtype is record (
        emp_name employee.emp_name%type,
        dept_title department.dept_title%type,
        phone employee.phone%type
    );
    erow my_emp_rowtype;
begin
    select
        emp_name,
        (select dept_title from department where dept_id = e.dept_code) dept_title,
        phone
    into
        erow
    from
        employee e
    where
        emp_id = '&사번';
    
    dbms_output.put_line('사원명 = '||erow.emp_name);
    dbms_output.put_line('직급명 = '||erow.dept_title);
    dbms_output.put_line('전화번호 = '||erow.phone);
end;
/

-------------------------------------------------------------------
-- SQL
-------------------------------------------------------------------
-- DML/DQL 실행 가능
-- 익명블럭 안에서 dml 사용시에는 TCL 함께 처리 (commit)

select * from member;

begin
    insert into
        member
    values (
        'sinsa', '1234', '신사임당', 'sinsa@naver.com', to_date('19990909'), 2000, 'N'
    );
    commit;
end;
/

-- honggd 생일에 sinsa 생일값을 넣기
declare
    v_birthday member.birthday%type;
begin
    -- 1. sinsa 생일값 읽어오기
    select
        birthday
    into
        v_birthday
    from
        member
    where
        id = 'sinsa';
    dbms_output.put_line(v_birthday);
    -- 2. honggd 생일 수정
    update member
    set
        birthday = v_birthday
    where
        id = 'honggd';
    commit;
end;
/

------------------------------------------------------------
-- 조건문
------------------------------------------------------------
-- if문
-- if ~ else문
-- if ~ elseif ~문

declare
    n number := &숫자;
begin
    if n = 0 then
    dbms_output.put_line(n||'을 입력하셨습니다.');
    elsif mod(n, 2) = 0 then
       dbms_output.put_line(n||'은 짝수입니다.'); 
    else
       dbms_output.put_line(n||'은 홀수입니다.'); 
    end if;
        dbms_output.put_line('------끝------'); 
end;
/

-- 사번을 입력받고, 해당 사원의 직급별 평균급여보다 많거나 적은 급여를 받는지 판단하는 익명블럭
-- v_emp_id
-- v_salary
-- v_avg_sal_by_job

-- 결과 : 해당 사원은 직급평균보다 많은 급여를 받습니다.
-- 해당 사원은 직급평균보다 적은 급여를 받습니다.
-- 해당 사원은 직급평균만큼의 급여를 받습니다.
declare
    type my_emp_rowtype is record (
        v_emp_id employee.emp_id%type,
        v_salary employee.salary%type,
        v_avg_sal_by_job employee.salary%type
    );
    erow my_emp_rowtype;
begin
    select
        emp_id,
        salary,
        (select trunc(avg(salary)) from employee where job_code = e.job_code) v_avg_sal_by_job
    into
        erow
    from
        employee e
    where
        emp_id = '&사번';
    dbms_output.put_line(erow.v_salary); 
    dbms_output.put_line(erow.v_avg_sal_by_job); 
    
    if erow.v_salary = erow.v_avg_sal_by_job then
    dbms_output.put_line('해당 사원은 직급평균만큼의 급여를 받습니다.');
    elsif erow.v_salary < erow.v_avg_sal_by_job then
       dbms_output.put_line('해당 사원은 직급평균보다 적은 급여를 받습니다.'); 
    else
       dbms_output.put_line('해당 사원은 직급평균보다 많은 급여를 받습니다.'); 
    end if;
end;
/

select * from employee;

declare
    v_emp_id employee.emp_id%type := '&사번';
    v_salary employee.salary%type;
    v_avg_sal_by_job employee.salary%type;
begin
    -- 해당사원의 급여/직급별 평균급여 조회
    select
        salary,
        (select avg(salary) from employee where job_code = e.job_code) v_avg_sal_by_job
    into
        v_salary,
        v_avg_sal_by_job
    from
        employee e
    where
        emp_id = v_emp_id;
        
    dbms_output.put_line('급여 = '||v_salary); 
    dbms_output.put_line('평균급여 = '||v_avg_sal_by_job); 
    -- 값 비교
    if v_salary = v_avg_sal_by_job then
    dbms_output.put_line('해당 사원은 직급평균만큼의 급여를 받습니다.');
    elsif v_salary < v_avg_sal_by_job then
       dbms_output.put_line('해당 사원은 직급평균보다 적은 급여를 받습니다.'); 
    else
       dbms_output.put_line('해당 사원은 직급평균보다 많은 급여를 받습니다.'); 
    end if;
end;
/


declare
    v_emp_id employee.emp_id%type := '&사번';
    v_salary employee.salary%type;
    v_avg_sal_by_job employee.salary%type;
begin
    -- 해당사원의 급여/직급별 평균급여 조회
    select
        salary,
        (select avg(salary) from employee where job_code = e.job_code) avg_sal_by_job
    into
        v_salary, 
        v_avg_sal_by_job
    from
        employee e
    where
        emp_id = v_emp_id;
    
    dbms_output.put_line(v_salary || ' ' || v_avg_sal_by_job);
    
    -- 값비교
    if v_salary > v_avg_sal_by_job then
        dbms_output.put_line('해당사원은 직급평균보다 많은 급여를 받습니다.');
    elsif v_salary < v_avg_sal_by_job then
        dbms_output.put_line('해당사원은 직급평균보다 적은 급여를 받습니다.');
    else
        dbms_output.put_line('해당사원은 직급별 평균 급여를 받습니다.');
    end if;
    
end;
/

-- case문
/*
    type 1) 조건식
    case
        when 조건식1 then 실행문1;
        when 조건식2 then 실행문2;
        when 조건식3 then 실행문3;
        ...
        else 기본실행문;
    end case;
    
    type 2)
    case 표현식
        when 값1 then 실행문1;
        when 값2 then 실행문2;
        when 값3 then 실행문3;
        ...
        else 기본실행문;
    end case;
*/

accept 가위바위보 prompt '가위바위보 하세요. (1:가위 2:바위 3:보)'
declare
    user number := &가위바위보;
begin
    case
        when user = 1 then dbms_output.put_line('가위를 냈습니다.');
        when user = 2 then dbms_output.put_line('바위를 냈습니다.');
        else dbms_output.put_line('보를 냈습니다.');
    end case;
end;
/    
        
accept 가위바위보 prompt '가위바위보 하세요. (1:가위 2:바위 3:보)'
declare
    user number := &가위바위보;
    com number := trunc(dbms_random.value(1,4));
begin
    dbms_output.put_line('user : '||user);
    dbms_output.put_line('com : '||com);

    case user
        when 1 then dbms_output.put_line('가위를 냈습니다.');
        when 2 then dbms_output.put_line('바위를 냈습니다.');
        else dbms_output.put_line('보를 냈습니다.');
    end case;
    -- 결과
    if com = 3 and user = 1 then
    dbms_output.put_line('당신이 이겼습니다.');
    elsif com = 1 and user = 3 then
    dbms_output.put_line('당신이 졌습니다.');
    elsif com < user then
    dbms_output.put_line('당신이 이겼습니다.');
    elsif com > user then
    dbms_output.put_line('당신이 졌습니다.');
    else
       dbms_output.put_line('비겼습니다.'); 
    end if;
end;
/ 

--------------------------------------------------------------------
-- 반복문
--------------------------------------------------------------------
-- 기본반복문 loop ... end loop;
-- while 반복문 while 조건식 loop ... end loop;
-- for ..in 반복문 for .. in loop... 둥 ㅣㅐㅐㅔ;

-- 기본반복문 (무한반복)
declare
    n number := 1;
begin
    loop
        dbms_output.put_line(n);
        n := n + 1;
    -- 중지
    exit when n > 5;
    end loop;
end;
/

-- while loop
declare
    i number := 1;
begin
   while i <= 5 loop
        dbms_output.put_line(i);
        i := i + 1;
    end loop;
end;
/

-- 1~10 사이의 난수 10개 출력 익명블럭 작성

-- 사용자에게 2 ~9 사이의 수를 입력받아 해당 단수의 구구단 출력



-- for .. in loop
begin
    -- 증감변수 선언, 증감처리
    -- 시작값..종료값 : 무조건 1씩 증가
    -- 역순 처리시 reverse 키워드 사용
    for i in 1..5 loop
        dbms_output.put_line(i);
    end loop;
end;
/

-- 구구단 2단 출력
declare 
    dan number := 2;
begin
    for n in 1..9 loop
        dbms_output.put_line(dan ||'*'||n||'='||dan*n);
    end loop;
end;
/

-- 구구단 출력
begin
    for dan in 2..9 loop
        for n in 1..9 loop
            dbms_output.put_line(dan ||'*'||n||'='||dan*n);
        end loop;
    end loop;
end;
/

-- begin절 안에 다시 begin절 추가해서 예외처리 가능
declare
    e employee % rowtype;
begin
    for n in 200..302 loop
        begin
            select 
                *
            into
                e 
            from
                employee
            where
                emp_id = n;
                
        dbms_output.put_line(e.emp_id ||'  '|| e.emp_name||'   '||e.phone);
        
        exception
            when no_data_found then continue; -- 반복문 다시 시작
        end;        
    end loop;
end;
/


---------------------------------------------------------------------
-- STORED FUNCTION
---------------------------------------------------------------------
-- procedure 의 한 종류. 리턴값이 반드시 하나 존재하는 프로시져 객체
/*
    create [or replace] function 함수명 (매개변수1 자료형, 매개변수 2 자료형, ...)
    return 타입
    is
        지역변수 선언
    begin
        실행구문
        return값;
    exception
        예외처리구문
        return값;
    end;
    /
*/

-- 헤드폰씌우기 함수
-- 문자열 -> d문자열b
-- 매개변수, 리턴타입에 자료형은 크기값을 작성하지 않는다.
create or replace function my_func (
    p_str varchar2
)
return varchar2
is
begin
    return 'd'||p_str||'b';
end;
/

select my_func('홍길동') from dual;
select my_func(emp_name) from employee;
declare
    result varchar2(32767);
begin
    result := my_func('&이름');
    dbms_output.put_line(result);
end;
/

-- 급여, 보너스를 입력받아서 연봉을 반환하는 함수 fn_clac_annual_pay
-- 사원명, 급여, 보너스, 연봉 출력
create or replace function fn_clac_annual_pay (
    salary number,
    bonus number
)
return number
is
begin
    return (salary*(1+bonus))*12;
end;
/
select
    emp_name 사원명,   
    salary 급여,
    nvl(bonus,0) 보너스, 
    fn_clac_annual_pay(salary, nvl(bonus,0)) 연봉
from
    employee;

declare
    result employee.salary%type;
begin
    result := fn_clac_annual_pay('&이름');
    dbms_output.put_line(result);
end;
/

-- 주민번호를 입력받아 성별을 반환하는 함수 fn_gender
-- 사번, 사원명, 성별 조회
-- decode는 sql 밖에서 단독으로 사용 불가
create or replace function fn_gender (
    emp_no employee.emp_no%type
)
return char
is
    gender char(3);
begin
    case substr(emp_no, 8, 1)
        when '1' then gender := '남';
        when '3' then gender := '남';
        else gender := '여';
    end case;
    return gender;
end;
/
select
    emp_id 사번,   
    emp_name 사원명,
    fn_gender(emp_no) 성별
from
    employee;
    
select * from user_procedures where object_type = 'FUNCTION';

-------------------------------------------------------------------
-- STORED PROCEDURE
-------------------------------------------------------------------
-- 일련의 작업절차를 pl/sql문법에 따라 작성한 객체.
-- 함수와 달리 반환값이 없다.
-- out모드 매개변수를 통해 반환값이 없어도 호출부에 n개의 실행결과값을 전달가능
-- 함수, 프로시져는 dbms에 미리 컴파일된 상태로 저장되므로, 일반 sql처리보다 효율적이다
-- 일반 sql에서는 procedure 호출불가. 다른 익명블럭 또는 다른 프로시저에서만 호출가능.

/*
    create [or place] procedure 프로시져명 (
    매개변수1 [모드] 자료형1,
    매개변수2 [모드] 자료형2,
    ...
    )
    is
        -- 지역변수 선언
    begin
        --  실행구문
    end;
    /

    모드
    1. in : 프로시져에 전달할 값. 기본값
    2. out : 프로시져로부터 호출부로 전달될 변수(공간)
    3. inout : in + out 
*/

-- 사번을 받아 사원삭제 프로시져 proc_del_emp
select * from ex_employee;

create or replace procedure proc_del_emp(p_emp_id in employee.emp_id%type)
is
begin
    delete from
        ex_employee
    where
        emp_id = p_emp_id;
    commit;
    dbms_output.put_line(p_emp_id || '번 사원을 삭제했습니다.');
end;
/

begin
    proc_del_emp('&사번'); -- in모드 매개변수
    dbms_output.put_line('삭제 완료');
end;
/

-- 사번을 입력해서 사원정보 조회 (이름,이메일,전화번호)
create or replace procedure proc_find_by_emp_id(
    p_emp_id in employee.emp_id%type,
    p_emp_name out employee.emp_name%type,
    p_email out employee.email%type,
    p_phone out employee.phone%type
)
is
begin
    select
        emp_name, email, phone
    into
        p_emp_name, p_email, p_phone
    from
        employee
    where
        emp_id = p_emp_id;
end;
/

declare
    v_emp_id employee.emp_id%type := '&사번';
    v_emp_name employee.emp_name%type;
    v_email employee.email%type;
    v_phone employee.phone%type;
begin
    proc_find_by_emp_id(v_emp_id, v_emp_name, v_email, v_phone);
    
    dbms_output.put_line('이름 : ' || v_emp_name);
    dbms_output.put_line('이메일 : ' || v_email);
    dbms_output.put_line('전화번호 : ' || v_phone);
end;
/

-- upsert 예제 (update + insert)
-- 데이터가 존재하지 않으면 insert
-- 데이터가 존재하면, 새데이터로 update

create table ex_job
as
select * from job;

select * from ex_job;

alter table ex_job
add constraint pk_ex_job_code primary key(job_code)
modify job_code varchar2(5)
modify job_name not null;

select * from ex_job;

create or replace procedure proc_upsert_ex_job(
    p_job_code ex_job.job_code%type,
    p_job_name ex_job.job_name%type
)
is
    cnt number;
begin
    -- p_job_code 존재여부
    select
        count(*)
    into
        cnt
    from 
        ex_job
    where
        job_code = p_job_code;
        
    if cnt = 0 then
    -- p_job_code 존재하지 않는 경우 insert
        dbms_output.put_line(p_job_code||'가 존재하지 않습니다.');
        insert into
            ex_job
        values (
            p_job_code, p_job_name
        );

    else
    -- p_job_code 존재하는 경우 update
        dbms_output.put_line(p_job_code||'가 존재합니다.');
        update
            ex_job
        set 
            job_name = p_job_name
        where
            job_code = p_job_code
        ;
    end if;
    -- transaction 처리
    commit;
end;
/

begin
    proc_upsert_ex_job('J1', '회장');
    proc_upsert_ex_job('J8','수습');
end;
/
select * from ex_job;









