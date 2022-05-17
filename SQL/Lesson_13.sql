-- LESSON 13

-- STORED PROCEDURES

-- Example

CREATE OR ALTER PROCEDURE dbo.NewCurrrency (@code nvarchar(10),@name nvarchar(20) , @shortName nvarchar(3), @countryName nvarchar(10))
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

EXEC dbo.NewCurrrency @code = '985', @name = 'Polish zloty', @shortName = 'PLN', @countryName  = 'Poland'
go



-- Create procedure for adding new Employee

select * from Employee

go

-- declare @id int = 102
-- declare @FirstNme nvarchar(50) = 'Dirk'
-- declare @LastName nvarchar(50) = 'Lane'
-- declare @NationalId nvarchar(15) = '73221652'
-- declare @DoB date = '1980.06.15'
-- declare @Gender NVARCHAR(1) = 'M'
-- declare @HireDate date = '2005.04.20'

CREATE OR ALTER PROCEDURE dbo.NewEmployee (@FirstNme nvarchar(100), @LastName nvarchar(100), @NationalId nvarchar(15), @DoB date, @Gender NVARCHAR(1), @HireDate date)
AS
BEGIN

INSERT INTO dbo.Employee (FirstName, LastName, NationalIDNumber, DateOfBirth, Gender, HireDate)
select @FirstNme, @LastName, @NationalId, @DoB, @Gender, @HireDate

-- As output the procedure should return single resultset with 3 columns
-- Total Number of existing employees born in the same month as the new employee

select count(*) as TotalSameMonth
from Employee
where MONTH(DateOfBirth) = MONTH(@DoB)

-- Total Number of existing employees having same first letter in the last Name as the new employee

select count(*) as TotalSameLetter
from Employee
where LEFT(LastName, 1) = LEFT(@LastName, 1)

-- Total number of employees hired in the same year as the new employee

select count(*) as TotalSameHireYear
from Employee
where YEAR(HireDate) = YEAR(@HireDate)

-- Create the procedure step by step from scratch to show how this should be done

END
go

EXEC dbo.NewEmployee @FirstNme = 'Dirk', @LastName = 'Lane', @NationalId = '73221652', @DoB = '1980.06.15', @Gender = 'M', @HireDate = '2005.04.20'
go

-- Bojan's solution

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



-- Create procedure that will add new transactions in the system. Procedure should be used by M-bank application
-- Procedure name: NewMbankTransaction
-- Input parameters: CustomerId , Currency code, TransactionDate, Amount, PurposeCode
-- Output: New balance on the customer account
-- Note: insert data only in AccountDetails table (do not correct the CurrentBalance)

go

-- Jakub's solution

CREATE OR ALTER PROCEDURE dbo.NewMbankTransaction (@CustomerId int, @CurrencyCode int , @TransactionDate date , @Amount decimal(18,2), @PurposeCode int)
AS
BEGIN

--DECLARE @CurrentBalanceAfterTransaction DECIMAL(18,2)
DECLARE @AccountId NVARCHAR(20)
--DECLARE @CustomerId int = 1
--DECLARE @CurrencyCode int  = 1
Declare @CurrencyCode NVARCHAR(20)

set @CurrencyID = (select id from dbo.Currency Where Code = @CurrencyCode)
set @AccountId = (select Id from dbo.Account Where CustomerId = @CustomerId and CurrencyId = @CurrencyID)

--select @AccountId

INSERT into dbo.AccountDetails(AccountId, LocationId,TransactionDate, Amount, PurposeCode)
Select @AccountId, 14, @TransactionDate, @Amount, @PurposeCode
SELECT sum(Amount) from dbo.AccountDetails
Where AccountId = @AccountId

END
GO