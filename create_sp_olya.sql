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
