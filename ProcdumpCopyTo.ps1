$VerbosePreference = 'Continue'
$source = 'C:\Validation\Procdump\'
$logfile = New-Item -Type file "C:\Validation\ProcmonCopyResults.txt"
$cred = Get-Credential trad\svc_mcafee
foreach ($computer in (Get-Content C:\Validation\computers.txt)) {
Write-Verbose "Working on $computer"
$logmessage = "Working on $computer"
Add-Content $logfile $logmessage
if (test-connection -Cn $computer -quiet)
{ Write-Verbose "-- Mapping drive"
$logmessage = "Mapping drive on $computer"
Add-Content $logfile $logmessage
New-PSDrive -name $computer -PsProvider FileSystem -root "\\$computer\C$\Windows\temp" -credential $cred
Write-Verbose "-- Starting copy"
$logmessage = "Starting copy on $computer"
Add-Content $logfile $logmessage
Copy-Item $source\* -Destination "$($computer):"
Write-Verbose "-- Copy complete for $computer; removing drive"
$logmessage = "Copy complete for $computer; removing driver"
Add-Content $logfile $logmessage
Remove-PSDrive -Name $computer
} else { Write-Verbose "Couldn't verify connection to $computer"
$logmessage = "Couldn't verify connection to $computer"
Add-Content $logfile $logmessage
}
}