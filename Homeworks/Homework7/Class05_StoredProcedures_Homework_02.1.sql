
-- Homework 7
-- Class05 - Stored Procedures

-- HOMEWORK 02.1

USE SEDC_ACADEMY_HOMEWORK
GO
-- Homework requirements:
-- Create new procedure called CreateGrade;
-- Procedure should create only Grade header info (not Grade Details);
-- Procedure should return the total number of grades in the system for
-- the Student on input (from the CreateGrade);
-- Procedure should return second resultset with the MAX Grade of all
-- grades for the Student and Teacher on input (regardless the Course)


	IF OBJECT_ID('dbo.CreateGrade', 'P') IS NOT NULL
		DROP PROCEDURE dbo.CreateGrade;
	GO

-- Create the procedure again
	CREATE PROCEDURE dbo.CreateGrade
		@StudentID INT,
		@CourseID INT,
		@TeacherID INT,
		@Grade TINYINT,
		@Comment NVARCHAR(MAX)
	AS
	BEGIN
		-- Insert into Grade table (header only)
		INSERT INTO dbo.Grade (StudentID, CourseID, TeacherID, Grade, Comment, CreatedDate)
		VALUES (@StudentID, @CourseID, @TeacherID, @Grade, @Comment, GETDATE());

		-- First result set: total grades for the student
		SELECT COUNT(*) AS TotalGrades
		FROM dbo.Grade
		WHERE StudentID = @StudentID;

		-- Second result set: max grade for that student and teacher (any course)
		SELECT MAX(Grade) AS MaxGrade
		FROM dbo.Grade
		WHERE StudentID = @StudentID AND TeacherID = @TeacherID;
	END;
	GO



	EXEC dbo.CreateGrade 
		@StudentID = 1, 
		@CourseID = 2, 
		@TeacherID = 3, 
		@Grade = 90, 
		@Comment = 'Excellent';

		SELECT * FROM dbo.Grade;

		SELECT * 
		FROM dbo.Grade
		WHERE StudentID = 1
		AND CourseID = 2
		AND TeacherID = 3
		ORDER BY CreatedDate DESC;





