$VerbosePreference = 'Continue'
$logfile = New-Item -Type file "C:\Validation\ProcmonDeleteResults.txt"
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
Write-Verbose "-- Starting Delete"
$logmessage = "Starting delete on $computer"
Add-Content $logfile $logmessage
Remove-Item \\$computer\C$\Windows\temp\procdump* -force
Remove-Item \\$computer\C$\Windows\temp\eula.txt -force
Write-Verbose "-- Delete complete for $computer; removing drive"
$logmessage = "Delete complete for $computer; removing driver"
Add-Content $logfile $logmessage
Remove-PSDrive -Name $computer
} else { Write-Verbose "Couldn't verify connection to $computer"
$logmessage = "Couldn't verify connection to $computer"
Add-Content $logfile $logmessage
}
}