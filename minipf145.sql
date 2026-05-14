CREATE DATABASE StudentDB;
USE StudentDB;

-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID VARCHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID VARCHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID VARCHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID VARCHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID VARCHAR(6),
    CourseID VARCHAR(6),
    Score DECIMAL(4,2), 
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Chèn dữ liệu mẫu
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

-- câu 1
create or replace view ViewStudentBasic as
    select s.StudentID, s.FullName, d.DeptName
    from Student s
    join Department d on s.DeptID = d.DeptID;

select * from ViewStudentBasic;

-- câu 2
create index idxFullName on Student(FullName);

-- câu 3
delimiter $$
create procedure GetStudentsIT()
begin
    select s.StudentID, s.FullName, s.Gender,
           s.BirthDate, d.DeptName
    from Student s
    join Department d on s.DeptID = d.DeptID
    where d.DeptName = 'Information Technology';
end$$
delimiter ;

call GetStudentsIT();

-- câu 4 a
create or replace view ViewStudentCountByDept as
    select d.DeptName,
           count(s.StudentID) as TotalStudents
    from Department d
    left join Student s on d.DeptID = s.DeptID
    group by d.DeptID, d.DeptName;

-- câu 4b
select DeptName, TotalStudents
from ViewStudentCountByDept
order by TotalStudents desc
limit 1;

-- câu 5a
delimiter $$
create procedure GetTopScoreStudent(
    in varCourseID varchar(6)
)
begin
    select s.StudentID, s.FullName, s.Gender,
           e.Score, c.CourseName
    from Enrollment e
    join Student s  on e.StudentID = s.StudentID
    join Course c   on e.CourseID  = c.CourseID
    where e.CourseID = varCourseID
      and e.Score = (
          select max(Score)
          from Enrollment
          where CourseID = varCourseID
      );
end$$
delimiter ;

-- câu 5b
call GetTopScoreStudent('C00001');