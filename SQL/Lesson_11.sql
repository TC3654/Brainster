-- LESSON 11

-- COMMON TABLE EXPRESSIONS

-- Examples

;WITH cte_name as (
select *,  ROW_NUMBER() OVER (Partition by AccountId ORDER BY Amount asc) as RnWithinAccountId
from dbo.AccountDetails
)
 , myNewTable as (
select *, NTILE(10) OVER (ORDER BY ID) as Ntale
from cte_name
where RnWithinAccountId = 1
)
select * 
from myNewTable
where ntale = 1

;WITH myCTE as
(
SELECT AccountId, amount, l.Name, row_number() OVER (Order by Amount desc) as rn
FROM dbo.AccountDetails d
INNER JOIN dbo.Location l on l.Id = d.LocationId
INNER JOIN dbo.LocationType lt on lt.id = l.LocationTypeId
WHERE lt.Name = 'Clearing House'
)
SELECT *
FROM myCTE
WHERE rn <= 5

-- extend the above query fto show top 5 transaction for a different clearing house

;WITH myCTE as
(
SELECT l.Name, AccountId, amount, row_number() OVER (partition by LocationId Order by Amount desc) as rn
FROM dbo.AccountDetails d
INNER JOIN dbo.Location l on l.Id = d.LocationId
INNER JOIN dbo.LocationType lt on lt.id = l.LocationTypeId
WHERE lt.Name = 'Clearing House'
)
SELECT *
FROM myCTE
WHERE rn <= 5

-- Prepare query that will show smallest 2 transactions from each location in February, 2019. Query should include the owner of the account as well.
-- Columns on output:
-- LocationName
-- Amount
-- Customer name (First Name and Last name in same column)

select * from AccountDetails
select * from [Location]
select * from Account
select * from Customer

;WITH myCTE as
(
SELECT d.AccountId, c.FirstName + ' ' + c.LastName as CustomerName, d.Amount, l.Name as LocationName, row_number() OVER (partition by LocationId Order by Amount) as rn, TransactionDate
FROM dbo.AccountDetails d
INNER JOIN dbo.Location l on l.Id = d.LocationId
inner join dbo.Account a on d.AccountId = a.Id
inner join dbo.Customer c on a.CustomerId = c.Id
WHERE MONTH(TransactionDate) = 2
and YEAR(TransactionDate) = 2019
)
SELECT *
FROM myCTE
WHERE rn <= 2

-- BUILT-IN FUNCTIONS

select Name from dbo.[Location]
where Name LIKE 'ATM%'

select *, REPLACE(Name, 'ATM', 'Cash Machine')
from [Location]
where LocationTypeId = 4

-- Paul's solution

update l
set l.Name =  replace(name, 'atm', 'Cash Machine')
FROM dbo.[Location] as l
WHERE LocationTypeId = 4 and LEFT(name,4) = 'atm '

-- TRY AT HOME
-- Pick one location from locationtypeID = 4

select * from [Location]
where LocationTypeId = 4

-- update the name of the location to contain the ATM in the middle (example: Vienna ATM device or Vienna ATM 5)
update [Location]
set Name = 'Graz ATM 8'
where Name = 'ATM Graz 8'

-- prepare an update that will change this record to Vienna Cash Machine device or Vienna Cash Machine 5

select *, REPLACE(Name, ' ATM ', ' Cash Machine ')
from [Location]
WHERE Name like '% ATM %'

update [Location]
set Name = REPLACE(Name, ' ATM ', ' Cash Machine ')
WHERE Name like '% ATM %'

-- then get the data back to initial state: update cash machine back to ATM
update [Location]
set Name = 'ATM Graz 8'
where Name = 'Graz Cash Machine 8'