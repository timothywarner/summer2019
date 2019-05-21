$fName = 'joe'
clear-host
if ($fName -eq 'Tim') {
    Write-Output 'Your name is tim'
}
else {
    Write-Output "Your name isn't tim"
}
Get-Service -