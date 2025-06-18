USE SEDC_ACADEMY_HOMEWORK
GO

-- => Homework 6

-- Class04 - Built in And Scalar Functions

--Homework requirements:

-- 1. Declare scalar variable for storing FirstName values
-- 2. Assign value 'Antonio' to the FirstName variable
-- 3. Find all Students having FirstName same as the variable

	DECLARE @FirstName NVARCHAR(100);
	SET @FirstName = 'Antonio';

	SELECT *
	FROM Student
	WHERE FirstName = @FirstName;

-- 4. Declare table variable that will contain StudentId, StudentName, and DateOfBirth
-- 5. Fill the table variable with all Female students 

	DECLARE @FemaleStudents TABLE (
		StudentId INT,
		StudentName NVARCHAR(200),
		DateOfBirth DATE
	);

	INSERT INTO @FemaleStudents (StudentId, StudentName, DateOfBirth)
	SELECT Id, CONCAT(FirstName, ' ', LastName), DateOfBirth
	FROM Student
	WHERE Gender = 'F';

	SELECT * FROM @FemaleStudents;

-- 6. Declare temp table that will contain LastName and EnrolledDate columns
-- 7. Fill the temp table with all Male students having First Name starting with ‘A’

	CREATE TABLE #MaleStudentsWithA (
		LastName NVARCHAR(100),
		EnrolledDate DATE
	);

	INSERT INTO #MaleStudentsWithA (LastName, EnrolledDate)
	SELECT LastName, EnrolledDate
	FROM Student
	WHERE Gender = 'M' AND FirstName LIKE 'A%';

	SELECT * FROM #MaleStudentsWithA;

-- 8. Retrieve the students whose last name is 7 characters long
	SELECT *
	FROM Student
	WHERE LEN(LastName) = 7;

-- 9. Find all teachers whose:
-- FirstName length is less than 5 AND
-- the first 3 characters of their FirstName and LastName are the same

	SELECT *
	FROM Teacher
	WHERE LEN(FirstName) < 5
	AND LEFT(FirstName, 3) = LEFT(LastName, 3);


