-- CHALLENGE 1

--Constraints

-- 1. Add DEFAULT CONSTRAINT with value = 930 on PurposeCode column in AccountDetails table

alter TABLE AccountDetails
add CONSTRAINT DF_AccountDetails_PurposeCode
DEFAULT 930 FOR PurposeCode

-- checking if it works by inserting new data
insert into dbo.AccountDetails ([AccountId],[LocationId],[TransactionDate],[Amount])
values (302, 99, GETDATE()-4, -150)

select * from AccountDetails
order by Id desc



-- 2. Add UNIQUE CONSTRAINT on Name column in Location table

alter table [Location] with CHECK
add CONSTRAINT UQ_Location_Name UNIQUE ([Name])
-- first run throws an error: 'The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.Location' and the index name 'UQ_Location_Name'. The duplicate key value is (St.Polten branch office).'

-- let's fix this
-- check info
select * from [Location]
order by Id desc

select * from AccountDetails
where LocationId = 4

select * from AccountDetails
where LocationId = 5

-- update related table
update dbo.AccountDetails
set LocationId = 4
where LocationId = 5

-- delete duplicate value
delete from [Location]
where Id = 5

-- run unique constraint again and check if it works by adding somew info we already have in the table

insert into dbo.[Location] ([LocationTypeId],[Name])
values (6, 'Zara City mall post terminal')
-- throws and error: 'Violation of UNIQUE KEY constraint 'UQ_Location_Name'. Cannot insert duplicate key in object 'dbo.Location'. The duplicate key value is (Zara City mall post terminal).', therefore, the constraint works



-- 3. Add CHECK CONSTRAINT on Account table to prevent inserting negative values in AllowedOverdraft column

alter table Account with CHECK
add CONSTRAINT CHK_Account_AllowedOverdraft
CHECK (AllowedOverdraft>=0)

-- let's try it out
INSERT INTO dbo.Account ([AccountNumber],[CustomerId],[CurrencyId],[AllowedOverdraft],[CurrentBalance],[EmployeeID])
values ('210123456789615',301,3,-50,0,101) 
-- throws an error: 'The INSERT statement conflicted with the CHECK constraint "CHK_Account_AllowedOverdraft". The conflict occurred in database "Brainster", table "dbo.Account", column 'AllowedOverdraft'.', therefore, it works