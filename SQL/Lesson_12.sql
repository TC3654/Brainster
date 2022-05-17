-- LESSON 12

-- SCALAR FUNCTIONS - returns scalar value (only one result)

-- Example:

CREATE FUNCTION dbo.fn_TotalTransactionsForCustomer (@CustomerId int)
RETURNS INT
AS 
BEGIN

declare @IWillStoreResultHere int

-- declare @CustomerId INT = 6

select @IWillStoreResultHere = count(*) 
from dbo.AccountDetails d
inner join dbo.Account a on a.id = d.AccountId
where a.CustomerId = @CustomerId

RETURN @IWillStoreResultHere

END
GO

select dbo.fn_TotalTransactionsForCustomer (2)

-- Prepare function that for CustomerId on input will return the current balance of his EUR account

select * from Currency

-- dbo.MyEURAccountBalance (@CustomerId) - output: decimal(18,2)
GO

CREATE FUNCTION dbo.MyEURAccountBalance (@CustomerId int)
RETURNS DECIMAL(18,2)
AS 
BEGIN

declare @Result DECIMAL(18,2)

select @Result = CurrentBalance
from dbo.Account a
WHERE a.CustomerId = @CustomerId
and CurrencyId=1

return @Result

END
GO

select dbo.MyEURAccountBalance(5)

select *
from Customer c
INNER JOIN Account a on a.CustomerId = c.Id
where CurrentBalance <> 0

update Account
set CurrentBalance = 300
where CustomerId = 5
and CurrencyId = 1

-- Expose the currency to be on input
-- dbo.MyEURAccountBalancev2(@CustomerId, @CurrencyId)
-- output: decimal(18,2)
GO

CREATE FUNCTION MyEURAccountBalancev2(@CustomerId int, @CurrencyId int)
RETURNS DECIMAL(18,2)
AS 
BEGIN

declare @Result2 DECIMAL(18,2)

select @Result2 = CurrentBalance
from dbo.Account a
WHERE a.CustomerId = @CustomerId
and CurrencyId=@CurrencyId

return @Result2

END
GO

select dbo.MyEURAccountBalancev2(5,2)


-- TABLE-VALUED FUNCTIONS - returns a table (multiple results)

-- Example:
GO

CREATE OR ALTER FUNCTION dbo.TotalTransactionsForAccountAndCurrency( @CustomerId int)
RETURNS @ResultSet table (CurrencyId int, CurrencyName nvarchar(10), TotalTransactions int)
AS 
BEGIN

--declare @CustomerId int = 1

INSERT INTO @ResultSet (CurrencyId,CurrencyName , TotalTransactions)
select a.CurrencyId, c.Name, count(*) as TotalTransactions
from dbo.AccountDetails d
inner join dbo.Account a on a.id = d.AccountId
inner join dbo.Currency c on c.id = a.CurrencyId
where a.CustomerId = @CustomerId
group by a.CurrencyId, c.Name

RETURN 

END
GO

select * from dbo.TotalTransactionsForAccountAndCurrency (10)

-- Create function that will return the total number of transactions per location type ( total ATM transactions, total Clearing house transactions, etc…) for validity period defined on input of function
-- 
-- Help:
-- input: (@CustomerId, @validFrom date, @ValidTo date)
-- Example output:
-- ATM - 5
-- Clearing house - 1
-- Branch office - 2
go

CREATE OR ALTER FUNCTION dbo.TotalTransactionsForLocationType ( @CustomerId int, @ValidFrom date, @ValidTo date)
RETURNS @ResultSet table (LocationTypeId int, LocationType nvarchar(50), TotalTransactions int)
AS 
BEGIN

INSERT INTO @ResultSet (LocationTypeId, LocationType, TotalTransactions)
select t.Id, t.Name, count(*) as TotalTransactions
from dbo.AccountDetails d
inner join dbo.[Location] l on d.LocationId = l.Id
inner join dbo.LocationType t on t.Id = l.LocationTypeId
inner join Account a on a.Id = d.AccountId
where a.CustomerId = @CustomerId
and TransactionDate BETWEEN @ValidFrom and @ValidTo
group by t.Id, t.Name
order by TotalTransactions desc

RETURN 

END
GO

-- select * from AccountDetailsto

select * from dbo.TotalTransactionsForLocationType(55, '2019.01.01', '2019.02.01')

select * from AccountDetails d
inner join Account a on a.Id = d.AccountId
where a.CustomerId = 55



-- SCALAR FUNCTIONS - TRY AT HOME
-- calculate the current balance from AccountDetails and output that number
-- additional parameter - date -> show current balance on that date
