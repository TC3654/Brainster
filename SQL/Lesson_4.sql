-- LESSON 4

-- Foreign key - EmployeeId

ALTER TABLE [dbo].[Account] WITH CHECK
ADD CONSTRAINT [FK_Account_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])

-- FK - CurrencyId

ALTER TABLE [dbo].[Account] WITH CHECK
ADD CONSTRAINT [FK_Account_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([Id])

-- we added the rest of the FKs by using Blagoj's script; same for inserting dummy data

-- browse the data - Account details

select * from AccountDetails where id=33

select * from Account
where ID=33

select * from Customer
where id=33

select * from Currency
where id=1

select * from [Location]
where id=106

select * from LocationType
where id=5

-- Workshop - homework

-- Data types and data manipulation – Account tables

-- Insert new Customer in the system

select * from dbo.Customer

INSERT INTO dbo.Customer (FirstName, LastName, Gender, NationalIdNumber,DateOfBirth,isActive)
VALUES ('Tamara','Curk','F','123456789','1990.01.01',1)

-- Insert new Employee in the system. Use your friend name

select * from Employee

INSERT INTO dbo.Employee ([FirstName],[LastName],[NationalIDNumber],[DateOfBirth],[Gender],[HireDate])
VALUES  ('Jane', 'Doe', '987654321', '1990.02.02', 'F', '2020-10-15')

-- Insert 2 accounts for the new customer with the new Employee (EUR, USD) 

select * from Account
select * from Currency

INSERT INTO dbo.Account ([AccountNumber],[CustomerId],[CurrencyId],[AllowedOverdraft],[CurrentBalance],[EmployeeID])
values ('210123456789613',301,1,0,0,101) -- EUR

INSERT INTO dbo.Account ([AccountNumber],[CustomerId],[CurrencyId],[AllowedOverdraft],[CurrentBalance],[EmployeeID])
values ('210123456789614',301,2,0,0,101) -- USD

-- Insert new location type in the database (Terminal)

select * from [dbo].[LocationType]

INSERT into dbo.LocationType ([Name],[Description])
values ('Terminal', 'Terminal')

-- Insert new location from type Terminal (e.g. Zara City mall post terminal)

select * from [Location]

insert into dbo.[Location] ([LocationTypeId],[Name])
values (6, 'Zara City mall post terminal')

-- Insert 1 transaction for each account we created in bullet 3 (income)

select * from AccountDetails

insert into dbo.AccountDetails ([AccountId],[LocationId],[TransactionDate],[Amount],[PurposeCode],[PurposeDescription])
values (601, 106, GETDATE()-5, 2000, 101, 'Salary inflow') -- EUR

insert into dbo.AccountDetails ([AccountId],[LocationId],[TransactionDate],[Amount],[PurposeCode],[PurposeDescription])
values (602, 106, GETDATE()-3, 3000, 101, 'Salary inflow') -- USD

-- Insert 2 transactions for each account (outcome) as the transactions were performed from the Zara City Mall post terminal

select * from AccountDetails

--EUR 
insert into dbo.AccountDetails ([AccountId],[LocationId],[TransactionDate],[Amount],[PurposeCode],[PurposeDescription])
values (601, 108, GETDATE()-1, -150, 930, 'outflow')

insert into dbo.AccountDetails ([AccountId],[LocationId],[TransactionDate],[Amount],[PurposeCode],[PurposeDescription])
values (601, 108, GETDATE(), -50, 930, 'outflow')

-- USD
insert into dbo.AccountDetails ([AccountId],[LocationId],[TransactionDate],[Amount],[PurposeCode],[PurposeDescription])
values (602, 108, GETDATE()-1, -300, 930, 'outflow')

insert into dbo.AccountDetails ([AccountId],[LocationId],[TransactionDate],[Amount],[PurposeCode],[PurposeDescription])
values (602, 108, GETDATE(), -115, 930, 'outflow')

-- Change the Allowed overdraft on EUR account to be 10.000

select * from Account

-- option 1

update dbo.Account
set AllowedOverdraft = 10000
where Id = 601

-- option 2

update a set a.AllowedOverdraft = 20000
from dbo.Account as a
where Id = 601