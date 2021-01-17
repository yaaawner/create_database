USE [Library_2021]
GO

DECLARE 
@memberID int

SET @memberID = 3

SELECT *
FROM [Books] AS b
INNER JOIN [Reservation] AS r
ON r.[Book ID] = b.[Book ID]
INNER JOIN [Members] AS m 
ON r.[Member ID] = m.[Member ID] 
AND m.[Member ID] = @memberID
ORDER BY Title
GO