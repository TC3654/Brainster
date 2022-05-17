-- week 3 day 2

--Try at home (14.04.2021)
--1
DECLARE @MyEmployees TABLE (
    [NationalIDNumber] [nvarchar](15) NULL
)

INSERT INTO @MyEmployees 
Select NationalIDNumber 
from dbo.employee
where lastname= 'eder'

DECLARE @gender NVARCHAR(1) = 'f'

SELECT firstname + ' ' + lastname as Employee
From dbo.employee as x
inner join @MyEmployees as y on x.NationalIDNumber = y.NationalIDNumber
WHERE x.gender = @gender
GO

--temp table
--DROP TABLE #MyEmployees
Create TABLE #MyEmployees (
    [NationalIDNumber] [nvarchar](15) NULL,
    [DateOfBirth] [date] NULL
)

INSERT INTO #MyEmployees 
Select NationalIDNumber, DateOfBirth
from dbo.employee
where lastname= 'eder'

DECLARE @gender NVARCHAR(1) = 'f'

SELECT firstname + ' ' + lastname as 'female Employees born after april'
From dbo.employee as x
inner join #MyEmployees as y on x.NationalIDNumber = y.NationalIDNumber
WHERE x.gender = @gender AND MONTH(y.DateOfBirth) > 4

-- Subqueries
-- Question is : Give me all currencies for which we have open accounts in our BANK

-- join
SELECT DISTINCT c.Name, c.Code
FROM dbo.Currency c
INNER JOIN dbo.Account a on a.CurrencyId = c.id

-- with subquery - in where 
select *
from dbo.Currency
WHERE id in (select distinct CurrencyId from dbo.Account)

select distinct CurrencyId from dbo.Account


-- Question is : Give me all currencies for which we have open accounts in our BANK, and also tell me how many accounts from each currencies exists
-- subquery
select *, (select count(*) from dbo.Account a where CurrencyId = c.id)
from dbo.Currency c
WHERE id in (select distinct CurrencyId from dbo.Account)

-- with joins + grouping
SELECT c.Name, c.Code,  count(*)
FROM dbo.Currency c
INNER JOIN dbo.Account a on a.CurrencyId = c.id
GROUP BY c.Name, c.Code

-- the underlying data
select count(*) from dbo.Account
select count(*) from dbo.Account where CurrencyId = 1
select count(*) from dbo.Account where CurrencyId = 2

-- plan
select c.Code
from dbo.Currency c
WHERE id in (select distinct CurrencyId from dbo.Account)

SELECT distinct c.Code
FROM dbo.Currency c
INNER JOIN dbo.Account a on a.CurrencyId = c.id


