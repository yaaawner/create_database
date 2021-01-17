USE [Library_2021]
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