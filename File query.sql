CREATE DATABASE ExaminationSystem
ON PRIMARY
(
    NAME = 'ExaminationSystem-Data',
    FILENAME = 'D:\ITI\SQL PROJECT\ExaminationSystem-Data.mdf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 10%
)
LOG ON
(
    NAME = 'ExaminationSystem_Log',
    FILENAME = 'D:\ITI\SQL PROJECT\ExaminationSystem_Log.ldf',
    SIZE = 5MB,
    MAXSIZE = 40MB,
    FILEGROWTH = 10%
);

--  UserAccount
CREATE TABLE UserAccount (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(50) UNIQUE  ,
    Pword VARCHAR(100) NOT NULL,
    UserType VARCHAR(20) -- UserType can be 'Admin', 'TrainingManager', 'Instructor', 'Student'
);

--  TrainingManager
CREATE TABLE TrainingManager (
    TrainingManagerID INT PRIMARY KEY,
    TrainingManagerName VARCHAR(100)
);


--  Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
	TrainingManagerID INT ,
	FOREIGN KEY (TrainingManagerID) REFERENCES TrainingManager(TrainingManagerID)
);


--  Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Descript VARCHAR(MAX),
    MaxDegree INT,
    MinDegree INT,
	DepartmentID INT,
	FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
);

--  Instructors
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(100) NOT NULL,
	InstructorEmail VARCHAR(100) NOT NULL,
	InstructorPhone VARCHAR(100) ,
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

--  Branches
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
	DepartmentID INT,
	TrainingManagerID INT,
	FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
	FOREIGN KEY (TrainingManagerID) REFERENCES TrainingManager(TrainingManagerID)
);


--  Tracks
CREATE TABLE Tracks (
    TrackID INT PRIMARY KEY,
    TrackName VARCHAR(100) NOT NULL,
    DepartmentID INT,
	TrainingManagerID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
	FOREIGN KEY (TrainingManagerID) REFERENCES TrainingManager(TrainingManagerID)
);


--  Intakes
CREATE TABLE Intakes (
    IntakeID INT PRIMARY KEY,
    IntakeName VARCHAR(50) NOT NULL,
	TrainingManagerID INT,
	FOREIGN KEY (TrainingManagerID) REFERENCES TrainingManager(TrainingManagerID)
);

--  Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
	StudentEmail VARCHAR(100) NOT NULL,
	StudentPhone VARCHAR(100),
    IntakeID INT,
    BranchID INT,
    TrackID INT,
	FOREIGN KEY (IntakeID) REFERENCES Intakes(IntakeID),
	FOREIGN KEY (BranchID) REFERENCES Branches(BranchID),
	FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID)
);


-- StudentEnrollment Table:
CREATE TABLE StudentEnrollment (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    CONSTRAINT FK_StudentEnrollment_StudentID FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_StudentEnrollment_CourseID FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


--  InstructorCourses
CREATE TABLE InstructorCourses (
    InstructorID INT,
    CourseID INT,
	IntakeID INT,
    BranchID INT,
    TrackID INT,
	PRIMARY KEY (InstructorID, CourseID),
	FOREIGN KEY (IntakeID) REFERENCES Intakes(IntakeID),
	FOREIGN KEY (BranchID) REFERENCES Branches(BranchID),
	FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);



--  Exams
CREATE TABLE Exams (
    ExamID INT PRIMARY KEY,
    ExamType VARCHAR(50) NOT NULL,
	allowance_options VARCHAR(50),
    IntakeID INT,
    BranchID INT,
    TrackID INT,
    CourseID INT,
    InstructorID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    TotalTime INT,
    MaxDegree INT,
    FOREIGN KEY (IntakeID) REFERENCES Intakes(IntakeID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID),
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

--  Questions
CREATE TABLE Questions (
    QuestionID INT PRIMARY KEY,
    QuestionText VARCHAR(MAX) NOT NULL,
    QuestionType VARCHAR(50) NOT NULL,
    CorrectAnswer VARCHAR(MAX) NOT NULL,
    BestAcceptedAnswer VARCHAR(MAX) NOT NULL,
	QuestionDegree INT NOT NULL,
    CourseID INT,
    InstructorID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);
--  ExamQuestions
CREATE TABLE ExamQuestions (
    ExamID INT,
    QuestionID INT,
    PRIMARY KEY (ExamID, QuestionID),
    FOREIGN KEY (ExamID) REFERENCES Exams(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID),
);

--  StudentExams
CREATE TABLE StudentExams (
    StudentExamID INT PRIMARY KEY,
    ExamID INT,
    StudentID INT,
    ExamDate DATETIME,
    StartTime DATETIME,
    EndTime DATETIME,
	ExamDegree INT,
    FOREIGN KEY (ExamID) REFERENCES Exams(ExamID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

--  StudentAnswers
CREATE TABLE StudentAnswers (
    AnswerID INT PRIMARY KEY,
    StudentExamID INT,
    QuestionID INT,
    StudentAnswer VARCHAR(MAX),
    IsCorrect BIT,
    FOREIGN KEY (StudentExamID) REFERENCES StudentExams(StudentExamID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);


--  Results
CREATE TABLE Results (
    ResultID INT PRIMARY KEY,
    StudentID INT,
    ExamID INT,
    TotalScore INT,
    Grade VARCHAR(50),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
);

----------------------------------------procedures

--User Account Management:
-- Stored Procedure: Create a new user account
CREATE PROCEDURE usp_CreateUserAccount
	@ID INT,
    @UserName VARCHAR(50),
    @Password VARCHAR(100),
    @UserType VARCHAR(20)
AS
BEGIN
    INSERT INTO UserAccount (UserID, UserName, Pword, UserType)
    VALUES (@ID, @UserName, @Password, @UserType);
END;
GO

CREATE PROCEDURE usp_UpdateUserAccount
    @UserID INT,
    @Password VARCHAR(50)
AS
BEGIN
    UPDATE UserAccount
    SET Pword = @Password
    WHERE UserID = @UserID;
END;

GO


-- Stored Procedure: Delete user account
CREATE PROCEDURE usp_DeleteUserAccount
    @UserID INT
AS
BEGIN
    DELETE FROM UserAccount
    WHERE UserID = @UserID;
END;
GO




--Course Management:
-- Stored Procedure: Add a new course
CREATE PROCEDURE usp_AddCourse
	@CourseID INT,
    @CourseName VARCHAR(100),
    @Description VARCHAR(MAX),
    @MaxDegree INT,
    @MinDegree INT
AS
BEGIN
    INSERT INTO Courses (CourseID,CourseName, Descript, MaxDegree, MinDegree)
    VALUES (@CourseID,@CourseName, @Description, @MaxDegree, @MinDegree);
END;
GO

-- Execute usp_AddCourse with new values
EXEC usp_AddCourse
    @CourseID = 102,
    @CourseName = 'Introduction to SQL',
    @Description = 'A beginner-level course on SQL programming.',
    @MaxDegree = 100,
    @MinDegree = 0;


-- Stored Procedure: Update a course
CREATE PROCEDURE usp_UpdateCourse
    @CourseID INT,
    @CourseName VARCHAR(100),
    @Description VARCHAR(MAX),
    @MaxDegree INT,
    @MinDegree INT
AS
BEGIN
    UPDATE Courses
    SET CourseName = @CourseName, Descript = @Description, MaxDegree = @MaxDegree, MinDegree = @MinDegree
    WHERE CourseID = @CourseID;
END;
GO
-- Stored Procedure: Delete a course
CREATE PROCEDURE usp_DeleteCourse
    @CourseID INT
AS
BEGIN
    DELETE FROM Courses
    WHERE CourseID = @CourseID;
END;
GO


-- Stored Procedure: Get courses by instructor
CREATE PROCEDURE usp_GetCoursesByInstructor
    @InstructorID INT
AS
BEGIN
    SELECT C.*
    FROM Courses C
    INNER JOIN InstructorCourses IC ON C.CourseID = IC.CourseID
    WHERE IC.InstructorID = @InstructorID;
END;
GO




--Instructor Management:
-- Stored Procedure: Add a new instructor
CREATE PROCEDURE usp_AddInstructor
	@InstructorID INT,
    @InstructorName VARCHAR(100),
    @CourseID INT
AS
BEGIN
    INSERT INTO Instructors (InstructorID,InstructorName, CourseID)
    VALUES (@InstructorID,@InstructorName, @CourseID);
END;
GO

-- Stored Procedure: Update an instructor
CREATE PROCEDURE usp_UpdateInstructor
    @InstructorID INT,
    @InstructorName VARCHAR(100),
    @CourseID INT
AS
BEGIN
    UPDATE Instructors
    SET InstructorName = @InstructorName, CourseID = @CourseID
    WHERE InstructorID = @InstructorID;
END;
GO
-- Stored Procedure: Delete an instructor
CREATE PROCEDURE usp_DeleteInstructor
    @InstructorID INT
AS
BEGIN
    DELETE FROM Instructors
    WHERE InstructorID = @InstructorID;
END;
GO
-- Stored Procedure: Get instructors by course
CREATE PROCEDURE usp_GetInstructorsByCourse
    @CourseID INT
AS
BEGIN
    SELECT *
    FROM Instructors
    WHERE CourseID = @CourseID;
END;
GO



--Training Manager Tasks:
-- Stored Procedure: Add a new branch
CREATE PROCEDURE usp_AddBranch
	@BranchID INT,
    @BranchName VARCHAR(100),
	@DepartmentID INT
AS
BEGIN
    INSERT INTO Branches (BranchID,BranchName,DepartmentID)
    VALUES (@BranchID,@BranchName, @DepartmentID);
END;
GO
-- Stored Procedure: Add a new track
CREATE PROCEDURE usp_AddTrack
	@TrackID INT,
    @TrackName VARCHAR(100),
    @DepartmentID INT
AS
BEGIN
    INSERT INTO Tracks (TrackID,TrackName, DepartmentID)
    VALUES (@TrackID,@TrackName, @DepartmentID);
END;
GO
-- Stored Procedure: Add a new intake
CREATE PROCEDURE usp_AddIntake
	@IntakeID INT,
    @IntakeName VARCHAR(50)

AS
BEGIN
    INSERT INTO Intakes (IntakeID,IntakeName)
    VALUES (@IntakeID,@IntakeName);
END;
GO
-- Stored Procedure: Add a new student
CREATE PROCEDURE usp_AddStudent
	@StudentID INT,
    @StudentName VARCHAR(100),
	@StudentPhone VARCHAR(100),
    @Intake VARCHAR(50),
    @Branch VARCHAR(50),
    @Track VARCHAR(50)
AS
BEGIN
    INSERT INTO Students (StudentID,StudentName,StudentPhone, IntakeID, BranchID, TrackID)
    VALUES (@StudentID, @StudentName, @StudentPhone,@Intake, @Branch, @Track);
END;
GO
-- Stored Procedure: UPDATE an existing branch
CREATE PROCEDURE usp_EditBranch
    @BranchID INT,
    @BranchName VARCHAR(100)
AS
BEGIN
    UPDATE Branches
    SET BranchName = @BranchName
    WHERE BranchID = @BranchID;
END;
GO

-- Stored Procedure: Edit an existing track
CREATE PROCEDURE usp_EditTrack
    @TrackID INT,
    @TrackName VARCHAR(100),
    @DepartmentID INT
AS
BEGIN
    UPDATE Tracks
    SET TrackName = @TrackName, DepartmentID = @DepartmentID
    WHERE TrackID = @TrackID;
END;
GO
-- Stored Procedure: Edit an existing intake
CREATE PROCEDURE usp_EditIntake
    @IntakeID INT,
    @IntakeName VARCHAR(50)
AS
BEGIN
    UPDATE Intakes
    SET IntakeName = @IntakeName
    WHERE IntakeID = @IntakeID;
END;
GO
-- Stored Procedure: Edit an existing student
CREATE PROCEDURE usp_EditStudent
    @StudentID INT,
    @StudentName VARCHAR(100),
    @Intake VARCHAR(50),
    @Branch VARCHAR(50),
    @Track VARCHAR(50)
AS
BEGIN
    UPDATE Students
    SET StudentName = @StudentName, IntakeID = @Intake, BranchID = @Branch, TrackID = @Track
    WHERE StudentID = @StudentID;
END;
GO
-- Stored Procedure: Add an instructor to a course
CREATE PROCEDURE usp_AddInstructorToCourse
    @InstructorID INT,
    @CourseID INT
AS
BEGIN
    INSERT INTO InstructorCourses (InstructorID, CourseID)
    VALUES (@InstructorID, @CourseID);
END;
GO
-- Stored Procedure: Remove an instructor from a course
CREATE PROCEDURE usp_RemoveInstructorFromCourse
    @InstructorID INT,
    @CourseID INT
AS
BEGIN
    DELETE FROM InstructorCourses
    WHERE InstructorID = @InstructorID AND CourseID = @CourseID;
END;
GO



--Exam Management:
-- Stored Procedure: Create a new exam
CREATE PROCEDURE usp_CreateExam
	@ExamID INT,
    @ExamType VARCHAR(50),
    @IntakeID INT,
    @BranchID INT,
    @TrackID INT,
    @CourseID INT,
    @InstructorID INT,
    @StartTime DATETIME,
    @EndTime DATETIME,
    @TotalTime INT,
    @MaxDegree INT
AS
BEGIN
    INSERT INTO Exams (ExamID,ExamType, IntakeID, BranchID, TrackID, CourseID, InstructorID, StartTime, EndTime, TotalTime, MaxDegree)
    VALUES (@ExamID,@ExamType, @IntakeID, @BranchID, @TrackID, @CourseID, @InstructorID, @StartTime, @EndTime, @TotalTime, @MaxDegree);
END;
GO

-- Stored Procedure: Edit an existing exam
CREATE PROCEDURE usp_EditExam
    @ExamID INT,
    @StartTime DATETIME,
    @EndTime DATETIME,
    @TotalTime INT,
    @MaxDegree INT
AS
BEGIN
    UPDATE Exams
    SET StartTime = @StartTime, EndTime = @EndTime, TotalTime = @TotalTime, MaxDegree = @MaxDegree
    WHERE ExamID = @ExamID;
END;
GO
-- Stored Procedure: Delete an exam
CREATE PROCEDURE usp_DeleteExam
    @ExamID INT
AS
BEGIN
    DELETE FROM Exams
    WHERE ExamID = @ExamID;
END;
GO
-- Stored Procedure: Assign students to an exam
CREATE PROCEDURE usp_AssignStudentsToExam
	@StudentExamID INT,
    @ExamID INT,
    @StudentID INT,
    @ExamDate DATETIME,
    @StartTime DATETIME,
    @EndTime DATETIME
AS
BEGIN
    INSERT INTO StudentExams (StudentExamID ,ExamID, StudentID, ExamDate, StartTime, EndTime)
    VALUES (@StudentExamID,@ExamID, @StudentID, @ExamDate, @StartTime, @EndTime);
END;
GO
-- Stored Procedure: Set exam start and end times
CREATE PROCEDURE usp_SetExamTime
    @ExamID INT,
    @StartTime DATETIME,
    @EndTime DATETIME
AS
BEGIN
    UPDATE Exams
    SET StartTime = @StartTime, EndTime = @EndTime
    WHERE ExamID = @ExamID;
END;
GO



-- Question Management:
-- Stored Procedure: Add a new question
CREATE PROCEDURE usp_AddQuestion
    @QuestionID INT,
	@QuestionText VARCHAR(MAX),
    @QuestionType VARCHAR(50),
    @CorrectAnswer VARCHAR(MAX),
    @BestAcceptedAnswer VARCHAR(MAX),
    @CourseID INT,
    @InstructorID INT
AS
BEGIN
    INSERT INTO Questions (QuestionID ,QuestionText, QuestionType, CorrectAnswer, BestAcceptedAnswer, CourseID, InstructorID)
    VALUES (@QuestionID,@QuestionText, @QuestionType, @CorrectAnswer, @BestAcceptedAnswer, @CourseID, @InstructorID);
END;
GO

-- Stored Procedure: Update a question
CREATE PROCEDURE usp_UpdateQuestion
    @QuestionID INT,
    @QuestionText VARCHAR(MAX),
    @QuestionType VARCHAR(50),
    @CorrectAnswer VARCHAR(MAX),
    @BestAcceptedAnswer VARCHAR(MAX)
AS
BEGIN
    UPDATE Questions
    SET QuestionText = @QuestionText, QuestionType = @QuestionType,
        CorrectAnswer = @CorrectAnswer, BestAcceptedAnswer = @BestAcceptedAnswer
    WHERE QuestionID = @QuestionID;
END;
GO

-- Stored Procedure: Delete a question
CREATE PROCEDURE usp_DeleteQuestion
    @QuestionID INT
AS
BEGIN
    DELETE FROM Questions
    WHERE QuestionID = @QuestionID;
END;
GO

-- Stored Procedure: Get questions by course
CREATE PROCEDURE usp_GetQuestionsByCourse
    @CourseID INT
AS
BEGIN
    SELECT *
    FROM Questions
    WHERE CourseID = @CourseID;
END;
GO




---Exam Taking and Results:
-- Stored Procedure: Submit exam answers
CREATE PROCEDURE usp_SubmitExamAnswers
    @StudentExamID INT,
    @QuestionID INT,
	@AnswerID INT,
    @StudentAnswer VARCHAR(MAX)
AS
BEGIN
    INSERT INTO StudentAnswers (StudentExamID, QuestionID, AnswerID , StudentAnswer)
    VALUES (@StudentExamID, @QuestionID,@AnswerID , @StudentAnswer);
END;
GO

-- Stored Procedure: Calculate and store exam results
CREATE PROCEDURE usp_CalculateExamResults
    @StudentExamID INT
AS
BEGIN
    DECLARE @TotalScore INT;

    -- Calculate total score (example: sum of question degrees)
    SELECT @TotalScore = SUM(Q.QuestionDegree)
    FROM ExamQuestions EQ
    JOIN Questions Q ON EQ.QuestionID = Q.QuestionID
    WHERE EQ.ExamID = (SELECT ExamID FROM StudentExams WHERE StudentExamID = @StudentExamID);


    -- Store the result
    INSERT INTO Results (StudentID, ExamID, TotalScore, Grade)
    VALUES (
        (SELECT StudentID FROM StudentExams WHERE StudentExamID = @StudentExamID),
        (SELECT ExamID FROM StudentExams WHERE StudentExamID = @StudentExamID),
        @TotalScore,
        'Grade Calculation Logic Here' 
    );
END;
GO



---
-- Stored Procedure: EvaluateTextQuestion
CREATE PROCEDURE usp_EvaluateTextQuestion
    @QuestionID INT,
    @StudentAnswer VARCHAR(MAX)
AS
BEGIN
    DECLARE @BestAcceptedAnswer VARCHAR(MAX);

    -- Get the best accepted answer for the given question
    SELECT @BestAcceptedAnswer = BestAcceptedAnswer
    FROM Questions
    WHERE QuestionID = @QuestionID;

    IF LOWER(@StudentAnswer) = LOWER(@BestAcceptedAnswer)
    BEGIN

        PRINT 'Result: Correct';

    END
    ELSE
    BEGIN
       
        PRINT 'Result: Incorrect';

        PRINT 'Best Accepted Answer: ' + @BestAcceptedAnswer;
    
    END;
END;
GO
---------------------------------functions
--Search Courses by Course Name:
CREATE Function usp_SearchCoursesByName(
    @CourseName VARCHAR(100))
RETURNS TABLE
AS
RETURN(
    SELECT *
    FROM Courses
    WHERE (CourseName LIKE '%' + @CourseName + '%')
);
Go

--Search Courses by Instructor:
CREATE Function usp_SearchCoursesByInstructor(
    @InstructorName VARCHAR(100))
RETURNS TABLE
AS
RETURN(
    SELECT C.*
    FROM Courses C
    INNER JOIN InstructorCourses IC ON C.CourseID = IC.CourseID
    INNER JOIN Instructors I ON IC.InstructorID = I.InstructorID
    WHERE I.InstructorName LIKE '%' + @InstructorName + '%'
);
Go
----------------------------triggers
--Trigger to Enforce UserType Constraints:
CREATE TRIGGER tr_UserAccount_UserType
ON UserAccount
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE UserType NOT IN ('Admin', 'TrainingManager', 'Instructor', 'Student'))
    BEGIN
        THROW 50000, 'Invalid UserType. UserType must be one of: Admin, TrainingManager, Instructor, Student.', 1;
    END
END;


GO
--Trigger to Prevent Deleting Instructors Assigned to Courses:
CREATE TRIGGER tr_Instructors_Delete
ON Instructors
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM deleted d JOIN InstructorCourses ic ON d.InstructorID = ic.InstructorID)
    BEGIN
        THROW 50000, 'Cannot delete instructor assigned to a course.', 1;
    END
    ELSE
    BEGIN
        DELETE FROM Instructors WHERE InstructorID IN (SELECT InstructorID FROM deleted);
    END
END;

GO



--Trigger to Prevent Deleting Courses with Associated Exams:
CREATE TRIGGER tr_Courses_Delete
ON Courses
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM deleted d JOIN Exams e ON d.CourseID = e.CourseID)
    BEGIN
        THROW 50000, 'Cannot delete course with associated exams.', 1;
    END
    ELSE
    BEGIN
        DELETE FROM Courses WHERE CourseID IN (SELECT CourseID FROM deleted);
    END
END;
GO


--Trigger to Prevent Deleting Questions Used in Exams:

CREATE TRIGGER tr_Questions_Delete
ON Questions
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM deleted d JOIN ExamQuestions eq ON d.QuestionID = eq.QuestionID)
    BEGIN
        THROW 50000, 'Cannot delete question used in exams.', 1;
    END
    ELSE
    BEGIN
        DELETE FROM Questions WHERE QuestionID IN (SELECT QuestionID FROM deleted);
    END
END;

---------------------------------------indexes


--UserAccount Table:
CREATE INDEX IX_UserAccount_UserType ON UserAccount (UserType);
CREATE INDEX IX_UserAccount_UserName ON UserAccount (UserName);
GO
SELECT* FROM UserAccount WITH  (INDEX(IX_UserAccount_UserType)) WHERE UserType='Student';

--TrainingManager Table:
CREATE INDEX IX_TrainingManager_TrainingManagerName ON TrainingManager (TrainingManagerName);
GO
--Instructor Table:
CREATE INDEX IX_Instructor_InstructorName ON Instructors (InstructorName);
CREATE INDEX IX_Instructor_CourseID ON Instructors (CourseID);
GO
--Student Table:
CREATE INDEX IX_Student_StudentName ON Students (StudentName);
CREATE INDEX IX_Student_Intake ON Students (IntakeID);
CREATE INDEX IX_Student_Branch ON Students (BranchID);
CREATE INDEX IX_Student_Track ON Students (TrackID);
GO
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
CREATE INDEX IX_Track_DepartmentID ON Tracks (DepartmentID);
GO
--Intake Table:
CREATE INDEX IX_Intake_IntakeName ON Intakes (IntakeName);
GO
--Question Table:
CREATE INDEX IX_Question_CourseID ON Questions (CourseID);
CREATE INDEX IX_Question_InstructorID ON Questions (InstructorID);
CREATE INDEX IX_Question_QuestionType ON Questions (QuestionType);
GO
--Exam Table:
CREATE INDEX IX_Exam_IntakeID ON Exams (IntakeID);
CREATE INDEX IX_Exam_BranchID ON Exams (BranchID);
CREATE INDEX IX_Exam_TrackID ON Exams (TrackID);
CREATE INDEX IX_Exam_CourseID ON Exams (CourseID);
CREATE INDEX IX_Exam_InstructorID ON Exams (InstructorID);
GO
--ExamQuestion Table:
CREATE INDEX IX_ExamQuestion_ExamID ON ExamQuestions (ExamID);
CREATE INDEX IX_ExamQuestion_QuestionID ON ExamQuestions (QuestionID);
GO
--StudentExam Table:
CREATE INDEX IX_StudentExam_ExamID ON StudentExams (ExamID);
CREATE INDEX IX_StudentExam_StudentID ON StudentExams (StudentID);
GO
--StudentAnswer Table:
CREATE INDEX IX_StudentAnswer_StudentExamID ON StudentAnswers (StudentExamID);
CREATE INDEX IX_StudentAnswer_QuestionID ON StudentAnswers (QuestionID);
GO
--Result Table:
CREATE INDEX IX_Result_StudentID ON Results (StudentID);
CREATE INDEX IX_Result_ExamID ON Results (ExamID);
GO

-- Index on StudentEnrollment Table:
CREATE INDEX IX_StudentEnrollment_StudentID ON StudentEnrollment (StudentID);
CREATE INDEX IX_StudentEnrollment_CourseID ON StudentEnrollment (CourseID);
GO
------------------------accounts and permissions
--Create an Admin Account:
--This account has full access to all objects in the database.
CREATE LOGIN AdminLogin WITH PASSWORD = 'Admin123';
CREATE USER AdminUser FOR LOGIN AdminLogin;
GRANT ALTER ON DATABASE::ExaminationSystem TO AdminLogin;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON DATABASE::ExaminationSystem TO AdminLogin;

--Create a Training Manager Account:
--This account has permissions to manage instructors, courses, branches, tracks, intakes, and students.
CREATE LOGIN TrainingManagerLogin WITH PASSWORD = 'TrainingManager123';
CREATE USER TrainingManagerUser FOR LOGIN TrainingManagerLogin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Instructors TO TrainingManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Students TO TrainingManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Branches TO TrainingManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Tracks TO TrainingManagerUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Intakes TO TrainingManagerUser;



--Create an Instructor Account:
--This account has permissions to manage the instructor's own question pool and create exams.
CREATE LOGIN InstructorLogin WITH PASSWORD = 'InstructorPassword123';
CREATE USER InstructorUser FOR LOGIN InstructorLogin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Courses TO InstructorUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON ExamQuestions TO InstructorUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON Exams TO InstructorUser;


--Create a Student Account:
--This account has permissions to view exam schedules, take exams, and view results.
CREATE LOGIN StudentLogin WITH PASSWORD = 'StudentPassword123';
CREATE USER StudentUser FOR LOGIN StudentLogin;
GRANT SELECT ON Courses TO StudentUser;
GRANT SELECT ON ExamScheduleView TO StudentUser;
GRANT SELECT ON vw_ExamResults TO StudentUser;


-----------------------------------