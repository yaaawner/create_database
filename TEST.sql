USE [Library_2021]
GO

SET DATEFORMAT dmy
GO

-- Добавляем новую книгу в каталог
EXEC [dbo].[AddBook] lala, la, 2020, lala, la, 11, 11

-- Изменяем данные о книге
EXEC [dbo].[UpdateBook] 11, BOOOOK, NULL, NULL, NULL, NULL, NULL, NULL

-- Удаление книги. Расскоментировать для просмотра результата
--EXEC [dbo].[ShowAllBooks]
EXEC [dbo].[DeleteBook] 11
--EXEC [dbo].[ShowAllBooks]

-- Добавление, изменение, удаление читателя
--EXEC [dbo].[ShowAllMembers]
EXEC [dbo].[AddMember] Somebody, '17-12-2020'
--EXEC [dbo].[ShowAllMembers]

EXEC [dbo].[UpdateMember] 5, NULL, '18-01-2021'
--EXEC [dbo].[ShowAllMembers]

EXEC [dbo].[DeleteMember] 4
--EXEC [dbo].[ShowAllMembers]

-- Поиск книги по шифру или названию
EXEC [dbo].[FindBook] 1, NULL

-- Выдача книги читателю. Аргументы: шифр книги, номер читателя, дата выдачи, дата возврата
EXEC [dbo].[BookIssue] 7, 3, '18-01-2021', '20-01-2021'

-- Возврат книги. Аргументы: номер в списки записи на выдачу, шифр книги
EXEC [dbo].[BookReturn] 3, 3



DECLARE 
@beginDate [date],
@endDate [date]
SET @beginDate = '11-12-2020'
SET @endDate = '20-12-2020'
EXEC IssueBooks @beginDate,@endDate 
/*which books have been issued from 11-12-2020 to 20-12-2020*/
GO

DECLARE 
@beginDate [date],
@endDate [date]
SET @beginDate = '9-12-2020'
SET @endDate = '11-12-2020'
/*which books have been issued from 09-12-2020 to 11-12-2020*/
EXEC IssueBooks @beginDate,@endDate
GO

DECLARE 
@beginDate [date],
@endDate [date]
SET @beginDate = '11-12-2020'
SET @endDate = '20-12-2020'
/*which books have been returned from 11-12-2020 to 20-12-2020*/
EXEC ReturnedBooks @beginDate,@endDate
GO

DECLARE 
@beginDate [date],
@endDate [date]
SET @beginDate = '09-12-2020'
SET @endDate = '11-12-2020'
/*which books have been returned from 09-12-2020 to 11-12-2020*/
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