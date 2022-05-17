-- week 1 - day 3

-- tables needed
/*
Employees (id, Name, Surname, Location, Date of birth, job position, Gender, email)
Customers (id, Name, Surname, Location, Date of birth, Gender, email, phone number)
accounts ( id, currency, open date, who opened - employee, limits, current balance, type of account, customer - who owns the account)
AccountDetails - Payments or transactions  (can separate the transaction or use flag to identify the type of transaction) - id, amount, account, date of transaction, receiving acouns, purpose of trans, location
Location (id, Name, region,...)
Location type (id, name)
Currency (id, name, short name,...)

-- Aut of scope
List of users of internet bank (Daria idea)
Securitty related tables (Jakub)
Exchange rate (id , FromCurrency, ToCurrency, Date, type of rate, actual rate, commision, Factor )   1     1   = 0.000005.3232

*/

ALTER DATABASE [Brainster]
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE [Brainster]
GO

CREATE DATABASE [Br]
GO

-- create tables (DDL)
CREATE TABLE dbo.Employee (
    Id int IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    NationalIdNumber NVARCHAR(15) NULL,
    JobTitle NVARCHAR(50) NULL,
    DateOfBirth DATE NULL,
    MaritalStatus NCHAR(1) NULL,
    Gender NCHAR(1) NULL,
    HireDate date NULL,
    CONSTRAINT PK_Employee PRIMARY KEY CLUSTERED (Id)
)
GO





