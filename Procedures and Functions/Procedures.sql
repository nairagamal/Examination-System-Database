
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


EXEC usp_CreateUserAccount 
	@ID = 101,
    @UserName =Naira@gmail,
    @Password = 123456 ,
    @UserType = Student;
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

    -- Perform additional calculations or grading logic as needed

    -- Store the result
    INSERT INTO Results (StudentID, ExamID, TotalScore, Grade)
    VALUES (
        (SELECT StudentID FROM StudentExams WHERE StudentExamID = @StudentExamID),
        (SELECT ExamID FROM StudentExams WHERE StudentExamID = @StudentExamID),
        @TotalScore,
        'Grade Calculation Logic Here' -- Adjust as needed
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