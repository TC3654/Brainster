-- LESSON 7

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

-- comparison with left join
select cr.Name
from dbo.Currency as cr
left join dbo.Account as a on a.CurrencyId = cr.Id
group by cr.Name

-- Bojan's solution
SELECT DISTINCT(c.ShortName) FROM dbo.Currency AS c
LEFT JOIN dbo.Account AS a ON c.Id = a.CurrencyId
WHERE AccountNumber IS NOT NULL;

SELECT * FROM dbo.Currency AS c
LEFT JOIN dbo.Account AS a ON c.Id = a.CurrencyId
WHERE a.id IS NULL;

INSERT INTO dbo.Account ([AccountNumber],[CustomerId],[CurrencyId],[AllowedOverdraft],[CurrentBalance],[EmployeeId])
VALUES (null, 1, 1, 100, 3, 2);

-- Extend the previous query to show total number of Accounts per currency (challenge)

select cr.Name, count(cr.Id)
from dbo.Currency as cr
inner join dbo.Account as a on a.CurrencyId = cr.Id
group by cr.Name

-- VARIABLES

-- 3 types: scalar (atomic values - values of only one type), table (more columns and rows), temp (# pred imenom tabele in potem je temp tabela)

DECLARE @MyName NVARCHAR(100) = 'Tamara'

select @MyName as 'My Name'

set @MyName = 'Jane'

select @MyName as 'My New Name'

select *
from dbo.Employee
where FirstName = @MyName

-- Scalar variable
-- Find all customers that have Mayer as last name and are born in February any year

DECLARE @LastName NVARCHAR(50) = 'Mayer'
Declare @BirthMonth int = 2

select *
from dbo.Customer
where LastName = @LastName
and MONTH(DateOfBirth) = @BirthMonth

-- Table variable -- try at home
-- declare employees (table) and gender (scalar)

declare @MyEmployees table (NationalIdNumber NVARCHAR(15))
declare @MyGender NVARCHAR(1) = 'F'

-- insert NationalIDs
-- select * from dbo.Employee

insert into @MyEmployees values ('7137597'),('7139462'),('7141326'),('7143190'),('7145055'),('7146919'),('7148783'),('7150647')

select * from @MyEmployees


-- list all employees with NationalID and Gender
select *
from dbo.Employee as e
inner join @MyEmployees as me on me.NationalIdNumber = e.NationalIDNumber
where e.Gender = @MyGender 

-- Temp variable --  try at home
-- Same exercise but with temp table

create table #MyEmployees (NationalIdNumber NVARCHAR(15))
insert into #MyEmployees values ('7137597'),('7139462'),('7141326'),('7143190'),('7145055'),('7146919'),('7148783'),('7150647')

declare @MyGender NVARCHAR(1) = 'F'

-- Add additional variable for day of birth and do testing with it

