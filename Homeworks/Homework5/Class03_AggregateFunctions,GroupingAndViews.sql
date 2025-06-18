USE SEDC_ACADEMY_HOMEWORK
GO

-- Homework 5
-- => Class 03 - Aggregate Functions, Grouping and Views

-- 1) Calculate the count of all grades per Teacher in the system

	SELECT * FROM Teacher
	SELECT * FROM Grade

	SELECT TeacherID, COUNT(*) AS TotalGrades
	FROM Grade
	GROUP BY TeacherID;

-- 2) Calculate the count of all grades per Teacher in the system for first 100
--    Students (ID < 100)

	SELECT G.TeacherID, COUNT(*) AS TotalGrades
	FROM Grade G
	INNER JOIN Student S ON G.StudentID = S.Id
	WHERE S.Id <= 100
	GROUP BY G.TeacherID;


-- 3) Find the Maximal Grade, and the Average Grade per Student on all grades in
--    the system

	SELECT StudentID, MAX(Grade) AS MaxGrade, AVG(Grade) AS AvgGrade
	FROM Grade
	GROUP BY StudentID;

-- 4) Calculate the count of all grades per Teacher in the system and filter only
--    grade count greater then 200

	SELECT TeacherID, COUNT(*) AS TotalGrades
	FROM Grade
	GROUP BY TeacherID
	HAVING COUNT(*) > 200;

-- 5) Find the Grade Count, Maximal Grade, and the Average Grade per Student on
--    all grades in the system. Filter only records where Maximal Grade is equal to
--    Average Grade

	SELECT StudentID, COUNT(*) AS GradeCount, MAX(Grade) AS MaxGrade, AVG(Grade) AS AvgGrade
	FROM Grade
	GROUP BY StudentID
	HAVING MAX(Grade) = AVG(Grade);

-- 6) List Student First Name and Last Name next to the other details from previous
--    query

	SELECT S.FirstName, S.LastName, G.StudentID, COUNT(*) AS GradeCount, MAX(G.Grade) AS MaxGrade, AVG(G.Grade) AS AvgGrade
	FROM Grade G
	JOIN Student S ON G.StudentID = S.Id
	GROUP BY G.StudentID, S.FirstName, S.LastName
	HAVING MAX(G.Grade) = AVG(G.Grade);

-- 7) Create new view (vv_StudentGrades) that will List all StudentIds and count of
--    Grades per student

	CREATE VIEW vv_StudentGrades AS
	SELECT StudentID, COUNT(*) AS GradeCount
	FROM Grade
	GROUP BY StudentID;

	SELECT * FROM vv_StudentGrades;

-- 8) Change the view to show Student First and Last Names instead of StudentID

	CREATE OR ALTER VIEW vv_StudentGrades AS
	SELECT S.FirstName, S.LastName, COUNT(*) AS GradeCount
	FROM Grade G
	JOIN Student S ON G.StudentID = S.Id
	GROUP BY S.FirstName, S.LastName;

	SELECT * FROM vv_StudentGrades;

-- 9) List all rows from view ordered by biggest Grade Count

	SELECT * 
	FROM vv_StudentGrades
	ORDER BY GradeCount DESC;


