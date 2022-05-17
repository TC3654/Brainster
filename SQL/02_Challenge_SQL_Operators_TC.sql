-- CHALLENGE 2

-- List all Employee first names that don’t exist as Customer first names

select FirstName from dbo.Employee
EXCEPT
select FirstName from dbo.Customer

-- List all Customer first names that don’t exist as Employee first names

select FirstName from dbo.Customer
EXCEPT
select FirstName from dbo.Employee

-- List First names that are present as Customer first name and Employee First name

select FirstName from dbo.Customer
INTERSECT
select FirstName from dbo.Employee