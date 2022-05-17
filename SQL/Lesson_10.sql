-- LESSON 10

-- WINDOW FUNCTIONS

-- example

select *, 
LAG(TransactionDate) OVER (Partition by AccountID order by TransactionDate asc) as NextRowId,
COUNT(*) OVER (PARTITION BY AccountId ORDER BY AccountId) as TotalTransactions,
COUNT(*) OVER (PARTITION BY AccountId,LocationId ORDER BY AccountId) as AccountAndLocationSet,
COUNT(*) OVER (PARTITION BY LocationId) as TotalTransactionsOnThisLocation,
SUM(Amount) OVER (PARTITION BY AccountId) as CurrentBalance
FROM dbo.AccountDetails
Order by AccountId, ID asc

-- Find total amount of outflow per location in the month 03.2019

select *,
sum(Amount) over (PARTITION by LocationId) as TotalLocationAmount
from dbo.AccountDetails
where PurposeCode = 930
and MONTH(TransactionDate) = 3
and YEAR(TransactionDate) = 2019
Order by LocationId

-- List Location name next to each location

select ad.*, l.Name,
sum(Amount) over (PARTITION by LocationId) as TotalLocationAmount
from dbo.AccountDetails ad
inner join dbo.[Location] l on l.Id = ad.LocationId
where PurposeCode = 930
and MONTH(TransactionDate) = 3
and YEAR(TransactionDate) = 2019
Order by LocationId



-- WINDOW RANKING FUNCTIONS
-- row_number() - po vrsti cifre pač glede na to kak jih orderamo (amount npr od najmanjše do največje)
-- rank() - all records with the same value have the same rank, example: 1, 2, 32...ker je tolko istih pod 2
-- dense_rank() - enako kot rank, samo da je count drugačn: 1, 2, 3 - po vrsti ne glede na to koklkokrat se ponovi 2
-- ntile(x) - splits results into x rows

-- Example:

SELECT AccountId, TransactionDate, Amount,
ROW_NUMBER() OVER(ORDER BY Amount) AS rownum,
RANK() OVER(ORDER BY Amount) AS rnk,
DENSE_RANK() OVER(ORDER BY Amount) AS densernk,
NTILE(100) OVER(ORDER BY Amount) AS ntile100
FROM dbo.AccountDetails;

-- Order all transactions from Clearing houses from highest to lowest transaction by using RowNumber function
-- Show the following data on output:
-- LocationName
-- AccountId
-- Amount
-- Rn (the ordering column)

select * from LocationType -- Clearing house Id = 5

select * from [Location]
where LocationTypeId = 5

select l.Name, ad.AccountId, Amount,
ROW_NUMBER() OVER(ORDER BY Amount) AS rownum
from AccountDetails ad
INNER join [Location] l on ad.LocationId = l.Id
where l.LocationTypeId = 5

-- Bojan's solution

SELECT AccountId, TransactionDate, Amount,
ROW_NUMBER() OVER(ORDER BY ad.Amount desc) AS rownum
FROM dbo.AccountDetails as ad
WHERE ad.LocationId IN (select l.id FROM dbo.[Location] as l where l.LocationTypeId IN (SELECT lt.id FROM dbo.LocationType as lt where lt.Name like '%clearing%')) ;

-- Darya's solution

SELECT l.Name, a.AccountId, a.Amount, ROW_NUMBER() OVER (ORDER BY a.Amount DESC) as Rn, 
ROW_NUMBER() OVER (PARTITION BY l2.Name ORDER BY a.Amount DESC) as RnLocationName
FROM dbo.AccountDetails as a
INNER JOIN dbo.[Location] AS l ON l.id = a.LocationId
INNER JOIN dbo.LocationType as l2 On l.LocationTypeId = l2.id



-- TRY AT HOME

-- balance after each transaction

-- Darya's solution
select *, 
SUM(Amount) OVER (PARTITION BY AccountId order by TransactionDate, Id) as RunningBalance
FROM dbo.AccountDetails
order by AccountId, TransactionDate, Id

-- My solution
select *, 
SUM(Amount) OVER (PARTITION BY AccountId order by TransactionDate rows unbounded preceding) as RunningBalance
FROM dbo.AccountDetails

-- Find total amount of outflow per location in the month 03.2019 and List Location name next to each location with subqueries and group by

select (select Name from dbo.Location where LocationId = Location.Id) as LocationName, sum(Amount) as TotalOutflow
from AccountDetails
where PurposeCode = 930
and MONTH(TransactionDate) = 3
and YEAR(TransactionDate) = 2019
group by LocationId

-- same exercise with inner join and group by

select l.Name, sum(ad.Amount) as TotalOutflow
from dbo.AccountDetails ad
inner join dbo.[Location] l on l.Id = ad.LocationId
where PurposeCode = 930
and MONTH(TransactionDate) = 3
and YEAR(TransactionDate) = 2019
group by l.Name