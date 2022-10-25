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
        sysdate + to_yminterval('+1-02') + to_dsinterval('+03 04:05:06'),
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
    end "성별",
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
    extract(year from sysdate) - decode(substr(emp_no, 1, 2), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2) + 1 "(한국)나이"
from
    employee;




