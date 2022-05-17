-- LESSON 15 - FINAL LESSON

-- CONDITIONS (ifs, whiles, and the such)

-- Example:

CREATE OR ALTER PROCEDURE dbo.AddEmployeeWithCheck (@FirstName NVARCHAR(100), @LastName NVARCHAR(100) , @DateOfBirth date, @Hired DATE )
AS
BEGIN

declare @BreakingDate date 

select @BreakingDate =  dateadd(YEAR,-18,getdate())
select @BreakingDate

-- declare @FirstName NVARCHAR(100) = 'Blagoj'
-- declare @firstletteroflastname NVARCHAR(1) = 'Wostovski'
-- declare @DateOfBirth date = '1984.07.24'
-- declare @Hired DATE = '1997.01.05'
-- insert into

declare @borninthesamemonth int = 0
declare @hiredatthesameyear int = 0
declare @lastnamefirstletter int = 0

IF (@DateOfBirth <= @BreakingDate)
BEGIN
    INSERT INTO dbo.Employee (FirstName, LastName, DateOfBirth, HireDate)
    select @FirstName, @LastName, @DateOfBirth, @Hired
    select ' we will employee this person'
END

ELSE
BEGIN
    SELECT 'Too young to be employeed'
END

SELECT @borninthesamemonth = count(*) FROM dbo.Employee  
where month(DateOfBirth) = month(@DateOfBirth) 
select @lastnamefirstletter = count(*) from dbo.Employee
where LEFT(LastName, 1) = LEFT(@LastName, 1)

SELECT @hiredatthesameyear = count(*) FROM dbo.Employee  
where year(HireDate) = year(@Hired) 

select @borninthesamemonth as Count_of_same_months, @lastnamefirstletter as Count_of_same_lastName_letter, @hiredatthesameyear as same_hiredate_year

END
GO

-- Example 2:

select FirstName,LastName,HireDate, DATEADD(Year,-20,GETDATE()), case when HireDate <=  DATEADD(Year,-20,GETDATE()) then  'More then 20 Years in the company'
                            ELSE 'Less then 20 Years in the company'
                            END
from dbo.Employee

-- While loop example

1,2,3,4,5,7,9
GO
DECLARE @count AS INT = 1;
WHILE @count <= 10
BEGIN
     SELECT CAST(@count AS NVARCHAR);
     SET @count = @count + 1;
END;

-- Darja's solution

GO
DECLARE @count AS INT = 1;
WHILE @count <= 10
BEGIN
     IF @Count IN (1,2,3,4,5,7,9)
     SELECT CAST(@count AS NVARCHAR);
     SET @count = @count + 1;
END