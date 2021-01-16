USE [Library_2021]

EXEC [dbo].[ClearTables]

SET NOCOUNT ON
GO

SET DATEFORMAT dmy
GO

INSERT INTO [dbo].[Books] VALUES('Jane Eyre', 'Charlotte Bronte', 2020, 'Moscow', 'AST', 10, 9)
INSERT INTO [dbo].[Books] VALUES('Powrot Z Gwiazd', 'Stanislav Lem', 2017, 'Moscow', 'AST', 10, 9)
INSERT INTO [dbo].[Books] VALUES('Star Wars: Darth Bane: Rule Of Two', 'Drew Karpyshyn', 2016, 'Saint-Petersburg', 'Azbuka', 10, 9)
INSERT INTO [dbo].[Books] VALUES('Star Wars: Darth Bane: Dynasty Of Evil', 'Drew Karpyshyn', 2016, 'Saint-Petersburg', 'Azbuka', 10, 10)
INSERT INTO [dbo].[Books] VALUES('You Are A Badass', 'Jen Sincero', 2013, 'USA', 'Runnig Press', 10, 10)
INSERT INTO [dbo].[Books] VALUES('Forecasting: principles and practice', 'Hyndman R. J., Athanasopoulos G.', 2012, 'USA', 'OTexts', 10, 10)
INSERT INTO [dbo].[Books] VALUES('12 Monkeys', 'Susanne Kord', 2019, 'UK', 'Liverpool University Press', 10, 10)
INSERT INTO [dbo].[Books] VALUES('Aristotle: On Sleep and Dreams', 'David Gallop', 1996, 'UK', 'Liverpool University Press', 10, 10)
INSERT INTO [dbo].[Books] VALUES('Brainstorm', 'Joseph Maddrey', 2020, 'UK', 'Liverpool University Press', 10, 10)
INSERT INTO [dbo].[Books] VALUES('Game Theory and Strategy', 'Philip D. Straffin', 1993, 'USA', 'Mathematical Association of America', 10, 10)
--INSERT INTO [dbo].[Books] VALUES('12 Monkeys', 'Susanne Kord', 2019, 'UK', 'Liverpool University Press', 10, 10)

INSERT INTO [dbo].[Members] VALUES('Olya Belyaeva', '12-12-2012')
INSERT INTO [dbo].[Members] VALUES('Dasha Kaverina', '12-12-2012')
INSERT INTO [dbo].[Members] VALUES('Ksenia Kocheva', '12-12-2012')
INSERT INTO [dbo].[Members] VALUES('Misha Lalala', '16-01-2021')
INSERT INTO [dbo].[Members] VALUES('Eva Smith', '16-01-2021')

INSERT INTO [dbo].[Reservation] VALUES(1, 1, '12-12-2020', '20-12-2020', 0)
INSERT INTO [dbo].[Reservation] VALUES(1, 2, '12-12-2020', '20-12-2020', 0)
INSERT INTO [dbo].[Reservation] VALUES(1, 3, '12-12-2020', '20-12-2020', 0)

SET NOCOUNT OFF
GO
