USE [Library_2021]
GO

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