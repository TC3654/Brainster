-- CHALLENGE 4

-- Prepare query with 2 most often used locations for transactions for the male customers and for the female customers.

-- Expected columns: Gender, Location, Total transactions

-- select * from Customer
-- select * from AccountDetails
-- select * from [Location]

;WITH CTE1 as
(
    select ad.LocationId, l.Name, c.Gender, count(*) as TotalTransactions
    from AccountDetails ad
    inner join Account a on ad.AccountId = a.Id
    inner join Customer c on c.Id = a.CustomerId
    inner join [Location] l on l.Id = ad.LocationId
    where YEAR(TransactionDate) = 2019
    group by c.Gender, ad.LocationId, l.Name
),
CTE2 as (
    SELECT *, ROW_NUMBER() over (partition by Gender order by TotalTransactions desc) as RowNumber
    FROM CTE1
)
select *
from CTE2
where RowNumber <= 2