$scriptsList = 
@(
    'C:\Validation\ProcdumpCopyTo.ps1'
    'C:\Validation\psexecvalidation.ps1'
    'C:\Validation\ProcdumDelete.ps1'
)

foreach($script in $scriptsList)
{
    Start-Process -FilePath "$PSHOME\powershell.exe" -ArgumentList "-command '& $script'" -Wait
}