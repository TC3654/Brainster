-- LESSON 6

-- list all accounts in the system, show data for AccountNumber, CustomerName, and CurrentBalance

select AccountNumber, CurrentBalance, FirstName, LastName from dbo.Account as a
left join dbo.Customer as c on a.CustomerId = c.Id
order by a.Id

-- Extend previous query to show also CurrencyName

select AccountNumber, CurrentBalance, Name, FirstName, LastName from dbo.Account as a
left join dbo.Customer as c on a.CustomerId = c.Id
left join dbo.Currency as cr on a.CurrencyId = cr.Id
order by a.Id

-- CTRL + ? = comment -> good to know
-- default join is inner join - so if you write just join without inner, left or right, it will use inner join

-- Extend the previous query to show First Name , Last name and Hire date of employee that opened the account

select AccountNumber, c.FirstName+' '+c.LastName as 'Customer', CurrentBalance, Name, e.FirstName+' '+e.LastName as 'Employee', e.HireDate
-- can also use concat
-- select AccountNumber, concat(c.FirstName, ' ', c.LastName) as 'Customer', CurrentBalance, Name, concat(e.FirstName, ' ', e.LastName) as 'Employee', e.HireDate
from dbo.Account as a
inner join dbo.Customer as c on a.CustomerId = c.Id
inner join dbo.Currency as cr on a.CurrencyId = cr.Id
inner join dbo.Employee as e on a.EmployeeID = e.Id
order by a.Id

-- Design query that will list Customer First and Last Name, accountNumber, Current account balance and Currency

select c.FirstName+' '+c.LastName as 'Customer', AccountNumber, CurrentBalance, Name
from dbo.Account as a
inner join dbo.Customer as c on a.CustomerId = c.Id
inner join dbo.Currency as cr on a.CurrencyId = cr.Id
order by a.Id

-- insert 1 new customer without any accounts

INSERT INTO dbo.Customer (FirstName, LastName, Gender, NationalIdNumber,DateOfBirth,isActive)
VALUES ('Tamara','Curk','F','123456789','1990.01.01',1)

select * from dbo.Customer
order by id desc

-- try inner and left join with both option - 1st Account, 2nd Customer, and then the other way around, where statement to filter out the new customer
-- compare the differences

select * from dbo.Account as a
inner join dbo.Customer as c on a.CustomerId = c.Id
where c.Id = 302

select * from dbo.Customer as c
inner join dbo.Account as a on a.CustomerId = c.Id
where c.Id = 302

select * from dbo.Account as a
left join dbo.Customer as c on a.CustomerId = c.Id
where c.Id = 302

select * from dbo.Customer as c
left join dbo.Account as a on a.CustomerId = c.Id
where c.Id = 302
-- the only query yielding results

-- COMBINING DATA SETS

-- UNION - duplicates are removed - new table is organized by a column in the new table; UNION ALL - contains duplicates - order: table 1 then adds table 2

-- INTERSECT - crosssection of both tables

-- EXCEPT - will take everything from table one that is not also in the table two

-- List all Employee first names
-- Remove duplicate first names
select FirstName from dbo.Employee
UNION
select FirstName from dbo.Employee

-- List all Employee first names and Customer first names in single resultset
-- Remove duplicate first names on previous list
select FirstName from dbo.Employee
UNION
select FirstName from dbo.Customer