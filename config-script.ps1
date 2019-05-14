Set-Service -Name Spooler -StartupType Disabled

Get-Service -Name Spooler

Register-PackageSource -Name chocolatey -Provider PSModule -Trusted -Location http://chocolatey.org/api/v2/

Install-Module -Name GetUptime -Force -AllowClobber

Get-Uptime

$Path = $env:TEMP; $Installer = 'chrome_installer.exe'; Invoke-WebRequest -Uri 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args '/silent /install' -Verb RunAs -Wait; Remove-Item -Path $Path\$Installer


