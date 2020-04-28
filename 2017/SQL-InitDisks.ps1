<#
Pawel Czopowik
12/1/2017

This scrip will initalize new disks in a VM for SQL Server. This script is dumb meaning it does not check things.
It relies on a new VM setup where the new disks besides the OS disk will be numbered 1,2,3:

1 = data
2 = log
3 = swap

Good enough for now.
#>

#$disksToInitialize = Get-Disk | Where-Object {$_.OperationalStatus -eq "Offline"}


## This prevents popups to format disks ###
Stop-Service -Name ShellHWDetection

set-disk -Number 1 -IsOffline $false
set-disk -Number 2 -IsOffline $false
set-disk -Number 3 -IsOffline $false

Initialize-Disk -Number 1 -PartitionStyle GPT
Initialize-Disk -Number 2 -PartitionStyle GPT
Initialize-Disk -Number 3 -PartitionStyle GPT

New-Partition -DiskNumber 1 -UseMaximumSize -DriveLetter "M"
New-Partition -DiskNumber 2 -UseMaximumSize -DriveLetter "L"
New-Partition -DiskNumber 3 -UseMaximumSize -DriveLetter "S"

Format-Volume -DriveLetter 'm' -FileSystem NTFS -NewFileSystemLabel "Data"
Format-Volume -DriveLetter 'l' -FileSystem NTFS -NewFileSystemLabel "Log"
Format-Volume -DriveLetter 's' -FileSystem NTFS -NewFileSystemLabel "Swap"

Start-Service -Name ShellHWDetection