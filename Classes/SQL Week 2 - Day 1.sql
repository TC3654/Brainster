ALTER TABLE [dbo].[Account]  WITH CHECK 
ADD  CONSTRAINT [FK_Account_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([ID])
GO


-- BROWSE THE DATA (Account table)
select * from dbo.Account
where id = 10

SELECT *
FROM dbo.Customer
where id = 10

SELECT *
from dbo.Currency 
where Id = 1

select *
from dbo.Employee 
where id = 10


-- AccountDetails

select *
from dbo.AccountDetails
where AccountId = 1

-- Workshop - insert data

--Insert new Customer in the system

select * from dbo.Customer

INSERT INTO dbo.Customer (FirstName, LastName, Gender, NationalIdNumber,DateOfBirth,isActive)
VALUES ('Blagoj','Kostovski','M','1234335234','1984.07.24',1)

--Insert new Employee in the system. Use your friend name
INSERT INTO dbo.Employee ([FirstName],[LastName],[NationalIDNumber],[JobTitle],[DateOfBirth],[MaritalStatus],[Gender],[HireDate])
VALUES  (...)

--Insert 2 accounts for the new customer with the new Employee (EUR, USD) 
--Insert new location type in the database (Terminal)
--Insert new location from type Terminal (e.g. Zara City mall post terminal)
--Insert 1 transaction for each account we created in bullet 3 (income)
--Insert 2 transactions for each account (outcome) as the transactions were performed from the Zara City Mall post terminal
--Change the Allowed overdraft on EUR account to be 10.000
