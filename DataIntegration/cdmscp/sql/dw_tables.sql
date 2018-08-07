if exists (select object_id from sys.tables where name = 'Employee')
	drop table Employee;
go
if exists (select object_id from sys.tables where name = 'Stage_Employee')
	drop table Stage_Employee;
go

if exists (select object_id from sys.tables where name = 'SynchronizationStatus')
	drop table SynchronizationStatus;
go

create table Employee (
	EmpId varchar(10) primary key not null, 
	Name varchar(60) not null,
	FirstName varchar(60) null,
	LastName varchar(60) null,
	LastTimestamp bigint not null
);

select EmpId, Name, LastTimestamp into Stage_Employee from Employee;

create table SynchronizationStatus (
	TableName varchar(100) primary key not null,
	LastTimestamp bigint not null default(0)
);
go

insert SynchronizationStatus (TableName) values ('Employee');

select * from SynchronizationStatus s
	left outer join Employee e on e.LastTimestamp = s.LastTimestamp;

select * from Stage_Employee;
select * from Employee

