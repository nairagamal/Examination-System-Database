-- Insert sample data into UserAccount
INSERT INTO UserAccount (UserID, UserName, Pword, UserType)
VALUES
(1, 'admin', 'admin123', 'Admin'),
(2, 'manager1', 'manager123', 'TrainingManager'),
(3, 'instructor1', 'instructor123', 'Instructor'),
(4, 'student1', 'student123', 'Student'),
(5, 'student2', 'student456', 'Student');

-- Insert sample data into TrainingManager
INSERT INTO TrainingManager (TrainingManagerID, TrainingManagerName)
VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Bob Johnson'),
(4, 'Alice Brown'),
(5, 'Charlie Davis');

-- Insert sample data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName, TrainingManagerID)
VALUES
(1, 'IT Department', 1),
(2, 'HR Department', 2),
(3, 'Finance Department', 3),
(4, 'Marketing Department', 4),
(5, 'Operations Department', 5);

-- Insert sample data into Courses
INSERT INTO Courses (CourseID, CourseName, Descript, MaxDegree, MinDegree, DepartmentID)
VALUES
(1, 'Database Management', 'Introduction to database management systems.', 100, 0, 1),
(2, 'Programming Fundamentals', 'Introduction to programming concepts.', 90, 10, 1),
(3, 'Human Resource Management', 'Overview of HR principles.', 95, 5, 2),
(4, 'Financial Accounting', 'Basic financial accounting principles.', 98, 2, 3),
(5, 'Marketing Strategies', 'Strategies for effective marketing.', 92, 8, 4);

-- Insert sample data into Instructors
INSERT INTO Instructors (InstructorID, InstructorName, InstructorEmail, InstructorPhone, CourseID)
VALUES
(1, 'John Instructor', 'john@example.com', '123-456-7890', 1),
(2, 'Jane Instructor', 'jane@example.com', '987-654-3210', 2),
(3, 'Bob Trainer', 'bob@example.com', '111-222-3333', 3),
(4, 'Alice Teacher', 'alice@example.com', '444-555-6666', 4),
(5, 'Charlie Educator', 'charlie@example.com', '777-888-9999', 5);

-- Insert sample data into Branches
INSERT INTO Branches (BranchID, BranchName, DepartmentID, TrainingManagerID)
VALUES
(1, 'Main Branch', 1, 1),
(2, 'HR Branch', 2, 2),
(3, 'Finance Branch', 3, 3),
(4, 'Marketing Branch', 4, 4),
(5, 'Ops Branch', 5, 5);

-- Insert sample data into Tracks
INSERT INTO Tracks (TrackID, TrackName, DepartmentID, TrainingManagerID)
VALUES
(1, 'Database Track', 1, 1),
(2, 'Programming Track', 1, 2),
(3, 'HR Track', 2, 3),
(4, 'Finance Track', 3, 4),
(5, 'Marketing Track', 4, 5);

-- Insert sample data into Intakes
INSERT INTO Intakes (IntakeID, IntakeName, TrainingManagerID)
VALUES
(1, 'Spring 2023', 1),
(2, 'Fall 2023', 2),
(3, 'Summer 2023', 3),
(4, 'Winter 2023', 4),
(5, 'Spring 2024', 5);

-- Insert sample data into Students
INSERT INTO Students (StudentID, StudentName, StudentEmail, StudentPhone, IntakeID, BranchID, TrackID)
VALUES
(1, 'Student One', 'student1@example.com', '111-222-3333', 1, 1, 1),
(2, 'Student Two', 'student2@example.com', '444-555-6666', 2, 2, 2),
(3, 'Student Three', 'student3@example.com', '777-888-9999', 3, 3, 3),
(4, 'Student Four', 'student4@example.com', '123-456-7890', 4, 4, 4),
(5, 'Student Five', 'student5@example.com', '987-654-3210', 5, 5, 5);

-- Insert sample data into StudentEnrollment
INSERT INTO StudentEnrollment (EnrollmentID, StudentID, CourseID)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- Insert sample data into InstructorCourses
INSERT INTO InstructorCourses (InstructorID, CourseID, IntakeID, BranchID, TrackID)
VALUES
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 3),
(4, 4, 4, 4, 4),
(5, 5, 5, 5, 5);

-- Insert sample data into Exams
INSERT INTO Exams (ExamID, ExamType, allowance_options, IntakeID, BranchID, TrackID, CourseID, InstructorID, StartTime, EndTime, TotalTime, MaxDegree)
VALUES
(1, 'Midterm', 'Extra time for special cases', 1, 1, 1, 1, 1, '2024-01-15 10:00:00', '2024-01-15 12:00:00', 120, 50);

