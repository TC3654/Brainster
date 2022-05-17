-- SQL Week 2 - day2

--List all Customers with FirstName = ‘Mia’

SELECT *
FROM dbo.Customer
WHERE FirstNAme = 'Mia'

SELECT *
FROM dbo.Customer
WHERE FirstNAme like 'Mia%'

-- List all Customers with FirstName = ‘Mia’ and LastName starting with letter G
/*
List all Customers with FirstName = ‘Mia’  and Order the results by the LastName
Provide information about the total number of Customers with FirstName = ‘Mia’ OR LastName starting with G;
List all Customers that are born in February (any year)
List all Customers that are born in February (any year) or their last name starts with G
Provide total number of Female customers from Vienna
Provide total number of customers born in Odd months in any year
*/

-- JOINS

CREATE TABLE dbo.TableA (idA int)
GO
CREATE TABLE dbo.TableB (idB int)
GO

INSERT INTO dbo.TableA values (1),(2),(5),(6),(7)
INSERT INTO dbo.TableB values (2),(3),(7)

select *
from dbo.TableA

select * 
from dbo.TableB

select *
from dbo.TableA as a
inner join dbo.TableB as b on a.idA = b.idB

-- Account and currency

select * from dbo.Account
select * from dbo.Currency

-- 
select *
from dbo.Account as a
inner join dbo.Currency as c on a.CurrencyId = c.Id

select *
from dbo.Currency as c
inner join dbo.Account as a on a.CurrencyId = c.Id
order by c.Id


select *
from dbo.Account
where CurrencyId = 6

-- LEFT JOIN
select *
from dbo.TableA

select * 
from dbo.TableB

select *
from dbo.TableA as a
LEFT join dbo.TableB as b on a.idA = b.idB

insert into dbo.TableA values (11) 
insert into dbo.Tableb values (11),(11) 

delete from dbo.TableB where idB = 11
delete from dbo.TableA where ida = 11

-- show me just currencies for which we don't have open accounts
select * --c.Name
from dbo.Currency as c
LEFT join dbo.Account as a on a.CurrencyId != c.Id
--WHERE a.Id is NULL
order by c.Id

select *
from dbo.Account as a 
LEFT join dbo.Currency as c on a.CurrencyId = c.Id
order by c.Id

-- RIGH JOIN
select *
from dbo.TableA

select * 
from dbo.TableB

select *
from dbo.TableA as a
LEFT join dbo.TableB as b on a.idA = b.idB

select *
from dbo.TableA as a
RIGHT join dbo.TableB as b on a.idA = b.idB

select *
from dbo.TableB as b 
LEFT join dbo.TableA as a on a.idA = b.idB

-- FULL Join
select *
from dbo.TableA

select * 
from dbo.TableB

select *
from dbo.TableB as b 
FULL join dbo.TableA as a on a.idA = b.idB

-- CROSS JOIN
select *
from dbo.TableB as b 
CROSS join dbo.TableA a