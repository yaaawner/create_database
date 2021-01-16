USE [Library_2021]
GO

DECLARE 
@ReturnCode [int]

EXEC @ReturnCode = IsAvailable 'Jane'

SELECT @ReturnCode
GO

DECLARE 
@ReturnCode [int]

EXEC @ReturnCode = IsAvailable 'Jane Eyre'

SELECT @ReturnCode
GO