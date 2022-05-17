--LESSON 1

-- Create a new database called 'Brainster'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'Brainster'
)
CREATE DATABASE Brainster
GO

CREATE TABLE Employee(
ID int IDENTITY(1,1) NOT NULL,
FirstName nvarchar(100) NOT NULL,
LastName nvarchar(100) NOT NULL,
NationalIDNumber nvarchar(15) NULL,
JobTitle nvarchar(50) NULL,
DateOfBirth date NULL,
MaritalStatus nchar(1) NULL,
Gender nchar(1) NULL,
HireDate date NULL,
 CONSTRAINT PK_Employee PRIMARY KEY CLUSTERED
(
ID ASC
))

-- new data
INSERT INTO dbo.Employee (FirstName,LastName, DateOfBirth)
SELECT 'Tamara','Curk','1990.01.01'

select *
from Employee

--update data
-- start with select, then change to update
-- important that we use ' instead of " <-- doesn't work with "
update e set LastName='Curkovski'
from Employee as e
where id = 1

--delete data
-- same - start with select, then change it to delete
delete
from Employee
where id=3