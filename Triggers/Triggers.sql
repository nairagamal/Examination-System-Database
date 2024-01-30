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

--Trigger to Enforce MaxDegree and MinDegree Constraints:
CREATE TRIGGER tr_Courses_DegreeConstraints
ON Courses
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE MaxDegree < MinDegree)
    BEGIN
        THROW 50000, 'MaxDegree must be greater than or equal to MinDegree.', 1;
    END
END;
GO
--Trigger to Prevent Deleting Courses with Associated Exams:
CREATE TRIGGER tr_Courses_Delete
ON Courses
INSTEAD OF DELETE
AS
BEGIN

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

