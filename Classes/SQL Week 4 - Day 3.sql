-- day 3

UPDATE  dbo.[Location] 
Set name = REPLACE(name, ' ATM ' , ' cash Machine ')
where name like '% ATM %'

select *
update l set Name = 'BregATM branch ATM office'
from dbo.location l
where id = 1

select *,  REPLACE(name, 'ATM' , 'cash Machine'), REPLACE(name, ' ATM ' , ' cash Machine ') as LastVersion
from dbo.location l
where id = 1

-- SCALAR FUNCTIONS

CREATE FUNCTION dbo.FunctionName (@ParametarList int)
RETURNS INT
AS 
BEGIN

DECLARE @Result INT

-- Your code comes here

RETURN @Result
END
GO

-- Author:
-- create date
-- description
-- 
CREATE FUNCTION dbo.MyABSFunction(@MyInput int)
RETURNS INT
AS
BEGIN

-- in myinput I expect the number

Declare @result int

SELECT @result = CASE WHEN @MyInput <0 THEN -@MyInput ELSE @MyInput END

RETURN @Result

END
GO


select dbo.MyABSFunction(-100) as MyOutput

select * , dbo.MyABSFunction(Amount) as MyAbsAmount
from dbo.AccountDetails
where amount  <> dbo.MyABSFunction(Amount)

select dbo.MyABSFunction(2,3)
GO
-- new function - reading data from database

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

select dbo.fn_TotalTransactionsForCustomer(100)

select *, dbo.fn_TotalTransactionsForCustomer(c.Id)

-- how to modify data based on function output
update c set PhoneNumber = dbo.fn_TotalTransactionsForCustomer(c.Id)
from dbo.Customer c
where  dbo.fn_TotalTransactionsForCustomer(c.Id) = 11


select * from dbo.Customer
