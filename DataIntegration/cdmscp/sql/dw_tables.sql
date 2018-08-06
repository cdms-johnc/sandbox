if exists (select object_id from sys.tables where name = 'Employee')
	drop table Employee;
go

if exists (select object_id from sys.tables where name = 'SynchronizationStatus')
	drop table SynchronizationStatus;
go

create table Employee (
	EmpId varchar(10) primary key not null, 
	Name varchar(60) not null,
	YtdEarn float not null,
	Zip varchar(10) not null
);

create table SynchronizationStatus (
	TableName varchar(100) primary key not null,
	LastTimestamp bigint not null,
	LastDatetime smalldatetime not null default getdate()
);