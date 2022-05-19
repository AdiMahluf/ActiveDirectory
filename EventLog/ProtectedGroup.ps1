#check if log is enabled
$dcs = (Get-ADDomain).ReplicaDirectoryServers
write-host "[-] Checking if event log is enabled on Domain Controllers" -ForegroundColor Cyan
foreach ($DC in $dcs) {
Get-WinEvent -ComputerName $dc -listlog Microsoft-Windows-Authentication/ProtectedUserFailures-DomainController |select @{n="DCNAME";e={$dc}},IsLogFull,IsEnabled
}

#check failed authentication duo to membership in Protected Group
$dcs = (Get-ADDomain).ReplicaDirectoryServers
foreach ($DC in $dcs) {
write-host "[-] Checking events related to failed authentication duo to membership in Protected Group on $dc" -ForegroundColor Cyan
Get-WinEvent -ComputerName $dc -LogName Microsoft-Windows-Authentication/ProtectedUserFailures-DomainController |select TimeCreated,ID,leveldisplayname,message |fl #|fl *
}
