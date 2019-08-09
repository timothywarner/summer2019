<#
How I use Devlotions Remote Desktop Manager PowerShell

Tim Warner (@TechTrainerTim)

GitHub repo: http://timw.info/summer2019
#>

### Control Plane Operations ###

# Load up the commands
Import-Module -Name RemoteDesktopManager.PowerShellModule
Update-Help -Force -ErrorAction SilentlyContinue

# Discover commands
Get-Command -Module RemoteDesktopManager.PowerShellModule

Get-Help -Name Open-RDMSession -Examples

# Select data source
$ds = Get-RDMDataSource -Name "Devolutions Online Drive"
Set-RDMCurrentDataSource -DataSource $ds

# See which RDP sessions are available
$ErrorActionPreference = 'SilentlyContinue'
$sessions = Get-RDMSession | Where-Object -FilterScript { $_.ConnectionType -eq "RDPConfigured" }
foreach ($session in $sessions) {
    Write-Host $session.Name -NoNewline
    If (New-Object System.Net.Sockets.TCPClient -ArgumentList $session.Host, 3389) { Write-Host " - RDP is open" }
    If ($? -eq $false) { Write-Host " - RDP is unavailable" }
}

# Retrieve session IDs
$ss = Get-RDMSession | Where-Object { $_.ConnectionType -eq "RDPConfigured" } | Sort-Object -Property Name
foreach ($s in $ss) {
    $s.Name
    $s.ID
}

# Connect to an active RDP session
$computerName = "vm1"
$session = New-RDMSession -Host $computerName -Type "RDPConfigured" -Name $computerName
Set-RDMSession -Session $session -Refresh
Update-RDMUI

$session | Get-Member

Get-RDMSession | Where-Object { $_.ConnectionType -eq "RDPConfigured" }
Open-RDMSession -ID $session.ID -ForceExternal

### Data Plane Operations ###

# Check agent status

# Run pipelines and script files