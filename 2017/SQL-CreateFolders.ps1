
<#

Pawel Czopowik

#>

$ErrorActionPreference = 'stop'

$FoldersToCreate = "M:\Data\tempdb", "M:\Data\master", "M:\Data\msdb", "M:\Data\model", "L:\Log\tempdb", "L:\Log\master", "L:\Log\msdb", "L:\Log\model"

try
{
    foreach ($Folder in $FoldersToCreate)
    {
        if (!(Test-Path $Folder))
        {
            mkdir $Folder
        }
    }    
}
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    Write-Error "`nError when creating folders: $ErrorMessage"
    break
}
