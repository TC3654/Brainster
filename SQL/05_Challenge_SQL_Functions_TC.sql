-- CHALLENGE 5

-- Create scalar function that for input parameter @NationalIDNumber will return the SUM of current balance on all EUR accounts he has.

CREATE FUNCTION CurrentEURBalance(@NationalId nvarchar(15))
returns decimal (18,2)
as
BEGIN

declare @EURBalance decimal(18,2)

select @EURBalance = SUM(ad.Amount)
from AccountDetails ad
inner join Account a on ad.AccountId = a.Id
inner join Customer c on a.CustomerId = c.Id
where c.NationalIDNumber = @NationalId
and a.CurrencyId = 1

return @EURBalance

END
GO

select dbo.CurrentEURBalance('7139462') as CurrentEURBalance

-- select * from Account
-- select * from Customer
-- select * from AccountDetails
-- select * from Currency

GO

-- Create table-valued function that for input parameter @NationalIDNumber will return resultset with CurrencyName and current balance

CREATE OR ALTER FUNCTION dbo.CurrentBalancePerNationalId (@NationalId nvarchar(15))
returns @ResultSet table (CurrencyName nvarchar(50), CurrentBalance decimal(18,2))
AS
BEGIN

insert into @ResultSet (CurrencyName, CurrentBalance)
select cr.Name, SUM(ad.Amount) as CurrentBalance
from dbo.AccountDetails ad
inner join Account a on ad.AccountId = a.Id
inner join Customer c on a.CustomerId = c.Id
inner join Currency cr on a.CurrencyId = cr.Id
where c.NationalIDNumber = @NationalId
group by cr.Name

RETURN

END
GO

select * from dbo.CurrentBalancePerNationalId('7139462')
GO