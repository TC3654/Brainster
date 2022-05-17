DROP TABLE IF EXISTS #City;
DROP TABLE IF EXISTS #nums;

CREATE TABLE #City (Name nvarchar(100))
INSERT INTO #City values ('Vienna'),('Graz'),('Linz'),('Salzburg'),('Innsbruck'),('Bregenz'),('Sankt Polten'),('Klagenfurt'),('Wels')
GO

Create table #nums (id int, idText nvarchar(100))
insert into #nums
select top 100 row_Number() OVER (Order by (select 0)) as id, cast(row_Number() OVER (Order by (select 0)) as nvarchar(100)) as idText
FROM sys.objects


delete from dbo.AccountDetails where 1=1;
delete from dbo.Account where 1=1;
delete from dbo.Location where 1=1;
delete from dbo.LocationType where 1=1;
DELETE from dbo.Customer where 1=1;
DELETE from dbo.Currency where 1=1;
delete from dbo.Employee where 1=1;
GO

------ add rest of tables
--DBCC CHECKIDENT ('Employee', RESEED, 0)
--DBCC CHECKIDENT ('LocationType', RESEED, 0)
--DBCC CHECKIDENT ('Location', RESEED, 0)
--DBCC CHECKIDENT ('Currency', RESEED, 0)
--DBCC CHECKIDENT ('AccountDetails', RESEED, 0)
--DBCC CHECKIDENT ('Account', RESEED, 0)
--DBCC CHECKIDENT ('Customer', RESEED, 0)
--GO

insert into dbo.LocationType (Name,Description)
values ('Region Branch','Regional office')
GO


insert into dbo.LocationType (Name,Description)
values ('City Branch','City branch office')
GO

insert into dbo.LocationType (Name,Description)
values ('Internet','Internet from e-bank')
GO

insert into dbo.LocationType (Name,Description)
values ('ATM','ATM cash')
GO

insert into dbo.LocationType (Name,Description)
values ('Clearing House','Clearing House')
GO

--select * from dbo.locationType

-- location
insert into dbo.Location (LocationTypeId,Name)
values (1,'Bregenz branch office'), (1,'Innsbruck branch office'), (1,'Salzburg branch office'), (1,'St.Polten branch office'), (1,'St.Polten branch office'), 
(1,'Graz branch office'),(1,'Klagenfurt branch office'),(1,'Eisenstadt branch office')
GO

insert into dbo.Location (LocationTypeId,Name)
values (2,'Leonding city branch office'), (2,'Baden bei Wien city branch office'), (2,'Wolfsberg city branch office'), (2,'Steyr city branch office')
GO

insert into dbo.Location (LocationTypeId,Name)
values (3,'E-bank'), (3,'M-bank')
GO

insert into dbo.Location (LocationTypeId,Name)
select 4 as LocationTypeId , 'ATM ' + c.Name + ' ' + n.idText
from #City c 
cross apply #nums n 
where n.id <= 10
order by c.Name

insert into dbo.Location (LocationTypeId,Name)
values (5,'Daily clearing'), (5,'Fast clearing')
GO

--select * from dbo.locationtype
--select * from Location

-- Employee

-- Employee table
declare @FirstName table (FirstName nvarchar(50))
insert into @FirstName values ('Daniel'),('Dominik'),('David'),('Gerhard'),('Bianca'),('Clara'),('Lara'),('Lena'),('Lisa'),('Josef')

declare @LastName table (LastName nvarchar(50))
insert into @LastName values ('Eder'),('Fischer'),('Schmid'),('Winkler'),('Weber'),('Maier'),('Schneider'),('Wimmer'),('Lang'),('Wolf')

insert into dbo.Employee (FirstName,LastName,DateOfBirth,Gender,HireDate,NationalIdNumber)
select f.FirstName, l.LastName,'1900.01.01' as date, case when FirstName in ('Bianca','Clara','Lara','Lena','Lisa') then 'F' else 'M' end as Gender,'2015.01.01' as HireDate,1 as IdNumber
from @FirstName f
CROSS JOIN @LastName l
GO


update e set DateOfBirth = dateadd(MM,Id,DateOfBirth),  
			 HireDate = dateadd(MM,2*Id,'1990.01.01'), 
			 NationalIdNumber =  id + cast(10000000 * rand(id*10) as int)
from dbo.Employee e
GO


-- Customer data
DECLARE @WomanName table (FirstName nvarchar(50))
declare @FirstName table (FirstName nvarchar(50))
insert into @FirstName values ('Emilia'),('Sophia'),('Emma'),('Mia'),('Lily'),('Anna'),('Victoria'),('Maria'),('Luisa'),('Clara'),('Lea'),('Monika'),('Angela'),('Tea'),('Nora')

INSERT INTO @WomanName 
select * from @FirstName
-- males
insert into @FirstName values ('Matetheo'),('Elias'),('Alexander'),('Fin'),('Julian'),('Jacob'),('Lucas'),('Teo'),('Jordan'),('Maximilian'),('Jonas'),('Oliver'),('Anton'),('Jonathan'),('Felix')

declare @LastName table (LastName nvarchar(50))
insert into @LastName values ('Gruber'),('Huber'),('Bauer'),('Wagner'),('Miller'),('Pichler'),('Moser'),('Mayer'),('Hofer'),('Berger')


insert into dbo.customer (FirstName,LastName,DateOfBirth,Gender,NationalIdNumber, isActive)
select f.FirstName, l.LastName,'1900.01.01' as date, case when FirstName in (select FirstName from @WomanName) then 'F' else 'M' end as Gender,
1 as IdNumber, 1 as isActive
from @FirstName f
CROSS JOIN @LastName l

update e set DateOfBirth = dateadd(MM,Id,DateOfBirth),  
			 NationalIdNumber =  id + cast(10000000 * rand(id*10) as int),
			 City = case when id % 6 = 0 then 'Vienna' 
						 when id % 6 = 1 then 'Graz' 
						 when id % 6 = 2 then 'Linz' 
						 when id % 6 = 3 then 'Salzburg' 
						 when id % 6 = 4 then 'Innsbruck' 
						 when id % 6 = 5 then 'Bregenz' end
from dbo.customer e
GO

-- Currency rates
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('978','Euro','EUR','European union')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('840','US Dollar','USD','UNITED STATES OF AMERICA')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('191','Kuna','HRK','CROATIA')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('807','Denar','MKD','MACEDONIA')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('752','Swedish Krona','SEK','SWEDEN')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('941','Serbian Dinar','RSD','SERBIA')
GO

-- Account

-- usd and eur accounts
insert into dbo.Account (AccountNumber,CustomerId,CurrencyId,AllowedOverdraft,CurrentBalance,EmployeeId)
select '210123456789012' as AcctNum, c.id, e.id as CurrencyId, 10000 as AllowedOverDraft, 0 as CurrentBalance, 1 AS EmployeeId
from dbo.Customer c
cross apply dbo.Currency e
where e.code in ('840','978')

update A set AccountNumber = CAST((cast(AccountNumber AS BIGINT) + id) AS nvarchar(20)) ,
AllowedOverdraft = a.AllowedOverdraft + 100*id ,
EmployeeId = (select top 1 id from dbo.Employee e where e.id%100 = a.id%100)
from dbo.Account A



-- Monthly salary
insert into dbo.AccountDetails
select a.id as AcctId, l.id as LocationId, null as EmployeeId,'2019.01.01' as TransactionDate,40000 + 25*a.id as Amount, '101' as purposeCode,'Salary inflow' as PurposeDescription
from dbo.Account a
cross apply dbo.Location l 
where l.name = 'Fast clearing'
and a.CurrencyId = 1

--(5,'Daily clearing'), (5,'Fast clearing')

-- Cash inflow transactions (USD)
insert into dbo.AccountDetails
select a.id as AcctId, l.id as LocationId, null as EmployeeId,'2019.01.01' as TransactionDate,1000 + l.Id*25 as Amount, '930' as purposeCode,'cash inflow' as PurposeDescription
from dbo.Account a
cross apply dbo.Location l 
where l.id %10 = a.id %100
and a.CurrencyId = 5

-- outflow transactions
insert into dbo.AccountDetails
select a.id as AcctId, l.id as LocationId, 
case when l.name like '%branch%' then (select top 1 id from dbo.Employee e where e.id%100 =  a.id %100) else null end as EmployeeId,
dateadd(dd,(a.id % 20 + l.id % 100),'2019.01.15')  as TransactionDate,- (972 + 13*l.Id) as Amount, '930' as purposeCode,'outflow' as PurposeDescription
from dbo.Account a
cross apply dbo.Location l 
where l.id %10 = a.id %10
and a.CurrencyId = 1


-- fine tuning of numbers
update d set Amount = Amount/10
from dbo.AccountDetails d


select * from dbo.Employee
select * from dbo.currency
select * from dbo.customer
select * from dbo.Location
select * from dbo.LocationType
select * from dbo.Account
select * from dbo.AccountDetails






