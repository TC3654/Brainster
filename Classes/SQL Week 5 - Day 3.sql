-- conditions

-- IF

declare @var1 int = 6
declare @var2 int = 7

/*IF @var1 > @var2
print(@var1)
ELSE
print(@var2)
*/

IF ( @var1 > @var2) and (getdate() = '2021.04.29')
BEGIN
    SELECT @var1
    select 'Var 1 is bigger'
END
ELSE IF @var1 = @var2
BEGIN
    select 'variables are equal'
END
ELSE
BEGIN
    SELECT 'var1 is smaller then var 2'
END
GO

-- To check if employee has 18 years


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


--IF (@DateOfBirth <= @BreakingDate)
IF (@DateOfBirth <= dateadd(YEAR,-18,@Hired))
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

exec AddEmployeeWithCheck @FirstName = 'MyName', @LastName = 'Lan', @DateOfBirth = '2003-04-30', @Hired = '2000.01.05'


declare @DateOfBirth date = '2021.04.29'

GO


DECLARE @var1 AS INT = 1
DECLARE @var2 AS INT = 2

SELECT CASE WHEN @var1 = @var2 THEN 'The variables are equal' 
ELSE 'The variables are not equal' 
END

SELECT CASE WHEN @var1 = @var2 THEN 'The variables are equal' 
            WHEN @var1 > @var2 THEN 'Var1 is greather then Var2' 
        ELSE 'Var1 is smaller then Var2' 
END
GO

-- how long in the company
select FirstName,LastName,HireDate, DATEADD(Year,-20,GETDATE()), case when HireDate <=  DATEADD(Year,-20,GETDATE()) then  'More then 20 Years in the company'
                            ELSE 'Less then 20 Years in the company'
                            END
from dbo.Employee
GO


DECLARE @count AS INT = 1;
declare @MyNewName nvarchar(10) = N'Blagoj'

WHILE @count <= 10
BEGIN
     SELECT CAST(@count AS NVARCHAR);
     SET @count = @count + 1;

     set @MyNewName = 'Blagoj' + cast(@count as nvarchar(10))

     exec AddEmployeeWithCheck @FirstName = @MyNewName, @LastName = 'Lan', @DateOfBirth = '1993-04-30', @Hired = '2020.01.05'

END;

select top 15 * 
from dbo.employee
order by id desc


select top 15 * 
from dbo.employee
order by hireDate desc

select count(*) from dbo.Employee

-- 

1,2,3,4,5,7,9
GO

DECLARE @count AS INT = 1;

WHILE @count <= 10
BEGIN

    
     SELECT CAST(@count AS NVARCHAR);
     SET @count = @count + 1;

END;




