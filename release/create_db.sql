USE [master]
GO

IF EXISTS
	(SELECT * FROM sys.databases
	 WHERE [name] = 'Library_2021')
  DROP DATABASE [Library_2021]
GO

CREATE DATABASE [Library_2021]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library_2021', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Library_2021_Data' , SIZE = 51200KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'Library_2021_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Library_2021_Log_File' , SIZE = 51200KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library_2021].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Library_2021] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Library_2021] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Library_2021] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Library_2021] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Library_2021] SET ARITHABORT OFF 
GO

ALTER DATABASE [Library_2021] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Library_2021] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Library_2021] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Library_2021] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Library_2021] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Library_2021] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Library_2021] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Library_2021] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Library_2021] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Library_2021] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Library_2021] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Library_2021] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Library_2021] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Library_2021] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Library_2021] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Library_2021] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Library_2021] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Library_2021] SET RECOVERY FULL 
GO

ALTER DATABASE [Library_2021] SET  MULTI_USER 
GO

ALTER DATABASE [Library_2021] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Library_2021] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Library_2021] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Library_2021] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Library_2021] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Library_2021] SET  READ_WRITE 
GO