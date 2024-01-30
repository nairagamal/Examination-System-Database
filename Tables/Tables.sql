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
    UserName VARCHAR(50) UNIQUE,
    Pword VARCHAR(100),
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
    DepartmentName VARCHAR(100),
	TrainingManagerID INT ,
	FOREIGN KEY (TrainingManagerID) REFERENCES TrainingManager(TrainingManagerID)
);


--  Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Descript VARCHAR(MAX),
    MaxDegree INT,
    MinDegree INT,
	DepartmentID INT,
	FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
);

--  Instructors
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(100),
	InstructorEmail VARCHAR(100),
	InstructorPhone VARCHAR(100),
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

--  Branches
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
	DepartmentID INT,
	TrainingManagerID INT,
	FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
	FOREIGN KEY (TrainingManagerID) REFERENCES TrainingManager(TrainingManagerID)
);


--  Tracks
CREATE TABLE Tracks (
    TrackID INT PRIMARY KEY,
    TrackName VARCHAR(100),
    DepartmentID INT,
	TrainingManagerID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
	FOREIGN KEY (TrainingManagerID) REFERENCES TrainingManager(TrainingManagerID)
);


--  Intakes
CREATE TABLE Intakes (
    IntakeID INT PRIMARY KEY,
    IntakeName VARCHAR(50),
	TrainingManagerID INT,
	FOREIGN KEY (TrainingManagerID) REFERENCES TrainingManager(TrainingManagerID)
);

--  Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
	StudentEmail VARCHAR(100),
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
    ExamType VARCHAR(50),
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
    QuestionText VARCHAR(MAX),
    QuestionType VARCHAR(50),
    CorrectAnswer VARCHAR(MAX),
    BestAcceptedAnswer VARCHAR(MAX),
	QuestionDegree INT,
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

