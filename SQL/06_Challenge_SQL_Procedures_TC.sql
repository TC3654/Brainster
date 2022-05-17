-- CHALLENGE 6

-- Prepare new procedure that will read from the log table (related to Hands on day 2 – for procedures – slide 195)
-- Procedure name: WhoViewedTheReport
-- Procedure should show the Employee full name, Customer Full name and the datetime when the Employee opened the report
-- Procedure should have following input parameters:
-- FromDate dateime
-- ToDate datetime
-- Based on the input parameters, procedure should return only the logs from generated reports that occurred within the specific date interval on input

CREATE OR ALTER PROCEDURE dbo.WhoViewedTheReport (@DateFrom date, @DateTo date)
AS
BEGIN

select (e.FirstName + ' ' + e.LastName) as EmployeeName, (c.FirstName + ' ' + c.LastName) as CustomerName, r.DateOfRequest
from CustomerReportLogs r
inner join Employee e on e.Id = r.EmployeeID
inner join Customer c on c.Id = r.CustomerId
where DateOfRequest BETWEEN @DateFrom and @DateTo

END
go

exec dbo.WhoViewedTheReport @DateFrom = '2021.05.06', @DateTo = '2021.05.08'