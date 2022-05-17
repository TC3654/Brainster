-- Tamara code

-- List all accounts in the system. Show the data for AccountNumber, CustomerName and CurrentBalance
select AccountNumber, CurrentBalance, c.FirstName+' '+c.LastName as 'Customer'
from dbo.Account as a
inner join dbo.Customer as c on a.CustomerId = c.Id
order by a.Id
-- Extend the previous query to show only data for accounts opened by employee with last name = ‘Eder’
select AccountNumber, c.FirstName+' '+c.LastName as 'Customer', CurrentBalance, e.FirstName+' '+e.LastName as 'Employee'
from dbo.Account as a
inner join dbo.Customer as c on a.CustomerId = c.Id
inner join dbo.Employee as e on a.EmployeeID = e.Id
where e.LastName = 'Eder'
order by a.Id
-- Extend the previous query to show only accounts in USD currency
select AccountNumber, c.FirstName+' '+c.LastName as 'Customer', CurrentBalance, cr.ShortName, e.FirstName+' '+e.LastName as 'Employee'
from dbo.Account as a
inner join dbo.Customer as c on a.CustomerId = c.Id
inner join dbo.Employee as e on a.EmployeeID = e.Id
inner join dbo.Currency as cr on a.CurrencyId = cr.Id
where e.LastName = 'Eder'
and cr.ShortName = 'USD'
order by a.Id
-- Find all Currencies for which there are open accounts in the system
select cr.Name
from dbo.Currency as cr
inner join dbo.Account as a on a.CurrencyId = cr.Id
group by cr.Name
-- Extend the previous query to show total number of Accounts per currency (challenge)
select cr.Name, count(cr.Id)
from dbo.Currency as cr
inner join dbo.Account as a on a.CurrencyId = cr.Id
group by cr.Name

-- Bojan code

-- Find all Currencies for which there are open accounts in the system
SELECT DISTINCT(c.ShortName) FROM dbo.Currency AS c
LEFT JOIN dbo.Account AS a ON c.Id = a.CurrencyId
WHERE AccountNumber IS NOT NULL;
SELECT * FROM dbo.Currency AS c
LEFT JOIN dbo.Account AS a ON c.Id = a.CurrencyId
WHERE a.id IS NULL;
INSERT INTO dbo.Account ([AccountNumber],[CustomerId],[CurrencyId],[AllowedOverdraft],[CurrentBalance],[EmployeeId])
VALUES (null, 1, 1, 100, 3, 2);

-- VARIABLES

DECLARE @MyName NVARCHAR(100) = 'Blagoj'

select @MyName as ColumnWithMyName

SET @MyName = 'Daniel'

select @MyName

select *
from dbo.Employee
where FirstName = @MyName

select *
from dbo.Employee
where FirstName <> @MyName

select *
from dbo.Customer
where FirstName = @MyName


-- 
declare @lastName nvarchar(100) = 'Eder'
declare @Currency nvarchar(3) = 'EUR'

select AccountNumber, c.FirstName+' '+c.LastName as 'Customer', CurrentBalance, cr.ShortName, e.FirstName+' '+e.LastName as 'Employee'
from dbo.Account as a
inner join dbo.Customer as c on a.CustomerId = c.Id
inner join dbo.Employee as e on a.EmployeeID = e.Id
inner join dbo.Currency as cr on a.CurrencyId = cr.Id
where e.LastName = @lastName
and cr.ShortName = @Currency



INSERT INTO dbo.Account ([AccountNumber],[CustomerId],[CurrencyId],[AllowedOverdraft],[CurrentBalance],[EmployeeId])
VALUES (null, 1, 1, 100, 3, 2);

-- code generator
select cast(cast(max(accountNumber) as bigint) + 2 as nvarchar(20))
from dbo.Account

GO

DECLARE @MyCustomer TABLE (FirstName nvarchar(100), LastName nvarchar(100))

select *
from @MyCustomer

insert into @MyCustomer values ('Emilia','Gruber')

select *
from @MyCustomer

select * 
from dbo.Customer as c
inner join @MyCustomer m on m.FirstName = c.FirstName and m.LastName = c.LastName
--
GO


-- example with search by city (multi choice)

DECLARE @SelectedCities TABLE (CityName nvarchar(100))

INSERT INTO @SelectedCities VALUES ('Vienna'),('Graz')


UPDATE @SelectedCities set CityName = 'Innsbruck'
where CityName = 'Graz' 

select * from @SelectedCities

SELECT *
from dbo.Customer c
inner join @SelectedCities s on s.CityName = c.City
GO

DECLARE @SelectedCities TABLE (CityName nvarchar(100));

-- 

CREATE TABLE #SelectedTables (CityName nvarchar(100))

select * from #SelectedTables

select * from dbo.Customer

insert into #SelectedTables values ('Test city')

DROP TABLE #SelectedTables





select 
*