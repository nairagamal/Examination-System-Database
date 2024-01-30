-----------------------------------TABLES
-- Select data from UserAccount table
SELECT * FROM UserAccount;

-- Select data from TrainingManager table
SELECT * FROM TrainingManager;

-- Select data from Departments table
SELECT * FROM Departments;

-- Select data from Courses table
SELECT * FROM Courses;

-- Select data from Instructors table
SELECT * FROM Instructors;

-- Select data from Branches table
SELECT * FROM Branches;

-- Select data from Tracks table
SELECT * FROM Tracks;

-- Select data from Intakes table
SELECT * FROM Intakes;

-- Select data from Students table
SELECT * FROM Students;

-- Select data from StudentEnrollment table
SELECT * FROM StudentEnrollment;

-- Select data from InstructorCourses table
SELECT * FROM InstructorCourses;

-- Select data from Exams table
SELECT * FROM Exams;

-- Select data from Questions table
SELECT * FROM Questions;

-- Select data from ExamQuestions table
SELECT * FROM ExamQuestions;

-- Select data from StudentExams table
SELECT * FROM StudentExams;

-- Select data from StudentAnswers table
SELECT * FROM StudentAnswers;

-- Select data from Results table
SELECT * FROM Results;

-------------------------------------------------------PROCEDURES
EXEC usp_CreateUserAccount 
	@ID = 101,
    @UserName =Naira@gmail,
    @Password = 123456 ,
    @UserType = Student;
GO

EXEC usp_AddCourse
    @CourseID = 102,
    @CourseName = 'Introduction to SQL',
    @Description = 'A beginner-level course on SQL programming.',
    @MaxDegree = 100,
    @MinDegree = 0;

GO
-- Execute usp_CreateUserAccount to create a new user account
EXEC usp_CreateUserAccount 
	@ID = 102,
    @UserName = 'OMAR@gmail', 
    @Password = '123456',
    @UserType = 'Student';

-- Execute usp_UpdateUserAccount to update the password for the created user
EXEC usp_UpdateUserAccount
    @UserID = 102,
    @Password = '23467';  

-- Execute usp_DeleteUserAccount to delete the user account
EXEC usp_DeleteUserAccount
    @UserID = 101;

-- Execute usp_AddCourse to add a new course
EXEC usp_AddCourse
    @CourseID = 103,
    @CourseName = 'Introduction to SQL',
    @Description = 'A beginner-level course on SQL programming.',
    @MaxDegree = 100,
    @MinDegree = 0;

-- Execute usp_UpdateCourse to update the course information
EXEC usp_UpdateCourse
    @CourseID = 102,
    @CourseName = 'Advanced SQL',
    @Description = 'An advanced course on SQL programming.',
    @MaxDegree = 150,
    @MinDegree = 50;

-- Execute usp_DeleteCourse to delete the course
EXEC usp_DeleteCourse
    @CourseID = 102;

-- Execute usp_AddInstructor to add a new instructor
EXEC usp_AddInstructor
    @InstructorID = 6,
    @InstructorName = 'Naira Instructor',
    @CourseID = 103; 

-- Execute usp_UpdateInstructor to update the instructor information
EXEC usp_UpdateInstructor
    @InstructorID = 6,
    @InstructorName = 'Omar Instructor',
    @CourseID = 103;  -- Assuming the new course ID to be associated with the instructor

-- Execute usp_DeleteInstructor to delete the instructor
EXEC usp_DeleteInstructor
    @InstructorID = 6;

-- Execute usp_AddBranch to add a new branch
EXEC usp_AddBranch
    @BranchID = 301,
    @BranchName = 'Computer Science',
    @DepartmentID = 401;  -- Assuming the department ID to be associated with the branch

-- Execute usp_AddTrack to add a new track
EXEC usp_AddTrack
    @TrackID = 501,
    @TrackName = 'Database Administration',
    @DepartmentID = 5;  -- Assuming the department ID to be associated with the track

-- Execute usp_AddIntake to add a new intake
EXEC usp_AddIntake
    @IntakeID = 601,
    @IntakeName = 'Spring 2024';

-- Execute usp_AddStudent to add a new student
EXEC usp_AddStudent
    @StudentID = 701,
    @StudentName = 'Alice Student',
    @StudentPhone = '123-456-7890',
    @Intake = 5,
    @Branch = '3',  -- Replace with the actual branch name
    @Track = 5;  -- Replace with the actual track name

-- Execute usp_EditBranch to edit an existing branch
EXEC usp_EditBranch
    @BranchID = 301,
    @BranchName = 'Software Engineering';

-- Execute usp_EditTrack to edit an existing track
EXEC usp_EditTrack
    @TrackID = 501,
    @TrackName = 'Data Science',
    @DepartmentID = 5;  -- Assuming the new department ID to be associated with the track

-- Execute usp_EditIntake to edit an existing intake
EXEC usp_EditIntake
    @IntakeID = 601,
    @IntakeName = 'Fall 2024';

-- Execute usp_EditStudent to edit an existing student
EXEC usp_EditStudent
    @StudentID = 701,
    @StudentName = 'Alice Updated Student',
    @Intake = 3,
    @Branch = 5,  -- Replace with the updated branch name
    @Track = 3;  -- Replace with the updated track name

-- Execute usp_AddInstructorToCourse to add an instructor to a course
EXEC usp_AddInstructorToCourse
    @InstructorID = 5,
    @CourseID = 103;

-- Execute usp_RemoveInstructorFromCourse to remove an instructor from a course
EXEC usp_RemoveInstructorFromCourse
    @InstructorID = 5,
    @CourseID = 103;

-- Execute usp_CreateExam to create a new exam
EXEC usp_CreateExam
    @ExamID = 801,
    @ExamType = 'Midterm',
    @IntakeID = 3,
    @BranchID = 5,
    @TrackID = 3,
    @CourseID = 103,
    @InstructorID = 5,
    @StartTime = '2024-01-16 10:00:00',
    @EndTime = '2024-01-16 12:00:00',
    @TotalTime = 120,
    @MaxDegree = 100;

-- Execute usp_EditExam to edit an existing exam
EXEC usp_EditExam
    @ExamID = 801,
    @StartTime = '2024-01-16 11:00:00',
    @EndTime = '2024-01-16 13:00:00',
    @TotalTime = 150,
    @MaxDegree = 120;

-- Execute usp_DeleteExam to delete an exam
EXEC usp_DeleteExam
    @ExamID = 801;

-- Execute usp_AssignStudentsToExam to assign students to an exam
EXEC usp_AssignStudentsToExam
	@StudentExamID=1,
    @ExamID = 801,
    @StudentID = 5,
    @ExamDate = '2024-01-16',
    @StartTime = '2024-01-16 11:00:00',
    @EndTime = '2024-01-16 13:00:00';

-- Execute usp_SetExamTime to set exam start and end times
EXEC usp_SetExamTime
    @ExamID = 801,
    @StartTime
= '2024-01-16 12:00:00',
@EndTime = '2024-01-16 14:00:00';

-- Execute usp_AddQuestion to add a new question
EXEC usp_AddQuestion
@QuestionID = 901,
@QuestionText = 'What is SQL?',
@QuestionType = 'Multiple Choice', -- Replace with the actual question type
@CorrectAnswer = 'Structured Query Language',
@BestAcceptedAnswer = 'Structured Query Language',
@CourseID = 103,
@InstructorID = 5;

-- Execute usp_UpdateQuestion to update a question
EXEC usp_UpdateQuestion
@QuestionID = 901,
@QuestionText = 'What is SQL? (Updated)',
@QuestionType = 'Multiple Choice', -- Replace with the actual question type
@CorrectAnswer = 'Structured Query Language',
@BestAcceptedAnswer = 'Structured Query Language (Updated)';

-- Execute usp_DeleteQuestion to delete a question
EXEC usp_DeleteQuestion
@QuestionID = 901;

-- Execute usp_GetQuestionsByCourse to get questions by course
EXEC usp_GetQuestionsByCourse
@CourseID = 103;

-- Execute usp_SubmitExamAnswers to submit exam answers for a student
EXEC usp_SubmitExamAnswers
@StudentExamID = 1, -- Replace with the actual StudentExamID
@QuestionID = 901,
@AnswerID = 1, -- Replace with the actual AnswerID
@StudentAnswer = 'Structured Query Language';

-- Execute usp_CalculateExamResults to calculate and store exam results
EXEC usp_CalculateExamResults
@StudentExamID = 1; -- Replace with the actual StudentExamID

-- Execute usp_EvaluateTextQuestion to evaluate a text question
EXEC usp_EvaluateTextQuestion
@QuestionID = 901,
@StudentAnswer = 'Structured Query Language';


-------------------------------------------VIEW
SELECT * FROM vw_StudentsInCourse
GO
SELECT * FROM vw_CourseEnrollmentView
GO
SELECT * FROM vw_ExamResults
GO
SELECT * FROM vw_InstructorCourses
GO
SELECT * FROM ExamScheduleView

--------------------------------------INDEXES

SELECT * FROM UserAccount WITH  (INDEX(IX_UserAccount_UserType)) WHERE UserType = 'Student';
SELECT * FROM UserAccount WITH  (INDEX(IX_UserAccount_UserName)) WHERE UserName = 'admin';
SELECT * FROM TrainingManager WITH  (INDEX(IX_TrainingManager_TrainingManagerName)) WHERE TrainingManagerName = 'Alice Brown';
SELECT * FROM Instructors WITH  (INDEX(IX_Instructor_InstructorName)) WHERE InstructorName = 'Bob Trainer';
SELECT * FROM Instructors WITH  (INDEX(IX_Instructor_CourseID)) WHERE CourseID = '4';
--Student Table
SELECT * FROM Students WITH  (INDEX(IX_Student_StudentName)) WHERE StudentName = 'Student Two';

--Course Table 
SELECT * FROM Courses WITH  (INDEX(IX_Course_CourseName)) WHERE CourseName = 'Marketing Strategies';
--Department Table:
SELECT * FROM Departments WITH  (INDEX(IX_Department_DepartmentName)) WHERE DepartmentName = 'IT Department';
--Branch Table:
SELECT * FROM Branches WITH  (INDEX(IX_Branch_BranchName)) WHERE BranchName = 'Ops Branch';
--Track Table:
SELECT * FROM Tracks WITH  (INDEX(IX_Track_TrackName)) WHERE TrackName = 'Data Science';

--Intake Table:
SELECT * FROM Intakes WITH  (INDEX(IX_Intake_IntakeName)) WHERE IntakeName = 'Fall 2024';
--Question Table:
SELECT * FROM Questions WITH  (INDEX(IX_Question_QuestionType)) WHERE QuestionType = 'MultiChoice';

--Result Table:
 SELECT * FROM Results WITH  (INDEX(IX_Result_StudentID)) WHERE StudentID = '1';
--StudentEnrollment Table:
SELECT * FROM StudentEnrollment WITH  (INDEX(IX_StudentEnrollment_StudentID)) WHERE StudentID = '1';
SELECT * FROM StudentEnrollment WITH  (INDEX(IX_StudentEnrollment_CourseID)) WHERE CourseID = '2';








