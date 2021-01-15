USE [Library_2021]
GO

-- Checking if tables already exist, if so drop them
IF OBJECT_ID('dbo.Members') IS NOT NULL
    DROP TABLE [dbo].[Members]
IF OBJECT_ID('dbo.Books') IS NOT NULL
    DROP TABLE [dbo].[Books]
IF OBJECT_ID('dbo.Loanlist') IS NOT NULL
    DROP TABLE [dbo].[Loanlist]
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
