--=====================================================
-- chun 실습문제
--=====================================================
select * from tb_department; -- 학과 테이블
select * from tb_student; -- 학생 테이블
select * from tb_professor; -- 교수 테이블
select * from tb_class; -- 과목 테이블
select * from tb_class_professor; -- 과목-교수 테이블
select * from tb_grade; -- 학점 테이블

-- 1. 의학계열 학과 학생들의 학번/학생명/학과명 조회
select
    student_no 학번,
    student_name 학생명,
    department_name 학과명
from
    tb_department d join tb_student s
        on d.department_no = s.department_no
where
    category = '의학';


-- 2. 2005학년도 입학생의 학생명/담당교수명 조회
select
    student_name 학생명,
    professor_name 담당교수명
from
    tb_student s left join tb_professor p
        on s.coach_professor_no = p.professor_no
where
    extract(year from entrance_date) = 2005;

-- 3. 자연과학계열의 수업명, 학과명 조회
select
    class_name 수업명,
    department_name 학과명
from
    tb_department d left join tb_class c
        on d.department_no = c.department_no
where
    category = '자연과학';


-- 4. 담당학생이 한명도 없는 교수 조회
select
    student_name 학생명,
    professor_name 담당교수명
from
    tb_student s right join tb_professor p
        on s.coach_professor_no = p.professor_no
where
    coach_professor_no is null;





