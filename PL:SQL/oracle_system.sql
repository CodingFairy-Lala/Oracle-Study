--==================================================
-- SYSTEM 계정
--==================================================

-- 한줄 주석
/*
    여러줄 주석
*/

show user;
select * from sys.dba_users;
select username, account_status from dba_users;
GRANT CREATE SESSION TO admin;
grant create view, create session, create table, create procedure to admin;

-- 관리자 sys| system
-- 1. sys 슈퍼관리자 db관련 모든 권한을 가지고, 문제를 해결할 수 있다. DB 인스턴스 생성/삭제 권한 있음. sysdba롤로 접속해야 함.
-- 2. system 일반관리자. db관련 모든 권한을 가지고, 문제를 해결할 수 있다. 일반롤로 접속해야 함.

-- blossom 계정 생성
-- 12c 부터 일반 사용자는 c## 또는 C##으로 시작하는 이름을 가져야 한다.
alter session set "_oracle_script" = true; -- 이를 회피하는 설정.


create user blossom -- 사용자명 (대소문자 구분 안함)
identified by fiigo1324AAA -- 비밀번호 (대소문자 구분함)
default tablespace data; -- tavlespace 실제 테이블 등의 객체가 존재하는 파일공간. system. users, ...

--drop user sh;

alter user blossom quota unlimited on users;

-- create session 권한이 없어 로그온 거절.
-- grant create session to sh;

-- 롤(권한 묶음) 부여도 가능
-- connect : create session 권한 포함.
-- recousrce : create table 등 객체 생성 권한 포함.
grant connect, resource to blossom;