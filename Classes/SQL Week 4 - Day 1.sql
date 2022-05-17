SELECT AccountId, 
LocationId, 
TransactionDate,
Amount, 
SUM(Amount) OVER(PARTITION BY AccountId) as TotalPerAccount,
SUM(Amount) OVER() as GrandTotal
FROM dbo.AccountDetails a
ORDER BY AccountId,TransactionDate



select *, 
LAG(TransactionDate) OVER (Partition by AccountID order by TransactionDate asc) as NextRowId,
COUNT(*) OVER (PARTITION BY AccountId ORDER BY AccountId) as TotalTransactions,
COUNT(*) OVER (PARTITION BY AccountId,LocationId ORDER BY AccountId) as AccountAndLocationSet,
COUNT(*) OVER (PARTITION BY LocationId) as TotalTransactionsOnThisLocation,
SUM(Amount) OVER (PARTITION BY AccountId) as CurrentBalance
FROM dbo.AccountDetails
Order by AccountId, ID asc

-- Find total amount of outflow per location in the month 03.2019
-- List Location name next to each location Id

-- Window ranking functions

SELECT AccountId, TransactionDate, Amount,
    ROW_NUMBER() OVER(ORDER BY Amount) AS rownum,
    RANK() OVER(ORDER BY Amount) AS rnk,
    DENSE_RANK() OVER(ORDER BY Amount) AS densernk,
    NTILE(2) OVER(ORDER BY Amount) AS ntile100
FROM dbo.AccountDetails;

-- create table #temp (Id int , AccountId int ,....)

select *,  ROW_NUMBER() OVER (Partition by AccountId ORDER BY Amount asc) as RnWithinAccountId
--INTO #temp
from dbo.AccountDetails
ORDER BY AccountId, Amount

select *
from #temp
where RnWithinAccountId = 1





select top 10 *
from dbo.AccountDetails 

insert into dbo.AccountDetails values (1,106,null,getdate(),-999,101,' double trans')


select AccountId, count(*) as TotalTransactions, sum(amount) currentBalace
FROM dbo.AccountDetails
GROUP BY AccountId
Order by AccountId

-- Daria solution
-- Order all transactions from Clearing houses from highest to lowest transaction by using RowNumber function
SELECT l.Name, a.AccountId, a.Amount, ROW_NUMBER() OVER (ORDER BY a.Amount DESC) as Rn, 
    ROW_NUMBER() OVER (PARTITION BY l2.Name ORDER BY a.Amount DESC) as RnLocationName
FROM dbo.AccountDetails as a
INNER JOIN dbo.[Location] AS l ON l.id = a.LocationId
INNER JOIN dbo.LocationType as l2 On l.LocationTypeId = l2.id


-- Bojan K  7:53 PM
SELECT AccountId, TransactionDate, Amount,
ROW_NUMBER() OVER(ORDER BY ad.Amount desc) AS rownum
FROM dbo.AccountDetails as ad
WHERE ad.LocationId IN (select l.id FROM dbo.[Location] as l where l.LocationTypeId IN (SELECT lt.id FROM dbo.LocationType as lt where lt.Name like '%clearing%')) ;


-- Common table expression

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