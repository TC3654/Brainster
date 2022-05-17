-- CHALLENGE 3

-- Using Subqueries prepare list of ATM locations (Location Name) where you will list all ATMs where there was at least 1 outflow transaction greater than 150 EUR in month  03.2019

-- To be submitted by: 23.04.2021

select * from [Location]
select * from LocationType
select * from AccountDetails

-- all outflow transactions greater than 150 EUR in month 03.2019
select *
from AccountDetails
where PurposeCode = 930
and abs(Amount) > 150
and MONTH(TransactionDate) = 3
and YEAR(TransactionDate) = 2019

-- all ATMs

select *
from dbo.Location
WHERE LocationTypeId in (select Id=4 from dbo.LocationType)

-- combine everything

select distinct (select Name from dbo.Location where LocationId = Location.Id) as LocationName
from AccountDetails
where PurposeCode = 930
and abs(Amount) > 150
and MONTH(TransactionDate) = 3
and YEAR(TransactionDate) = 2019
and LocationId in (
    select Id
    from dbo.Location
    where LocationTypeId in (
        select Id=4
        from dbo.LocationType
    )
)

-- same result without the extra subquery

select distinct (select Name from dbo.Location where LocationId = Location.Id) as LocationName
from AccountDetails
where PurposeCode = 930
and abs(Amount) > 150
and MONTH(TransactionDate) = 3
and YEAR(TransactionDate) = 2019
and LocationId in (
    select Id
    from dbo.Location
    where LocationTypeId = 4
)