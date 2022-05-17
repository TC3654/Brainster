-- LESSON 8

-- Final goal:
-- Calculate the total Outflow amount for all ATM’s in Vienna and Graz performed by customers born after 1905.12.01 

-- Steps:
-- Define scalar variable @DateOfBirth and assign a specific date – 1905.12.01

DECLARE @DateOfBirth date = '1905.12.01'

-- Find all Customers born after that date

-- select Id
-- from Customer
-- where DateOfBirth > @DateOfBirth

-- Store the CustomerID data in temp table (#Customers (CustomerId int))

-- CREATE table #Customers (CustomerId int)

insert into #Customers
select c.Id
from dbo.Customer as c
where c.DateOfBirth > @DateOfBirth

select * from #Customers

-- Define Table variable @Locations (LocationId int)

DECLARE @Locations table (LocationId int)

-- Table variable should have only 1 column – LocationId
-- Table variable should contain ids for all ATM’s in Vienna and Graz 

-- select * from [Location]
-- select * from LocationType

insert into @Locations
select l.Id
from dbo.[Location] as l
-- inner join dbo.LocationType as lt on L.Id = lt.Id
where l.Name like 'ATM Graz%'
or l.Name like 'ATM Vienna%'

-- select * from @Locations

-- Calculate the total Outflow amount for all locations in @Locations variable and customers stored in #Customer table

select sum(ad.Amount)
from AccountDetails as ad
inner join Account as a on ad.AccountId = a.Id
inner join #Customers as c on c.Customerid = a.CustomerId
inner join @Locations as l on ad.LocationId = l.LocationId
where PurposeCode = 930

-- SUBQUERIES - try at home from the slides

-- Get all locations that are from type ATM (join location type)

select * from dbo.Location as l
inner join LocationType as lt on l.LocationTypeId = lt.Id
where lt.Name = 'ATM'

-- Do the same with subqueries

select *
from dbo.Location
WHERE LocationTypeId in (select Id=4 from dbo.LocationType)

-- Do the same with subqueries and make it happen that the column are the same as with inner join
-- we need: Id, LocationTypeID, Name, Description, (Id, Name, Description) - LocationType

-- NOPE
select *
from dbo.Location l
WHERE EXISTS (select * from dbo.LocationType where l.LocationTypeId = Id and Id=4)

-- Darya's Solution

SELECT  *, (SELECT Id FROM dbo.LocationType WHERE dbo.LocationType.Id = LocationTypeId) as Id,
 (SELECT Name FROM dbo.LocationType WHERE dbo.LocationType.Id = LocationTypeId) as Name,
  (SELECT [Description] FROM dbo.LocationType WHERE dbo.LocationType.Id = LocationTypeId) as Description
FROM dbo.Location 
WHERE LocationTypeId = 4