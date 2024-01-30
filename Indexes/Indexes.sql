

--UserAccount Table:
CREATE INDEX IX_UserAccount_UserType ON UserAccount (UserType);
CREATE INDEX IX_UserAccount_UserName ON UserAccount (UserName);
GO


--TrainingManager Table:
CREATE INDEX IX_TrainingManager_TrainingManagerName ON TrainingManager (TrainingManagerName);
GO
--Instructor Table:
CREATE INDEX IX_Instructor_InstructorName ON Instructors (InstructorName);
CREATE INDEX IX_Instructor_CourseID ON Instructors (CourseID);
GO
--Student Table:
CREATE INDEX IX_Student_StudentName ON Students (StudentName);

--Course Table:
CREATE INDEX IX_Course_CourseName ON Courses (CourseName);
GO
--Department Table:
CREATE INDEX IX_Department_DepartmentName ON Departments (DepartmentName);
GO
--Branch Table:
CREATE INDEX IX_Branch_BranchName ON Branches (BranchName);
GO
--Track Table:
CREATE INDEX IX_Track_TrackName ON Tracks (TrackName);

GO
--Intake Table:
CREATE INDEX IX_Intake_IntakeName ON Intakes (IntakeName);
GO
--Question Table:
CREATE INDEX IX_Question_QuestionType ON Questions (QuestionType);
GO

--Result Table:
CREATE INDEX IX_Result_StudentID ON Results (StudentID);
GO
-- Index on StudentEnrollment Table:
CREATE INDEX IX_StudentEnrollment_StudentID ON StudentEnrollment (StudentID);
CREATE INDEX IX_StudentEnrollment_CourseID ON StudentEnrollment (CourseID);
GO