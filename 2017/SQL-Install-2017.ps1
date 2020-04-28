<#
Pawel Czopowik
12/1/2017

Script that configures SQL Server 2017 according to xxx standards.
Idea is to link all the PS and T-SQL scripts into one script using SQLPS commands.
Use error handling.

New outline:

1. Add Veaeam account to local admin for sql backups.
2. Init disks
3. Install SQL
5. Config
    1. dbmail
    2. dboperators
    3. SQL Agent mail
#>

Add-LocalGroupMember -Group "Administrators" -Member "DOMAIN\veeamSQLbackup"

Function Get-FileName($initialDirectory)
{   
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "All files (*.ini)| *.ini"
 $OpenFileDialog.Title = "######  Select the SQL Configuration file to install  ######"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} #end function Get-FileName

$ImportFilePath = Get-FileName -initialDirectory (Get-Item -Path ".\").FullName


#define arguments for sql install (setup.exe) - this is where you can specify a different config file.
#$SQLArguments = "/Configurationfile=`"$PSScriptRoot\SQL 2017 DBE-IS basic config.ini`""

$SQLArguments = "/Configurationfile=`"$ImportFilePath`""


Write-Host "DANGER: the following will format drives M,L and S!!! This is intended for newly built servers. Only proceed if you fully understand what this script does" -ForegroundColor Red
$proceed = Read-Host "Do you want to proceed (Yes will format, No will continue assuming disks are provisioned? (y/n)"

if ($proceed -eq "y")
{
    #Online, initialize, format, letter and name drives M, L and S
    &$PSScriptRoot"\SQL-InitDisks.ps1"
}


#Create subfolders in M and L drives for system DB's
#&$PSScriptRoot"\SQL-CreateFolders.ps1"

#Install SQL Server using config file defined above
Start-Process "E:\setup.exe" -ArgumentList $SQLArguments -wait
sleep 2 #for output
write-host "SQL Installation Complete!"

#Append path for sql modules after new install and import module
$env:PSModulePath = $env:PSModulePath + ";C:\Program Files (x86)\Microsoft SQL Server\140\Tools\PowerShell\Modules"
Import-module sqlps


# This does not seem to be neccessary!! since we already defaulted to these locations.
#Invoke-Sqlcmd -InputFile $PSScriptRoot"\SQL-ConfigEmailSQLAgent.sql"
#&$PSScriptRoot"\SQL-MoveSysDatabases-v14(2017).ps1"

Invoke-Sqlcmd -InputFile $PSScriptRoot"\SQL-ConfigDBMail.sql"
Invoke-Sqlcmd -InputFile $PSScriptRoot"\SQL-CreateOperators.sql"
Invoke-Sqlcmd -InputFile $PSScriptRoot"\SQL-ConfigEmailSQLAgent.sql"
sleep 2

write-host "Script complete"