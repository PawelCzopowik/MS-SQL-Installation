# By: Pawel Czopowik
# pc2550@domain.com

# You must first run the T-SQL script to adjust the filepaths for system databases before using this script
# This script will stop SQL server, move the system database files, change startup parameters then start SQL server


Stop-Service sqlserveragent
Stop-Service MSSQLSERVER

Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\master.mdf" M:\Data\master\master.mdf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\model.mdf" M:\Data\model\model.mdf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\msdbdata.mdf" M:\Data\msdb\msdbdata.mdf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tempdb.mdf" M:\Data\tempdb\tempdb.mdf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tempdb_mssql_2.ndf" M:\Datatempdb\tempdb_mssql_2.ndf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tempdb_mssql_3.ndf" M:\Data\tempdb\tempdb_mssql_3.ndf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tempdb_mssql_4.ndf" M:\Data\tempdb\tempdb_mssql_4.ndf

Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\mastlog.ldf" L:\Log\master\mastlog.ldf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\modellog.ldf" L:\Log\model\modellog.ldf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\msdblog.ldf" L:\Log\msdb\msdblog.ldf
Move-Item "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\templog.ldf" L:\Log\tempdb\templog.ldf

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQLServer\Parameters" -Name "SQLArg0" -Value "-dM:\Data\master\master.mdf"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQLServer\Parameters" -Name "SQLArg2" -Value "-lL:\Log\master\mastlog.ldf"

Start-Service sqlserveragent
Start-Service MSSQLSERVER 
