if exists (select object_id from sys.views where name = 'vw_Employee')
	drop view vw_Employee;
go

create view vw_Employee as
select EmpId
	, Name
	, left(Name, charindex('~', Name) - 1) as LastName
	, right(Name, (len(Name) - charindex('~', Name))) as FirstName
	, YtdEarn
	, Zip
from employee;

go
select * from vw_Employee; 
select zip, count(zip) from vw_employee group by zip;
              