USE [master]
GO

DROP DATABASE IF EXISTS [SEDC_ACADEMY_HOMEWORK]
GO

-- Relational Database Development & Design Using MS SQL Server

-- => HOMEWORK 1 
-- Creating new database: SEDC_ACADEMY_HOMEWORK - Academy Management Database

CREATE DATABASE [SEDC_ACADEMY_HOMEWORK]
GO

USE [SEDC_ACADEMY_HOMEWORK]
GO
--Drop any existing tables if they exist
DROP TABLE IF EXISTS [dbo].[Student]
DROP TABLE IF EXISTS [dbo].[Teacher]
DROP TABLE IF EXISTS [dbo].[Course]
DROP TABLE IF EXISTS [dbo].[Grade]
DROP TABLE IF EXISTS [dbo].[AchievementType]
DROP TABLE IF EXISTS [dbo].[GradeDetails]
GO
--Student table
CREATE TABLE Student(
	[Id] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(100) NULL,
    [LastName] nvarchar(100) NULL,
    [DateOfBirth] date NULL,
    [EnrolledDate] date NULL,
    [Gender] nchar(1) NULL,
    [NationalIdNumber] bigint NULL,
    [StudentCardNumber] nvarchar(100) NULL,
    CONSTRAINT [PK_Student] PRIMARY KEY ([Id])
);
GO
-- Teacher table
CREATE TABLE Teacher (
    [Id] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(100) NULL,
    [LastName] nvarchar(100) NULL,
    [DateOfBirth] date NULL,
    [AcademicRank] nvarchar(100) NULL,
    [HireDate] date NULL,
    CONSTRAINT [PK_Teacher] PRIMARY KEY ([Id])
);
GO
-- Course table
CREATE TABLE Course (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(MAX) NULL,
    [Credit] tinyint NULL,
    [AcademicYear] tinyint NULL,
    [Semester] tinyint NULL,
    CONSTRAINT [PK_Course] PRIMARY KEY ([Id])
);
-- Grade table
CREATE TABLE Grade (
    [Id] int IDENTITY(1,1) NOT NULL,
    [StudentID] int NULL,
    [CourseID] int NULL,
    [TeacherID] int NULL,
    [Grade] tinyint NULL,
    [Comment] nvarchar(MAX) NULL,
    [CreatedDate] datetime NULL,
    CONSTRAINT [PK_Grade] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Grade_Student] FOREIGN KEY ([StudentID]) REFERENCES Student([Id]),
    CONSTRAINT [FK_Grade_Course] FOREIGN KEY ([CourseID]) REFERENCES Course([Id]),
    CONSTRAINT [FK_Grade_Teacher] FOREIGN KEY ([TeacherID]) REFERENCES Teacher([Id])
);
GO

-- The achievement type table
CREATE TABLE AchievementType (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(150) NULL,
    [Description] nvarchar(MAX) NULL,
    [ParticipationRate] int NULL,
    CONSTRAINT [PK_AchievementType] PRIMARY KEY ([Id])
);
GO

-- The GradeDetails table
CREATE TABLE GradeDetails (
    [Id] int IDENTITY(1,1) NOT NULL,
    [GradeID] int NULL,
    [AchievementTypeID] int NULL,
    [AchievementPoints] smallint NULL,
    [AchievementMaxPoints] smallint NULL,
    [AchievementDate] date NULL,
    CONSTRAINT [PK_GradeDetails] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_GradeDetails_Grade] FOREIGN KEY ([GradeID]) REFERENCES Grade([Id]),
    CONSTRAINT [FK_GradeDetails_AchievementType] FOREIGN KEY ([AchievementTypeID]) REFERENCES AchievementType([Id])
);
GO