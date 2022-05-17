--LESSON 2

--default constraint
alter TABLE Employee
add CONSTRAINT DF_Employee_JobTitle -- better to name it constraintType_table_column
DEFAULT 'Officer' FOR JobTitle

--update all z job title

update e set JobTitle='Teacher'
from Employee as e
where JobTitle='Officer'

alter TABLE Employee
add CONSTRAINT Gender
DEFAULT 'F' FOR Gender

--you can also output info at the same time
INSERT INTO dbo.Employee (FirstName,LastName, DateOfBirth)
OUTPUT inserted.*
SELECT 'Tamara','Curk','1990.01.01'

-- GO used if you want to separate 2 modifying statements (DDL - does not change data, changes organization)

-- Check constraint

alter table Employee with CHECK
add CONSTRAINT CHK_Employee_HireDate
CHECK (HireDate>='2000.01.01')

insert into Employee (FirstName,LastName,HireDate)
VALUES ('Tamara','Curk','2015.01.01')

select *
from Employee

alter table Employee with CHECK
add CONSTRAINT CHK_Employee_Gender
CHECK (Gender IN ('M','F'))

insert into Employee (FirstName,LastName,Gender)
VALUES ('John','Doe','Alien')

-- Unique constraint

alter table Employee with CHECK
add CONSTRAINT UQ_Employee_ID UNIQUE (ID)

alter table Employee with CHECK
add CONSTRAINT UQ_Employee_NationalID UNIQUE (NationalIDNumber)

-- national ID number ni unique, ker je vse blo null - bi mogli naredit zahtevo, da je ta not null
update e set e.NationalIDNumber = '0000' + CAST(ID as nvarchar(10))
from Employee as e
where NationalIDNumber is null

insert into Employee (FirstName,LastName)
VALUES ('John','Doe')

select *
from Employee

-- TRY AT HOME

-- try to solve: 2 default constraints - DoB, hire date (current date)

alter TABLE Employee
add CONSTRAINT DF_Employee_DoB 
DEFAULT '1990.01.01' FOR DateOfBirth

alter TABLE Employee
add CONSTRAINT DF_Employee_HireDate
DEFAULT GETDATE() FOR HireDate -- getdate() gets both date and time

-- bonus: drop DoB constraint, new constraint DoB today minus 30 years

alter TABLE Employee
drop CONSTRAINT DF_Employee_DoB

alter TABLE Employee
add CONSTRAINT DF_Employee_DoB
DEFAULT DateAdd(yy, -30, GetDate()) FOR DateOfBirth

-- try this: insert FirstName, LastName and JobTitile --> Update info to fill gender column --> delete inserted record

alter TABLE Employee
drop CONSTRAINT DF_Employee_Gender

alter TABLE Employee
drop CONSTRAINT UQ_Employee_NationalID

insert into Employee (FirstName,LastName,JobTitle)
VALUES ('Tamara','Curk','Senior Support Agent')

select *
from Employee

update e set Gender='F'
from Employee as e
where JobTitle = 'Senior Support Agent'

DELETE from Employee
WHERE JobTitle = 'Senior Support Agent'

-- add default constraint to be 'M' as Gender

alter TABLE Employee
add CONSTRAINT DF_Employee_Gender
DEFAULT 'M' FOR Gender

-- pre-set number of digits za National ID - probaj najt solution, da bo skoz a fixed number of 13 digits

SELECT REPLICATE('0',(13-LEN(CAST(ID as nvarchar(10))))) + CAST(ID as nvarchar(10))
from Employee