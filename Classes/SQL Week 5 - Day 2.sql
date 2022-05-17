CREATE OR ALTER PROCEDURE dbo.NewMbankTransaction (@CustomerId int, @CurrencyCode int , @TransactionDate date , @Amount decimal(18,2), @PurposeCode int)
AS
BEGIN

--DECLARE @CurrentBalanceAfterTransaction DECIMAL(18,2)

DECLARE @AccountId NVARCHAR(20)
--DECLARE @CustomerId int = 1
--DECLARE @CurrencyCode int  = 1
DECLARE @CurrentBalance decimal(18,6)

Declare @CurrencyID NVARCHAR(20)

set @CurrencyID = (select id from dbo.Currency Where Code = @CurrencyCode)
set @AccountId = (select Id from dbo.Account Where CustomerId = @CustomerId and CurrencyId = @CurrencyID)

---select @AccountId letMeSeeTheValue

INSERT into dbo.AccountDetails(AccountId, LocationId,TransactionDate, Amount, PurposeCode)
Select @AccountId, 14, @TransactionDate, @Amount, @PurposeCode

SELECT @CurrentBalance = sum(Amount) from dbo.AccountDetails
Where AccountId = @AccountId

update a set CurrentBalance = @CurrentBalance
from dbo.Account as a
where a.id = @AccountId

select @CurrentBalance as CurrentBalance

END
GO

exec  dbo.NewMbankTransaction @CustomerId = 1, @CurrencyCode = 978 , @TransactionDate = '2021.04.28' , @Amount =-10, @PurposeCode = 100


GO

--Input: CustomerId, Date
--Output: CustomerName, Balance on date , Currency Short Name
CREATE OR ALTER PROCEDURE CurrentBalance (@CustomerId int, @Date date)
AS
SELECT C.FirstName + ' ' + C.LastName AS 'CustomerName', SUM(AD.Amount) AS 'Balance on date', Cu.ShortName FROM Customer C
INNER JOIN Account A ON A.CustomerId = C.Id
INNER JOIN AccountDetails AD ON AD.AccountId = A.Id
INNER JOIN Currency Cu ON Cu.id = A.CurrencyId
WHERE C.Id=@CustomerId AND AD.TransactionDate<=@Date
GROUP BY  C.FirstName, C.LastName, Cu.ShortName
GO

EXEC CurrentBalance @CustomerId = 1, @Date = '2019-02-01'
GO

--CREATING TABLE
CREATE TABLE dbo.CustomerReportLogs(
[ID] [int] IDENTITY(1,1) NOT NULL, EmployeeID INT NOT NULL, CustomerID int NOT NULL, DateOfRequest date NOT NULL,
CONSTRAINT [PK_LOG] PRIMARY KEY CLUSTERED 
(
[ID] ASC
))
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

exec dbo.CustomerReportV2 @EmployeeID = 3, @CustomerId = 1, @BalanceTill = '2021.03.20'
SELECT * from dbo.CustomerReportLogs
GO