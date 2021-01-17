USE [Library_2021]
GO

DECLARE 
@beginDate [date],
@endDate [date]

SET @beginDate = '12-11-2020'
SET @endDate = '12-22-2020'

SELECT *
FROM [Books] AS b
INNER JOIN [Reservation] AS r
ON r.[Book ID] = b.[Book ID]
WHERE r.[Return date]
	BETWEEN @beginDate AND @endDate
ORDER BY Title
GO

DECLARE 
@beginDate [date],
@endDate [date]

SET @beginDate = '12-11-2020'
SET @endDate = '12-19-2020'

SELECT *
FROM [Books] AS b
INNER JOIN [Reservation] AS r
ON r.[Book ID] = b.[Book ID]
WHERE r.[Return date]
	BETWEEN @beginDate AND @endDate
ORDER BY Title
GO