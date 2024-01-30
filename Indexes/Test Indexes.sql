
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




