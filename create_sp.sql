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

IF OBJECT_ID('FindBook') IS NOT NULL
	DROP PROCEDURE [FindBook]
IF OBJECT_ID('BookIssue') IS NOT NULL
	DROP PROCEDURE [BookIssue]
IF OBJECT_ID('BookReturn') IS NOT NULL
	DROP PROCEDURE [BookReturn]

IF OBJECT_ID('DeleteMember') IS NOT NULL
	DROP PROCEDURE [DeleteMember]
IF OBJECT_ID('UpdateMember') IS NOT NULL
	DROP PROCEDURE [UpdateMember]
IF OBJECT_ID('AddMember') IS NOT NULL
	DROP PROCEDURE [AddMember]
GO

IF OBJECT_ID('IssueBooks') IS NOT NULL
	DROP PROCEDURE [IssueBooks]
GO
IF OBJECT_ID('ReturnedBooks') IS NOT NULL
	DROP PROCEDURE [ReturnedBooks]
GO
IF OBJECT_ID('MembersBooks') IS NOT NULL
	DROP PROCEDURE [MembersBooks]
GO
IF OBJECT_ID('IsAvailable') IS NOT NULL
	DROP PROCEDURE [IsAvailable]
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

-- Delete book in catalog
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


-- Update book in catalog
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

-- Add book in catalog
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

/*Процедура удаления читателя из списка, требуется знать его ID в базе*/
CREATE PROCEDURE [DeleteMember]
(
	@id [int]
)
AS
BEGIN
	IF NOT EXISTS
	   (SELECT * FROM [dbo].[Reservation]
	    WHERE [Member ID] = @id)

	DELETE FROM [dbo].[Members]
	WHERE [Member ID] = @id
END 
GO

/*Процедура изменения данных читателя из списка, требуется знать его ID в базе*/
CREATE PROCEDURE [UpdateMember]
(
	@id [int],
	@Name [nvarchar](max),
	@Date [date]
) AS
BEGIN
	UPDATE
		[dbo].[Members]
	SET
		[Member Name] = CASE
			WHEN @Name IS NOT NULL THEN @Name
			ELSE [Member Name]
		END,
	    
		[Date] = CASE
			WHEN @Date IS NOT NULL THEN @Date
			ELSE [Date]
		END
	WHERE 
		[Member ID] = @id
END
GO

/*Процедура добавления нового читателя в список*/
CREATE PROCEDURE [AddMember]
(
	@Name [nvarchar](max),
	@Date [date]
) AS 
BEGIN
	INSERT INTO [dbo].[Members] VALUES (@Name, @Date)
	RETURN SCOPE_IDENTITY()
END
GO

/*Процедура поиска кники в каталоге по названию или шифру, сделано так, как если бы пользователь заводил 
Сознательно только или шифр, или название!
Отобразит разные книги, если бедет введен шифр одной и название другой книги
Ничего не отобразит при пустых вводных данных*/
CREATE PROCEDURE [FindBook]
(
	@id [int],
	@name [nvarchar](max)
) AS
BEGIN
	SELECT 
		*
	FROM [dbo].[Books]
	WHERE [Book ID] = @id OR [Title] = @name
END
GO

/*Процедура выдачи книги читателю, требуется знать ID книги в каталоге и ID читателя в списке*/
CREATE PROCEDURE [BookIssue]
(
	@bookid [int],
	@memberid [int],
	@issuedate [date],
	@returndate [date]
) AS
BEGIN
	IF EXISTS (SELECT * FROM [dbo].[Books] WHERE [Book ID] = @bookid AND [Available] > 0)
		INSERT INTO [dbo].[Reservation] VALUES (@memberid, @bookid, @issuedate, @returndate, 0)
		UPDATE [dbo].[Books] SET [Available] = [Available] - 1 WHERE [Book ID] = @bookid
END
GO

/*Процедура возврата книги читателем, требуется знать ID записи в хранилище и ID взятой книги в каталоге*/
CREATE PROCEDURE [BookReturn]
(
	@reserveid [int],
	@bookid [int]
) AS
BEGIN
	UPDATE [dbo].[Reservation] SET [Checkpoint] = 1 WHERE [Reservation ID] = @reserveid
	UPDATE [dbo].[Books] SET [Available] = [Available] + 1 WHERE [Book ID] = @bookid
END
GO

/*which books have been issued in range date*/
CREATE PROC dbo.IssueBooks
	@beginDate date,
	@endDate date
AS
SELECT *
FROM [Books] AS b
INNER JOIN [Reservation] AS r
ON r.[Book ID] = b.[Book ID]
WHERE r.[Issue date] 
	BETWEEN @beginDate AND @endDate
ORDER BY Title
GO

/*which books have been returned in range date*/
CREATE PROC dbo.ReturnedBooks
    @beginDate date,
	@endDate date
AS
SELECT *
FROM [Books] AS b
INNER JOIN [Reservation] AS r
ON r.[Book ID] = b.[Book ID]
WHERE r.[Return date]
	BETWEEN @beginDate AND @endDate
ORDER BY Title
GO

/*which books the member have*/
CREATE PROC dbo.MembersBooks
	@memberID int
AS
SELECT *
FROM [Books] AS b
INNER JOIN [Reservation] AS r
ON r.[Book ID] = b.[Book ID]
INNER JOIN [Members] AS m 
ON r.[Member ID] = m.[Member ID] 
AND m.[Member ID] = @memberID
ORDER BY Title
GO

/*There is such book in the library
if yes return 1 
else return 0*/
CREATE PROC dbo.IsAvailable
    @title [nvarchar](max)
AS
IF EXISTS 
  (SELECT [Title] FROM [Books] WHERE @title = [Title] 
  AND [Available] > 0)
     RETURN (1) 
ELSE RETURN (0)
GO