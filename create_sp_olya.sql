USE [Library_2021]
GO

IF OBJECT_ID('ClearTables') IS NOT NULL
	DROP PROCEDURE [ClearTables]
IF OBJECT_ID('ShowAllBooks') IS NOT NULL
	DROP PROCEDURE [ShowAllBooks]
IF OBJECT_ID('ShowAllMembers') IS NOT NULL
	DROP PROCEDURE [ShowAllMembers]
IF OBJECT_ID('ShowAllReservation') IS NOT NULL
	DROP PROCEDURE [ShowAllReservation]

IF OBJECT_ID('DeleteBook') IS NOT NULL
	DROP PROCEDURE [DeleteBook]
IF OBJECT_ID('UpdateBook') IS NOT NULL
	DROP PROCEDURE [UpdateBook]
IF OBJECT_ID('AddBook') IS NOT NULL
	DROP PROCEDURE [AddBook]
GO

CREATE PROCEDURE [ClearTables]
AS
BEGIN
	IF EXISTS 
       (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
        WHERE [CONSTRAINT_SCHEMA] = 'dbo' AND [CONSTRAINT_NAME] = 'FK_Reservation_Books'
				                          AND [CONSTRAINT_TYPE] = 'FOREIGN KEY')
	  ALTER TABLE [dbo].[Reservation] DROP CONSTRAINT [FK_Reservation_Books]
	
	IF EXISTS 
       (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
        WHERE [CONSTRAINT_SCHEMA] = 'dbo' AND [CONSTRAINT_NAME] = 'FK_Reservation_Members'
				                          AND [CONSTRAINT_TYPE] = 'FOREIGN KEY')
	  ALTER TABLE [dbo].[Reservation] DROP CONSTRAINT [FK_Reservation_Members]

	TRUNCATE TABLE [dbo].[Books]
	TRUNCATE TABLE [dbo].[Members]
	TRUNCATE TABLE [dbo].[Reservation]

	ALTER TABLE [dbo].[Reservation]
		ADD CONSTRAINT [FK_Reservation_Books]
			FOREIGN KEY ([Book ID]) REFERENCES [dbo].[Books]([Book ID])

	ALTER TABLE [dbo].[Reservation]
		ADD CONSTRAINT [FK_Reservation_Members]
			FOREIGN KEY ([Member ID]) REFERENCES [dbo].[Members]([Member ID])
END
GO

CREATE PROCEDURE [ShowAllBooks]
AS
BEGIN
	SELECT *
	FROM [dbo].[Books]
END
GO

CREATE PROCEDURE [ShowAllMembers]
AS
BEGIN
	SELECT *
	FROM [dbo].[Members]
END
GO

CREATE PROCEDURE [ShowAllReservation]
AS
BEGIN
	SELECT *
	FROM [dbo].[Reservation]
END
GO

CREATE PROCEDURE [DeleteBook]
(
	@id [int]
)
AS
BEGIN
	IF NOT EXISTS
	   (SELECT * FROM [dbo].[Reservation]
	    WHERE [Book ID] = @id)

	DELETE FROM [dbo].[Books]
	WHERE [Book ID] = @id
END 
GO

CREATE PROCEDURE [UpdateBook]
(
	@id [int],
	@title [nvarchar](max),
	@author [nvarchar](max),
	@year [int],
	@place [nvarchar](max),
	@house [nvarchar](max),
	@total [int],
	@available[int]
) AS
BEGIN
	UPDATE
		[dbo].[Books]
	SET
		[Title] = CASE
			WHEN @title IS NOT NULL THEN @title
			ELSE [Title]
		END,
	    
		[Author] = CASE
			WHEN @author IS NOT NULL THEN @author
			ELSE [Author]
		END,

		[Year of publication] = CASE
			WHEN @year IS NOT NULL THEN @year
			ELSE [Year of publication]
		END,
		
		[Place of publication] = CASE
			WHEN @place IS NOT NULL THEN @place
			ELSE [Place of publication]
		END,
		
		[Publishing house] = CASE
			WHEN @house IS NOT NULL THEN @house
			ELSE [Publishing house]
		END,
		
		[Total] = CASE
			WHEN @total IS NOT NULL THEN @total
			ELSE [Total]
		END,

		[Available] = CASE
			WHEN @available IS NOT NULL THEN @available
			ELSE [Available]
		END
	WHERE
		[Book ID] = @id
END
GO

CREATE PROCEDURE [AddBook]
(
	@title [nvarchar](max),
	@author [nvarchar](max),
	@year [int],
	@place [nvarchar](max),
	@house [nvarchar](max),
	@total [int],
	@available[int]
) AS 
BEGIN
	INSERT INTO [dbo].[Books] VALUES(@title, @author, @year, @place, @house, @total, @available)
END
GO
