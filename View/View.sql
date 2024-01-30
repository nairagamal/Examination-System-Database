--1. View for Students in a Course:
CREATE VIEW vw_StudentsInCourse AS
SELECT
    S.StudentID,
    S.StudentName,
    S.IntakeID,
    S.BranchID,
    S.TrackID,
    C.CourseName
FROM
    Students AS S
INNER JOIN StudentEnrollment AS SE ON S.StudentID = SE.StudentID
INNER JOIN Courses AS C ON SE.CourseID = C.CourseID;

GO



--3. Display Course Enrollment Information: -->
--Shows information about students enrolled in each course.
CREATE VIEW vw_CourseEnrollmentView AS
SELECT
    C.CourseID,
    C.CourseName,
    COUNT(SE.StudentID) AS EnrolledStudents
FROM
    Courses C
    LEFT JOIN StudentEnrollment SE ON C.CourseID = SE.CourseID
GROUP BY
    C.CourseID, C.CourseName;

GO

--4. View for Exam Results:-->
CREATE VIEW vw_ExamResults AS
SELECT
    R.StudentID,
    S.StudentName,
    E.ExamID,
    E.ExamType,
    E.StartTime,
    E.EndTime,
    E.TotalTime,
    E.MaxDegree,
    R.TotalScore
FROM
    Results AS R
INNER JOIN Students AS S ON R.StudentID = S.StudentID
INNER JOIN Exams AS E ON R.ExamID = E.ExamID;
GO


--6. View for Courses Taught by an Instructor:
CREATE VIEW vw_InstructorCourses AS
SELECT
    I.InstructorID,
    I.InstructorName,
    C.CourseID,
    C.CourseName,
    C.Descript
FROM
    Instructors AS I
INNER JOIN Courses AS C ON I.CourseID = C.CourseID;
GO


--7. View for Students' Exam Schedule--->
CREATE VIEW ExamScheduleView AS
SELECT
    E.ExamID,
    E.ExamType,
    E.StartTime,
    E.EndTime,
    C.CourseName,
    I.InstructorName,
    I.InstructorEmail,
    I.InstructorPhone
FROM
    Exams E
    JOIN Courses C ON E.CourseID = C.CourseID
    JOIN Instructors I ON E.InstructorID = I.InstructorID;

GO
