-- LESSON 14

-- PROCEDURES

-- Let's continue from Jakub's version
-- Improve procedure to update the CurrentBalance column on Account level (dbo.Account table) for each transaction

CREATE OR ALTER PROCEDURE dbo.NewMbankTransaction (@CustomerId int, @CurrencyCode int , @TransactionDate date , @Amount decimal(18,2), @PurposeCode int)
AS
BEGIN

--DECLARE @CurrentBalanceAfterTransaction DECIMAL(18,2)
DECLARE @AccountId NVARCHAR(20)
--DECLARE @CustomerId int = 1
--DECLARE @CurrencyCode int  = 1
-- Declare @CurrencyCode NVARCHAR(20)
declare @CurrencyId int

set @CurrencyID = (select id from dbo.Currency Where Code = @CurrencyCode)
set @AccountId = (select Id from dbo.Account Where CustomerId = @CustomerId and CurrencyId = @CurrencyID)

--select @AccountId

INSERT into dbo.AccountDetails(AccountId, LocationId, TransactionDate, Amount, PurposeCode)
Select @AccountId, 14, @TransactionDate, @Amount, @PurposeCode

update dbo.Account
set CurrentBalance = (select sum(Amount)
from dbo.AccountDetails
where AccountId = @AccountId)
where Id = @AccountId

SELECT sum(Amount) from dbo.AccountDetails
Where AccountId = @AccountId

END
GO

-- another option: declare @CurrentBalance decimal(18,2) and use that instead of subqueries

exec NewMbankTransaction @CustomerId = 55, @CurrencyCode = 978, @TransactionDate = '2021.03.15', @Amount = -200, @PurposeCode = 930

select * from AccountDetails

select * from Account
where CustomerId = 55

go 



-- Prepare procedure that will be used to generate report for customer balance at specific date
-- Input: CustomerId, Date
-- Output: CustomerName, Balance on date , Currency Short Name

CREATE OR ALTER PROCEDURE dbo.BalanceOnSpecificDate (@CustomerId int, @Date date)
AS
BEGIN

-- declare @CustomerId int = 54
-- declare @Date date = '2019.04.01'

select (c.FirstName + ' ' + c.LastName) as CustomerName, cr.ShortName, SUM(ad.Amount) as CurrentBalance
from dbo.AccountDetails ad
inner join Account a on ad.AccountId = a.Id
inner join Customer c on a.CustomerId = c.Id
inner join Currency cr on a.CurrencyId = cr.Id
where c.Id = @CustomerId
and ad.TransactionDate <= @Date
group by cr.ShortName, c.FirstName, c.LastName

END
GO

exec dbo.BalanceOnSpecificDate @CustomerId = 54, @Date = '2019.04.01'
go

-- checking:
-- select *, 
-- SUM(Amount) OVER (PARTITION BY AccountId order by TransactionDate, ad.Id) as RunningBalance
-- FROM dbo.AccountDetails ad
-- inner join dbo.Account a on a.Id = ad.AccountId
-- where a.CustomerId = 54
-- order by AccountId, TransactionDate, ad.Id

-- Extend the procedure to log all calls for the report in new table
-- Log should contain info about the employee (employeeId) requested the report, customerId and date.
-- Logs should be written in new table - CustomerReportLogs

CREATE OR ALTER PROCEDURE dbo.BalanceOnSpecificDateByEmployee (@EmployeeId int, @CustomerId int, @Date date)
AS
BEGIN

-- declare @CustomerId int = 54
-- declare @Date date = '2019.04.01'

select (c.FirstName + ' ' + c.LastName) as CustomerName, cr.ShortName, SUM(ad.Amount) as CurrentBalance
from dbo.AccountDetails ad
inner join Account a on ad.AccountId = a.Id
inner join Customer c on a.CustomerId = c.Id
inner join Currency cr on a.CurrencyId = cr.Id
where c.Id = @CustomerId
and ad.TransactionDate <= @Date
group by cr.ShortName, c.FirstName, c.LastName

END
GO

exec dbo.BalanceOnSpecificDateByEmployee @EmployeeId = 5, @CustomerId = 54, @Date = '2019.04.01'

-- Jakub's solution

GO

CREATE OR ALTER PROCEDURE dbo.CustomerReportV2 (@EmployeeID int, @CustomerId int, @BalanceTill date)
AS
BEGIN

--declare @CustomerId INT = 1
Declare @CustomerName NVARCHAR(100)

set @CustomerName = (Select FirstName From dbo.Customer where Id = @CustomerId) + ' ' + (Select LastName From dbo.Customer where Id = @CustomerId)

Declare @EmployeeName NVARCHAR(100)

set @EmployeeName = (Select FirstName From dbo.Employee where Id = @EmployeeID) + ' ' + (Select LastName From dbo.Employee where Id = @EmployeeID)

--select @CustomerName

Declare @CustomersAccounts Table ( CustomerName NVARCHAR(100), CurrencyId int, CurrencyShortName NVARCHAR(10), CurrentState decimal(18,2))

--DECLARE @BalanceTill date = '2019.01.20'
--DECLARE @CustomerId int = 1

INSERT into @CustomersAccounts
select @CustomerName, a.CurrencyId, cr.ShortName, Sum(Amount)
from dbo.Account a
Join dbo.Currency cr on a.CurrencyId = cr.Id
join dbo.AccountDetails ad on ad.AccountId = a.Id
where a.CustomerId = @CustomerId and ad.TransactionDate < @BalanceTill
Group BY a.CurrencyId, cr.ShortName

--LOGSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
--DECLARE @CustomerReportLogs table (EmployeeID int, EmployeeName nvarchar(100), CustomerID int, CustomerName NVARCHAR(100), ReportUntil date, RequestDate date)

INSERT into dbo.CustomerReportLogs 
SELECT @EmployeeID, @CustomerId,  getdate()

--RESULT
select * from @CustomersAccounts

--select * from dbo.CustomerReportLogs

END
GO

--CREATING TABLE
CREATE TABLE dbo.CustomerReportLogs(
[ID] [int] IDENTITY(1,1) NOT NULL, EmployeeID INT NOT NULL, CustomerID int NOT NULL, DateOfRequest date NOT NULL,
CONSTRAINT [PK_LOG] PRIMARY KEY CLUSTERED 
(
[ID] ASC
))

exec dbo.CustomerReportV2 @EmployeeID = 2, @CustomerId = 3, @BalanceTill = '2020.03.20'

SELECT * from dbo.CustomerReportLogs