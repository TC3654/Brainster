-- new currency procedure

CREATE PROCEDURE dbo.NewCurrrency (@code nvarchar(10),@name nvarchar(20) , @shortName nvarchar(3), @countryName nvarchar(10) NULL)
AS
BEGIN

--declare @code nvarchar(10) = '985'
--declare @name nvarchar(20) = 'Polish zloty'
--declare @shortName nvarchar(3) = 'PLN'
--declare @countryName nvarchar(10) = 'Poland'

select count(*) as TotalBefore
from dbo.Currency

INSERT INTO dbo.Currency (Code, Name, ShortName, CountryName)
select @code, @name, @shortName, @countryName


select count(*) as TotalAfter
from dbo.Currency

END
GO

-- how to call
EXEC dbo.NewCurrrency @code = '989', @name = 'Polish zloty2', @shortName = 'PLN2', @countryName = null --, @countryName = 'Poland'
GO

create procedure myMainProcedure
AS
BEGIN

declare @CurrentDate date = GETDATE()

EXEC dbo.NewCurrrency @code = '989', @name = 'Polish zloty2', @shortName = 'PLN2', @countryName = 'Poland'

END
GO

exec myMainProcedure
Go

/*

Create procedure for adding new Employee
As output the procedure should return single resultset with 3 columns
Total Number of existing employees born in the same month as the new employee
Total Number of existing employees having same first letter in the last Name as the new employee
Total number of employees hired in the same year as the new employee

Create the procedure step by step from scratch to show how this should be done

*/

CREATE OR ALTER PROCEDURE dbo.AddEmployee (@FirstName NVARCHAR(100), @LastName NVARCHAR(100) , @DateOfBirth date, @Hired DATE )
AS
BEGIN
-- declare @FirstName NVARCHAR(100) = 'Blagoj'
-- declare @firstletteroflastname NVARCHAR(1) = 'Wostovski'
-- declare @DateOfBirth date = '1984.07.24'
-- declare @Hired DATE = '1997.01.05'
-- insert into
declare @borninthesamemonth int = 0
declare @hiredatthesameyear int = 0
declare @lastnamefirstletter int = 0

INSERT INTO dbo.Employee (FirstName, LastName, DateOfBirth, HireDate)
select @FirstName, @LastName, @DateOfBirth, @Hired

SELECT @borninthesamemonth = count(*) FROM dbo.Employee  
where month(DateOfBirth) = month(@DateOfBirth) 

select @lastnamefirstletter = count(*) from dbo.Employee
where LEFT(LastName, 1) = LEFT(@LastName, 1)

SELECT @hiredatthesameyear = count(*) FROM dbo.Employee  
where year(HireDate) = year(@Hired) 

select @borninthesamemonth as Count_of_same_months, @lastnamefirstletter as Count_of_same_lastName_letter, @hiredatthesameyear as same_hiredate_year

END
GO

exec AddEmployee @FirstName = 'Smoje', @LastName = 'Lan', @DateOfBirth = '1995.07.24', @Hired = '2000.01.05'


