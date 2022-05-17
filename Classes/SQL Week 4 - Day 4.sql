-- week 4 - day 4
-- scalar
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

-- number of transactions for customer and currency
-- table valued
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

-- scalar
select  dbo.fn_TotalTransactionsForCustomer(2)

select *,  dbo.fn_TotalTransactionsForCustomer(c.Id) as TotalTran
from dbo.Customer c

-- table
select * from dbo.TotalTransactionsForAccountAndCurrency(2)

-- for every custmer show how many transactions in each currency exists
select c.* , 'aaa', t.*
from dbo.Customer as c
cross apply dbo.TotalTransactionsForAccountAndCurrency(c.id) as t   -- INNER JOIN  =  cross apply  / LEFT JOIN = OUTER APPLY
GO

-- Bojan idea - inner join

CREATE OR ALTER FUNCTION dbo.TotalTransactionsForAccountAndCurrencyV2(@CustomerId int)
RETURNS @ResultSet table (CustomerId int, CurrencyId int, CurrencyName nvarchar(10), TotalTransactions int)
AS 
BEGIN

--declare @CustomerId int = 1
INSERT INTO @ResultSet (CustomerId, CurrencyId,CurrencyName , TotalTransactions)
select a.CustomerId, a.CurrencyId, c.Name, count(*) as TotalTransactions
from dbo.AccountDetails d
inner join dbo.Account a on a.id = d.AccountId
inner join dbo.Currency c on c.id = a.CurrencyId
where a.CustomerId = @CustomerId
group by a.CustomerId,a.CurrencyId, c.Name

RETURN 

END
GO

select c.* , 'aaa', t.*
from dbo.Customer as c
cross apply dbo.TotalTransactionsForAccountAndCurrencyV2(c.id) as t   -- INNER JOIN  =  cross apply  / LEFT JOIN = OUTER APPLY
GO

select c.* , 'aaa', t.*
from dbo.Customer as c
CROSS APPLY dbo.TotalTransactionsForAccountAndCurrencyV2(c.id) as t  --ON c.Id = t.CustomerId   -- INNER JOIN  =  cross apply  / LEFT JOIN = OUTER APPLY
GO

select *
from dbo.TotalTransactionsForAccountAndCurrencyV2(c.id) as t
inner join dbo.Customer c on c.id = t.CustomerId


select * from dbo.Account
where CustomerId = 1

select * from dbo.AccountDetails d

insert into dbo.AccountDetails 
select 301,106,null,getdate(), 999,'101','money from my uncle in US'

select * from dbo.TotalTransactionsForAccountAndCurrencyV2(1)

-- Hands on

Create function that will return the total number of transactions per location type ( total ATM transactions, total Clearing house transactions, etc…) for validity period defined on input of function

Help:
-- input: (@CustomerId, @validFrom date, @ValidTo date)
Example output:
ATM - 5
Clearing house - 1
Branch office - 2

declare @customerId int = 1

select * from dbo.AccountDetails 
where AccountId in (1,301)

-- Tamara - Hands on
GO
CREATE OR ALTER FUNCTION dbo.TotalTransactionsForLocationType ( @CustomerId int, @ValidFrom date, @ValidTo date)
RETURNS @ResultSet table (LocationTypeId int, LocationType nvarchar(50), TotalTransactions int, ValidFrom date, ValidTo date)
AS 
BEGIN
INSERT INTO @ResultSet (LocationTypeId, LocationType, TotalTransactions, ValidFrom, ValidTo)
select t.Id, t.Name, count(*) as TotalTransactions, @ValidFrom as StartDate, @ValidTo as EndDate
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