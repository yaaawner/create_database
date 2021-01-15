USE [Library_2021]
GO

-- Checking if tables already exist, if so drop them
IF OBJECT_ID('dbo.Reservation') IS NOT NULL
    DROP TABLE [dbo].[Reservation]
IF OBJECT_ID('dbo.Members') IS NOT NULL
    DROP TABLE [dbo].[Members]
IF OBJECT_ID('dbo.Books') IS NOT NULL
    DROP TABLE [dbo].[Books]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Creating Members table
CREATE TABLE [dbo].[Members](
	[Member ID] [int] NOT NULL IDENTITY(1,1),
	[Member Name] [nvarchar](max) NOT NULL,
	[Date] [date] NOT NULL,
	CONSTRAINT [PK_Members] PRIMARY KEY ([Member ID])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Books] (
	[Book ID] [int] NOT NULL IDENTITY(1,1),
	[Title] [nvarchar](max) NOT NULL,
	[Author] [nvarchar](max) NOT NULL,
	[Year of publication] [int] NOT NULL,
	[Place of publication] [nvarchar](max) NOT NULL,
	[Publishing house] [nvarchar](max) NOT NULL,
	[Total] [int] NOT NULL,
	[Available] [int] NOT NULL,
	CONSTRAINT [PK_Books] PRIMARY KEY ([Book ID]),
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Reservation] (
	[Reservation ID] [int] NOT NULL IDENTITY(1,1),
	[Member ID] [int] NOT NULL,
	[Book ID] [int] NOT NULL,
	[Issue date] [date] NOT NULL,
	[Return date] [date] NOT NULL,
	[Checkpoint] [bit] NOT NULL, 
	CONSTRAINT [PK_Reservation] PRIMARY KEY ([Reservation ID]),
	CONSTRAINT [FK_Reservation_Members] FOREIGN KEY ([Member ID])
		REFERENCES [dbo].[Members]([Member ID]),
	CONSTRAINT [FK_Reservation_Books] FOREIGN KEY ([Book ID])
		REFERENCES [dbo].[Books]([Book ID]),
) ON [PRIMARY]
GO
