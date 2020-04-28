USE [master]
GO

alter database [tempdb] modify file ( name = tempdev, filename = 'M:\Data\tempdb\tempdb.mdf')
alter database [tempdb] modify file ( name = temp2, filename = 'M:\Data\tempdb\tempdb_mssql_2.ndf')
alter database [tempdb] modify file ( name = temp3, filename = 'M:\Data\tempdb\tempdb_mssql_3.ndf')
alter database [tempdb] modify file ( name = temp4, filename = 'M:\Data\tempdb\tempdb_mssql_4.ndf')

alter database [tempdb] modify file ( name = templog, filename = 'L:\Log\tempdb\templog.ldf')

alter database [model] modify file ( name = modeldev, filename = 'M:\Data\model\model.mdf')
alter database [model] modify file ( name = modellog, filename = 'L:\Log\model\modellog.ldf')

alter database [msdb] modify file ( NAME = N'MSDBData', filename = 'M:\Data\msdb\MSDBData.mdf')
alter database [msdb] modify file ( NAME = N'MSDBLog', filename = 'L:\Log\msdb\MSDBLog.ldf')

alter database [master] modify file ( name = master, filename = 'M:\Data\master\master.mdf')
alter database [master] modify file ( name = mastlog, filename = 'L:\Log\master\mastlog.ldf')
GO