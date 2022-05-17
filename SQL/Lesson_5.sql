-- LESSON 5

-- Workshop - BASIC QUERYING

-- List all Customers with FirstName = ‘Mia’

SELECT * from dbo.Customer
where FirstName = 'Mia'

-- List all Customers with FirstName = ‘Mia’ and LastName starting with letter G

SELECT * from dbo.Customer
where FirstName = 'Mia'
and LastName like 'G%'

-- Order the results by the LastName

SELECT * from dbo.Customer
where FirstName = 'Mia'
order by LastName ASC

-- Provide information about the total number of Customers with FirstName = ‘Mia’ OR LastName starting with G;

SELECT count(*) from dbo.Customer
where FirstName = 'Mia'
or LastName like 'G%'

-- List all Customers that are born in February (any year)

SELECT * from dbo.Customer
where month(DateOfBirth) = 2

-- List all Customers that are born in February (any year) or their last name starts with G

SELECT * from dbo.Customer
where month(DateOfBirth) = 2
or LastName like 'G%'

-- Provide total number of Female customers from Vienna

SELECT count(*) from dbo.Customer
where Gender = 'F'
and City = 'Vienna'

-- Provide total number of customers born in Odd months in any year

SELECT count(*) from dbo.Customer
where month(DateOfBirth)%2 = 1

-- JOINS

-- Inner joins (only info that is found in both tables)

-- Outer joins: left (all records from the left table), right (all records in the right table), full (all the records in both tables)

-- Cross join (combines all records from left table with all records from right table) - this was used to create dummy data

-- HOMEWORK

-- count customers from each city

SELECT count(*), City from dbo.Customer
group by City

-- count male and female for each city

SELECT count(*), City, Gender from dbo.Customer
group by City, Gender

-- list only cities with more than 25 females

SELECT count(*), Gender, City from dbo.Customer
where Gender='F'
group by City, Gender
having count(*)>25



-- test joins with 2 different tables - AccountDetails and Employee

-- Inner join

select * from dbo.AccountDetails as d
inner join dbo.Employee as e on d.EmployeeId = e.Id
order by e.Id

-- Left join

select * from dbo.AccountDetails as d
left join dbo.Employee as e on d.EmployeeId = e.Id
order by e.Id

-- right join

select * from dbo.AccountDetails as d
RIGHT join dbo.Employee as e on d.EmployeeId = e.Id
order by e.Id

-- full join

select * from dbo.AccountDetails as d
FULL join dbo.Employee as e on d.EmployeeId = e.Id
order by e.Id

-- cross join

select * from dbo.AccountDetails as d
cross join dbo.Employee as e
order by e.Id