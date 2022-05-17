CREATE TABLE [dbo].[Employee](
[ID] [int] IDENTITY(1,1) NOT NULL,
[FirstName] [nvarchar](100) NOT NULL,
[LastName] [nvarchar](100) NOT NULL,
[NationalIDNumber] [nvarchar](15) NULL,
[JobTitle] [nvarchar](50) NULL,
[DateOfBirth] [date] NULL,
[MaritalStatus] [nchar](1) NULL,
[Gender] [nchar](1) NULL,
[HireDate] [date] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
[ID] ASC
))
GO


-- new data
INSERT INTO dbo.Employee (FirstName,LastName, DateOfBirth)
SELECT ' test','Kostovski2','1980.01.01'

-- update data
UPDATE e set LastName = 'Karaica'
--select *
from dbo.Employee as e
where id = 4

-- delete statement

DELETE
from dbo.Employee
where id = 6


select *
from dbo.Employee

-- new data
INSERT INTO dbo.Employee (FirstName,LastName, DateOfBirth)
SELECT ' test','Kostovski2','2021.02.32'

select *, convert(varchar, DateOfBirth, 107)
 from dbo.Employee
