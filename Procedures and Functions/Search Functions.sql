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
