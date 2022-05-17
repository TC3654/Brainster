-- week 3 day 3

select top 12 * 
from dbo.AccountDetails
order by AccountId

-- basic grouping query
select AccountId, count(*) as TotalTransactions, sum(Amount) as TotalAmount, Min(abs(Amount)) as SmollestTransaction
from dbo.AccountDetails
GROUP BY AccountId
ORDER BY AccountId

select  LocationId, count(*) as TotalTransactions, sum(Amount) as TotalAmount, Min(abs(Amount)) as SmollestTransaction
from dbo.AccountDetails
group by LocationId

-- two columns
select AccountId, LocationId, count(*) as TotalTransactions, sum(Amount) as TotalAmount, Min(abs(Amount)) as SmollestTransaction
from dbo.AccountDetails
GROUP BY AccountId, LocationId
ORDER BY AccountId

-- two columns
select AccountId, LocationId, count(*) as TotalTransactions, sum(Amount) as TotalAmount, Min(abs(Amount)) as SmollestTransaction
from dbo.AccountDetails
GROUP BY LocationId, AccountId
ORDER BY AccountId



select *
from dbo.AccountDetails
where AccountId = 1
order by AccountId, TransactionDate

select AccountId, MONTH(TransactionDate), count(*) as TotalTransactions, sum(Amount) as CurrentBalanceWithinMonth, sum(abs(Amount)) as TotalTransactionAmount,
 Min(abs(Amount)) as SmollestTransaction
from dbo.AccountDetails
WHERE AccountId = 1
GROUP BY AccountId, MONTH(TransactionDate)
HAVING count(*) = 4
order by AccountId,  MONTH(TransactionDate)

 -- Yunus code
 -- •Find the smallest transaction in each Location
-- •Output should contain LocationId and Amount
SELECT loc.Name, MIN(ABS(Amount)) as MinimumAmount
FROM AccountDetails act
INNER JOIN Location loc ON loc.Id = act.LocationId
GROUP BY loc.Name, act.LocationId
ORDER BY loc.Name

