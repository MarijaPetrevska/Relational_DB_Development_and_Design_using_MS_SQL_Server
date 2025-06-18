
USE SEDC_ACADEMY_HOMEWORK
GO
-- Homework 4
-- => Session 2 - 06 Insert example data in SEDCHome database - data.sql
-- Class 02 - Constraints, Combining Sets and Relationships

-- 1) Find all Students with FirstName = Antonio

	SELECT * 
	FROM Student
	WHERE FirstName = 'Antonio';

-- 2) Find all Students with DateOfBirth greater than ‘01.01.1999’

	SELECT * 
	FROM Student
	WHERE DateOfBirth > '1999-01-01';

-- 3) Find all Students with LastName starting With ‘J’ enrolled in January/1998

	SELECT * 
	FROM Student
	WHERE LastName LIKE 'J%' AND EnrolledDate BETWEEN '1998-01-01' AND '1998-01-31';

-- 4) List all Students ordered by FirstName

	SELECT * 
	FROM Student
	ORDER BY FirstName;


-- 5) List all Teacher Last Names and Student Last Names in single result set.
--    Remove duplicates

	SELECT DISTINCT LastName 
	FROM Teacher
	UNION
	SELECT DISTINCT LastName 
	FROM Student;

-- 6) Create Foreign key constraints from diagram or with script 
--    The foreign key constraints are already created in the database script.

-- 7) List all possible combinations of Courses names and AchievementType
--    names that can be passed by student

	SELECT C.Name AS CourseName, AT.Name AS AchievementTypeName
	FROM Course C
	CROSS JOIN AchievementType AT;


-- 8) List all Teachers without exam Grade

	SELECT T.*
	FROM Teacher T
	LEFT OUTER JOIN Grade G ON G.TeacherID = T.Id
	WHERE G.Id IS NULL;
