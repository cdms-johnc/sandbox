if exists (select object_id from sys.procedures where name = 'p_EmployeePostProcessing')
	drop proc p_EmployeePostProcessing;
go

create proc p_EmployeePostProcessing
as

--UPDATE EXISTING ROWS
update Employee 
set Employee.Name = s.Name, Employee.LastTimestamp = s.LastTimestamp
from Employee e
	join Stage_Employee s on s.EmpId = e.EmpId

--INSERT NEW ROWS
declare @insertRows table (EmpId varchar(10) primary key not null, LastTimestamp bigint not null);

insert @insertRows
select distinct se.EmpId, se.LastTimestamp
from Stage_Employee se
	left outer join Employee e on e.EmpId = se.EmpId
where e.EmpId is null;

insert Employee (EmpId, Name, LastTimestamp)
	select se.EmpId
		, se.Name
		, se.LastTimestamp
	from Stage_Employee se join @insertRows i on i.EmpId = se.EmpId;

update Employee set 
	Employee.LastName = right(e.Name, (len(e.Name) - charindex('~', e.Name))),
	Employee.FirstName = left(e.Name, charindex('~', e.Name) - 1)
from Employee e
	join Stage_Employee s on s.EmpId = e.EmpId

--select 'Insert' as Operation, * from @insertRows;
--select 'Update' as Operation, * from @updateRows;

--update Stage_Employee set 
--	LastName = left(Name, charindex('~', Name) - 1), 
--	FirstName = right(Name, (len(Name) - charindex('~', Name)));

go

--select * from SynchronizationStatus s
--	left outer join Employee e on e.LastTimestamp = s.LastTimestamp;

--select * from Stage_Employee;

--exec p_EmployeePostProcessing