USE [Library_2021]
GO

DECLARE 
@beginDate [date],
@endDate [date]
SET @beginDate = '12-11-2020'
SET @endDate = '12-20-2020'
EXEC IssueBooks @beginDate,@endDate 
/*which books have been issued from 12-11-2020 to 12-20-2020*/
GO

DECLARE 
@beginDate [date],
@endDate [date]
SET @beginDate = '12-09-2020'
SET @endDate = '12-11-2020'
/*which books have been issued from 12-09-2020 to 12-11-2020*/
EXEC IssueBooks @beginDate,@endDate
GO

DECLARE 
@beginDate [date],
@endDate [date]
SET @beginDate = '12-11-2020'
SET @endDate = '12-20-2020'
/*which books have been returned from 12-11-2020 to 12-20-2020*/
EXEC ReturnedBooks @beginDate,@endDate
GO

DECLARE 
@beginDate [date],
@endDate [date]
SET @beginDate = '12-09-2020'
SET @endDate = '12-11-2020'
/*which books have been returned from 12-09-2020 to 12-11-2020*/
EXEC ReturnedBooks @beginDate,@endDate
GO 

DECLARE 
@memberID int
SET @memberID = 3
/*which books the member with memberID = 3 have*/
EXEC MembersBooks @memberID
GO

DECLARE 
@memberID int
SET @memberID = 1
/*which books the member with memberID = 1 have*/
EXEC MembersBooks @memberID
GO

DECLARE 
@ReturnCode [int]
/*There is book 'Jane' in the library
if yes return 1 
else return 0*/
EXEC @ReturnCode = IsAvailable 'Jane' 
SELECT @ReturnCode
GO

DECLARE 
@ReturnCode [int]
/*There is book 'Jane Eyre' in the library
if yes return 1 
else return 0*/
EXEC @ReturnCode = IsAvailable 'Jane Eyre'
SELECT @ReturnCode
GO


