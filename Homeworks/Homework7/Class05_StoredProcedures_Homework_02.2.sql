

-- Homework 7
-- Class05 - Stored Procedures

-- HOMEWORK 02.2

	USE SEDC_ACADEMY_HOMEWORK
	GO
-- Homework requirements:
-- => Create new procedure called CreateGradeDetail;

-- => Procedure should add details for specific Grade (new record for new
--    AchievementTypeID, Points, MaxPoints, Date for specific Grade);

-- => Output from this procedure should be resultset with SUM of
--    GradePoints calculated with formula
--    AchievementPoints/AchievementMaxPoints*ParticipationRate for
--    specific Grade

IF OBJECT_ID('dbo.CreateGradeDetail', 'P') IS NOT NULL
    DROP PROCEDURE dbo.CreateGradeDetail;
GO

CREATE PROCEDURE dbo.CreateGradeDetail
    @GradeID INT,
    @AchievementTypeID INT,
    @AchievementPoints SMALLINT,
    @AchievementMaxPoints SMALLINT,
    @AchievementDate DATE,
    @TotalGradePoints FLOAT OUTPUT 
AS
BEGIN
    IF @AchievementMaxPoints = 0
        RETURN;

    INSERT INTO GradeDetails (
        GradeID,
        AchievementTypeID,
        AchievementPoints,
        AchievementMaxPoints,
        AchievementDate
    )
    VALUES (
        @GradeID,
        @AchievementTypeID,
        @AchievementPoints,
        @AchievementMaxPoints,
        @AchievementDate
    );

    SELECT 
        @TotalGradePoints = SUM(
            CAST(gd.AchievementPoints AS FLOAT) / gd.AchievementMaxPoints * at.ParticipationRate
        )
    FROM GradeDetails gd
    JOIN AchievementType at ON gd.AchievementTypeID = at.Id
    WHERE gd.GradeID = @GradeID;
END;
GO

DECLARE @TotalPoints FLOAT;

EXEC dbo.CreateGradeDetail
    @GradeID = 1,
    @AchievementTypeID = 2,
    @AchievementPoints = 9,
    @AchievementMaxPoints = 10,
    @AchievementDate = '2025-04-22',
    @TotalGradePoints = @TotalPoints OUTPUT;

SELECT @TotalPoints AS TotalGradePoints;

	SELECT 
    gd.Id,
    gd.GradeID,
    gd.AchievementTypeID,
    gd.AchievementPoints,
    gd.AchievementMaxPoints,
    gd.AchievementDate,
    at.ParticipationRate,
    CAST(gd.AchievementPoints AS FLOAT) / gd.AchievementMaxPoints * at.ParticipationRate AS CalculatedPoints
	FROM GradeDetails gd
	JOIN AchievementType at ON gd.AchievementTypeID = at.Id;

	SELECT * FROM GradeDetails;
	SELECT * FROM Grade;
	SELECT * FROM AchievementType;

