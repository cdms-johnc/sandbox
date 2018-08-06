if exists (select object_id from sys.views where name = 'vw_Employee')
	drop view vw_Employee;
go

create view vw_Employee as
select EmpId
	, Name
	, LastName
	, FirstName
	, YtdEarn
	, Zip
	, LastTimestamp
from employee;

go
select * from vw_Employee; 
              