
select top 5 *
from dbo.AccountDetails a
inner join dbo.[Location] l on a.LocationId = l.LocationTypeId
order by AccountId, LocationId

select top 5 *
from dbo.AccountDetails a
inner join dbo.[Location] l on a.LocationId = l.id
inner join dbo.Employee on a.EmployeeId = e.id
order by AccountId, LocationId


select top 5 *
from dbo.AccountDetails a , dbo.[Location] l , dbo.Employee e -- , ....
where a.LocationId = l.LocationTypeId -- AND a.EmployeeId = e.id
order by AccountId, LocationId

-- challenge

-- Basic querying

select distinct City , case when city = 'Graz' then (select count(*) from dbo.Customer where city = 'Graz')
                            when city = 'Innsbruck' then (select count(*) from dbo.Customer where city = 'Innsbruck')
 else 0 end as TotalRows
from dbo.Customer


select count(*) from dbo.Customer where city = 'Bregenz'
UNION ALL
select count(*) from dbo.Customer where city = 'Graz'
UNION
select count(*) from dbo.Customer where city = 'Innsbruck'
UNION
select count(*) from dbo.Customer where city = 'Linz'

-- no group by
-- no subqueries

--
-- static
declare @SQL nvarchar(max) = ''

set @SQL = ' select distinct City , case '

-- dynamic
;with cte AS
(
SELECT DISTINCT CITY , ' when city = '''+ CITY + ''' then (select count(*) from dbo.Customer where city = ''' + CITY + ''') 
' as myCode
FROM dbo.Customer   
where city is not null                        
)
select @SQL = @SQL +  STRING_AGG(myCode , '')
from cte

set @SQL = @SQL + ' end as TotalRows from dbo.Customer ' -- static

SELECT @SQL
EXEC (@SQL)

 select distinct City , case  -- static
 when city = 'Bregenz' then (select count(*) from dbo.Customer where city = 'Bregenz')  -- loop dynamic
 when city = 'Graz' then (select count(*) from dbo.Customer where city = 'Graz')  
 when city = 'Innsbruck' then (select count(*) from dbo.Customer where city = 'Innsbruck')  
 when city = 'Linz' then (select count(*) from dbo.Customer where city = 'Linz')  
 when city = 'Salzburg' then (select count(*) from dbo.Customer where city = 'Salzburg')  
 when city = 'Vienna' then (select count(*) from dbo.Customer where city = 'Vienna') 
  end as TotalRows from dbo.Customer -- static

   