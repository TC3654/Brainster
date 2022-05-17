-- LESSON 3

-- Designing a DB

-- tables we need:
/*
Employees: ID, Name, Surname, Location, Job position, DoB, Gender, Email
Customers: ID, Name, Surname, Location, DoB, Gender, Email, Phone Number, Address
Account: ID, Currency, Open date, Employee opening the account, Customer, Limits, Current balance, Type of account
AccountDetails (Transactions): ID, Amount, Account, Date and Time, Location, Receiving account, Purpose
Location: ID, Name, Region, Address
Location Type: ID, Name
Currency: ID, Name, Abbrevaition

Out of scope:
Exchange rate: ID, FromCurrency, ToCurrency, Date, Type of rate, Actual rate, Commission, Factor
Security related tables
*/

-- Re-create Brainster DB

-- Drop the database 'Brainster'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
-- ALTER DATABASE Brainster SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
IF EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'Brainster'
)
DROP DATABASE Brainster
GO

-- to cancel all connections so we can drop the existing table
alter DATABASE Brainster
set SINGLE_USER WITH ROLLBACK IMMEDIATE

-- Create a new database called 'Brainster'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'Brainster'
)
CREATE DATABASE Brainster
GO

-- create tables is DDL - should be separated with GO

-- Employee table

-- Create a new table called '[Employee]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Employee]', 'U') IS NOT NULL
DROP TABLE [dbo].[Employee]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Employee]
(
    [Id] INT IDENTITY(1,1) NOT NULL, -- Primary Key better to add the constraint at the end
    [FirstName] NVARCHAR(100) NOT NULL,
    [LastName] NVARCHAR(100) NOT NULL,
    NationalIDNumber NVARCHAR(15) null,
    JobTitle NVARCHAR(50) null,
    DateOfBirth date null,
    MaritalStatus NCHAR(1) null,
    Gender NCHAR(1) NULL,
    HireDate date null,
    CONSTRAINT PK_Employee PRIMARY KEY CLUSTERED (Id)
);
GO

-- Customer

-- Create a new table called '[Customer]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Customer]', 'U') IS NOT NULL
DROP TABLE [dbo].[Customer]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Customer]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [FirstName] NVARCHAR(100) NOT NULL,
    [LastName] NVARCHAR(100) NOT NULL,
    Gender NCHAR(1) NULL,
    NationalIDNumber NVARCHAR(15) null,
    DateOfBirth date null,
    City NVARCHAR(100) null,
    RegionName NVARCHAR(100) null,
    PhoneNumber NVARCHAR(20) NULL,
    isActive BIT not null,
    CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED (Id)
);
GO

-- Currency

-- Create a new table called '[Currency]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Currency]', 'U') IS NOT NULL
DROP TABLE [dbo].[Currency]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Currency]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    Code NVARCHAR(5) null,
    Name NVARCHAR(100) null,
    ShortName NVARCHAR(20) null,
    CountryName NVARCHAR(100) null,
    CONSTRAINT PK_Currency PRIMARY KEY CLUSTERED (Id)
);
GO

-- Location type

-- Create a new table called '[LocationType]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[LocationType]', 'U') IS NOT NULL
DROP TABLE [dbo].[LocationType]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[LocationType]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) not null,
    Description NVARCHAR(1000) null,
    CONSTRAINT PK_LocationType PRIMARY KEY CLUSTERED (Id)
);  
GO

-- Location

-- Create a new table called '[Location]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Location]', 'U') IS NOT NULL
DROP TABLE [dbo].[Location]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Location]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    LocationTypeId INT not null,
    Name NVARCHAR(100) not null,
    Description NVARCHAR(1000) null,
    CONSTRAINT PK_Location PRIMARY KEY CLUSTERED (Id)
);
GO

-- Account

-- Create a new table called '[Account]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Account]', 'U') IS NOT NULL
DROP TABLE [dbo].[Account]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Account]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    AccountNumber NVARCHAR(20) null,
    CustomerId int not null,
    CurrencyId int not null,
    AllowedOverdraft DECIMAL(18, 2) null,
    CurrentBalance DECIMAL(18, 2) NULL,
    EmployeeID int not null,
    CONSTRAINT PK_Account PRIMARY KEY CLUSTERED (Id)
);
GO

-- Account details

-- Create a new table called '[AccountDetails]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[AccountDetails]', 'U') IS NOT NULL
DROP TABLE [dbo].[AccountDetails]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[AccountDetails]
(
    [Id] bigint IDENTITY(1,1) NOT NULL,
    AccountId int not null,
    LocationId int not null,
    EmployeeId int null,
    TransactionDate datetime not null,
    Amount DECIMAL(18, 2) not null,
    PurposeCode smallint null,
    PurposeDescription NVARCHAR(100) null,
    CONSTRAINT PK_AccountDetails PRIMARY KEY CLUSTERED (Id)
);
GO