select * from dbo.Employee

-- option 1
INSERT INTO dbo.Employee(FirstName,LastName)
VALUES ('Bojan','Karaica'),('Bojan 2', 'Karaica 2')

-- Option 2
INSERT INTO dbo.Employee(FirstName,LastName)
SELECT 'Bojan 3','Karaica 3'

INSERT INTO dbo.Employee(FirstName,LastName)
select FirstName, LastName
from dbo.Employee
where FirstName like ' test'
GO

CREATE TABLE [dbo].[Customer](
[ID] [int] IDENTITY(1,1) NOT NULL,
[FirstName] [nvarchar](100) NOT NULL,
[LastName] [nvarchar](100) NOT NULL,
[NationalIDNumber] [nvarchar](15) NULL,
[JobTitle] [nvarchar](50) NULL,
[DateOfBirth] [date] NULL,
[MaritalStatus] [nchar](1) NULL,
[Gender] [nchar](1) NULL,
[HireDate] [date] NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
[ID] ASC
))
GO


select *
from dbo.Customer


select *
from dbo.Employee

INSERT INTO dbo.Customer (FirstName,LastName,DateOfBirth)
select FirstName + N' new', LastName, DateOfBirth
FROM dbo.Employee
WHERE LastName like '%2'

GO

-- Default constraint

ALTER TABLE Employee
ADD CONSTRAINT DF_Employee_JobTitle
DEFAULT 'Officer' FOR JobTitle
GO

INSERT INTO dbo.Employee (FirstName,LastName)
VALUES ('Blagoj','Last Name')

select * from dbo.Employee

-- Insert new default constraint for Gender column - F value to be inserted by default
-- test the constraint corectness


CREATE TABLE [dbo].[Employee2](
[ID] [int] IDENTITY(1,1) NOT NULL,
[FirstName] [nvarchar](100) NOT NULL,
[LastName] [nvarchar](100) NOT NULL,
[NationalIDNumber] [nvarchar](15) NULL,
[JobTitle] [nvarchar](50) NULL DEFAULT('Officer def.'),
[DateOfBirth] [date] NULL,
[MaritalStatus] [nchar](1) NULL,
[Gender] [nchar](1) NULL,
[HireDate] [date] NULL,
 CONSTRAINT [PK_Employee2] PRIMARY KEY CLUSTERED 
(
[ID] ASC
))
GO


INSERT INTO dbo.Employee2 (FirstName,LastName)
VALUES ('Blagoj','Last Name')


update e set JobTitle = N'Officer 2'
from dbo.Employee e
where JobTitle is null

select * from dbo.Employee
GO

-- DDL - Data definion language - > change definition of data
-- change how the table is organized, how constrants are organized,... so changing the placeholder for data  - but not the data itself

-- CREATE, ALTER, DROP 

-- DML - Data Modification lagnuage
-- SELECT, INSERT, UPDATE, DELETE


-- Check constraint

ALTER TABLE dbo.Employee WITH CHECK
ADD CONSTRAINT CHK_Employee_HireDate
CHECK (HireDate>='1980.01.01');
GO

INSERT INTO dbo.Employee (FirstName,LastName,HireDate)
VALUES ('Blagoj','Last Name','1970.01.01')

select * from dbo.Employee

INSERT INTO dbo.Employee (FirstName,LastName,HireDate)
VALUES ('Blagoj','Last Name','1990.01.01')
GO

-- Add check constraint that will allow only inserting M and F as Gender

-- alter the table to add the constraint
GO

-- test that constraint

-- UNIQUE Constraint
ALTER TABLE  dbo.Employee WITH CHECK
ADD CONSTRAINT UC_NationalIDNumber UNIQUE (NationalIDNumber)

select *, N'0000b' + Id 
from dbo.Employee
GO

select *, N'000000' + cast(Id as nvarchar(10)) 
from dbo.Employee
GO

-- 
select *, N'000000' + cast(Id as nvarchar(10)) 
from dbo.Employee
GO

update e set NationalIDNumber = cast(Id as nvarchar(10)) 
from dbo.Employee e
GO

select *
from dbo.Employee e




select * from dbo.Employee

INSERT INTO dbo.Employee (FirstName,LastName,HireDate, NationalIDNumber)
VALUES ('Blagoj','Last Name','1990.01.01', 'a1')
GO


