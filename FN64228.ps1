#Add list of firewalls in a text file.
$fws = Get-Content ( "C:\Users\"username"\firewalls.txt")
#Add asdm username
$asdmusername = "username"
$securePwd = Read-Host "Enter password" -AsSecureString
$plainPwd =[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePwd))
foreach ($fw in $fws){
try {
#Make sure this & location is pointing to where curl.exe is located.
$get = Invoke-Command { & 'C:\Users\"username"\Documents\curl\curl.exe'-s -k "https://$asdmusername:$plainPwd@$fw/exec/show+inv" } 
$getpid = $get | select-string "PID: ASA"
if ($getpid -match "5506") {
     $getaffected = $get | select-string -pattern "VID: V03","VID: V02","VID: V01"
     Write-host " "
     write-host "ASA5506" 
     Write-host "$fw is Affected"
}
if ($getpid -match "5508") {
     $getaffected = $get | select-string -pattern "VID: V04","VID: V03","VID: V02","VID: V01"
     Write-host " "
     Write-host "ASA5508"
     Write-host "$fw is Affected"
}
if ($getpid -match "5516") {
     $getaffected = $get | select-string -pattern "VID: V04","VID: V03","VID: V02","VID: V01"
     Write-host " "
     Write-host "ASA5516"
     Write-host "$fw is Affected"
}
}catch [Exception]{ 
 Write-host "Not Alive" 
  }
}
  
