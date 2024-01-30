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





















