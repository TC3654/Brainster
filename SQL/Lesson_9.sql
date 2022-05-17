-- LESSON 9

-- DATA GROUPING AND COMPUTING AGGREGATES

-- Find the smallest transaction in each Location

select * from [Location]
SELECT * FROM AccountDetails

-- Output should contain LocationId and Amount

select LocationId, MIN(abs(Amount)) as MinimumAmount
from AccountDetails
group by LocationId
order by MIN(abs(Amount))

-- Extend the Output to contain LocationId, Location Name, and Amount

select ad.LocationId, l.Name, min(abs(Amount)) as MinimumAmount
from AccountDetails as ad
INNER join dbo.[Location] as l on ad.LocationId = l.Id
group by LocationId, Name
order by MIN(abs(Amount))



-- Find the smallest transaction in each Month and Year

SELECT * FROM AccountDetails

-- Output should contain Month name, Year and Amount

select YEAR(TransactionDate) as TransactionYear, datename(month, TransactionDate) as TransactionMonth, min(abs(Amount)) as MinimumAmount
from AccountDetails
group by YEAR(TransactionDate), datename(month, TransactionDate)
order by min(abs(Amount))

-- group solution

select Datename( MONTH, TransactionDate) as MonthName, Year(TransactionDate) as YearName, Min(abs(Amount)) as SmallestTransaction
from [dbo].[AccountDetails] ad
--inner join dbo.[Location] l on l.Id =  ad.LocationId
Group By MONTH(TransactionDate), Datename( MONTH, TransactionDate) , Year(TransactionDate)
Order by MONTH(TransactionDate), Year(TransactionDate)

-- Find the biggest outflow per ATM machine, for the first 3 months of 2019

select * from [Location]
SELECT * FROM AccountDetails
Select * from LocationType

select ad.LocationId, l.Name, max(abs(Amount)) as MaximumAmount --, month(TransactionDate) as TransactionMonth
from AccountDetails as ad
INNER join dbo.[Location] as l on ad.LocationId = l.Id
inner join dbo.LocationType as lt on lt.Id = l.LocationTypeId
where lt.Id=4
and ad.PurposeCode = 930
and Year(TransactionDate) = 2019
and month(TransactionDate) in (1,2,3)
group by LocationId, l.Name
order by LocationId, MAX(abs(Amount))

-- checking if everything works
select *
from AccountDetails
where LocationId = 15

UPDATE AccountDetails
set Amount = -135
where Id = 982