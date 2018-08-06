if exists (select object_id from sys.procedures where name = 'p_EmployeePostProcessing')
	drop proc p_EmployeePostProcessing;
go

create proc p_EmployeePostProcessing
as

update Employee 
	set LastName = left(Name, charindex('~', Name) - 1)
	, FirstName = right(Name, (len(Name) - charindex('~', Name)))
go

