if exists (select object_id from sys.tables where name = 'Employee')
	drop table Employee;
go

if exists (select object_id from sys.tables where name = 'SynchronizationStatus')
	drop table SynchronizationStatus;
go

create table Employee (
	EmpId varchar(10) primary key not null, 
	Name varchar(60) not null,
	FirstName varchar(60) null,
	LastName varchar(60) null,
	YtdEarn float not null,
	Zip varchar(10) not null,
	LastTimestamp bigint not null
);

create table SynchronizationStatus (
	TableName varchar(100) primary key not null,
	LastTimestamp bigint not null default(0)
);
go

insert SynchronizationStatus (TableName) values ('Employee');

select * from SynchronizationStatus s
	join Employee e on e.LastTimestamp = s.LastTimestamp;


