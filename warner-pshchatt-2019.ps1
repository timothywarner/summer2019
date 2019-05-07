<#
"Get Comfortable with the New Microsoft Azure PowerShell Az Modules"
May 7, 2019
https://www.meetup.com/PowerShell_Chattanooga/events/260310459/#

Tim Warner (@TechTrainerTim)
#>

break

# Sources of confusion
Find-Module -Name Azure, AzureRm, Az | Select-Object -Property Name, Version, PublishedDate | Sort-Object -Property PublishedDate

Find-Module -Name Az -AllVersions | Select-Object -Property Name, Version, PublishedDate | Sort-Object -Property PublishedDate
<#
Requires: Az requires PowerShell v5 (not v3 anymore)

Support: AzureRm will receive bug/security fixes through December 2020

Az Releases: https://github.com/Azure/azure-powershell/releases

Migration guide for Az 2.0.0: https://github.com/Azure/azure-powershell/blob/master/documentation/migration-guides/Az.2.0.0-migration-guide.md

Migration guide for Az 1.0.0: https://docs.microsoft.com/en-us/powershell/azure/migrate-az-1.0.0?view=azps-2.0.0
#>

# Get rid of AzureRm
Get-InstalledModule -Name AzureRm -AllVersions
code .\Remove-AzureRmModules.ps1

# Install Az
Get-InstalledModule -Name Az
Find-Module -Name Az
Install-Module -Name Az -Verbose -Force -AllowClobber -WhatIf

# Authenticate
Connect-AzAccount # non-Windows systems get browser Device Code auth flow
# Alias Login-AzAccount

# Command discovery
Get-Module -ListAvailable -Name Az.* | Measure-Object

Get-Command -Module Az.* | Measure-Object | Select-Object -Property Count

# Comparison: https://justaucguy.wordpress.com/2018/11/02/azure-az-powershell-module-new/

<#
Some notable module import issues you may have:

AzureRm.Profile > Az.Accounts
AzureRm.Tags > Az.Resources
AzureRm.Consumption > Az.Billing
#>

$Source = (Get-Command | Where-Object { $_.Source -like 'az*' })
$Source | Sort-Object Source -unique
Foreach ($s in $Source) {
    $Name = $s.Source
    Write-host "Cmdlets available for $Name - " -ForegroundColor White -NoNewLine
    $Number = (Get-Command | Where-Object { $_.Source -eq $Name }).Count
    Write-host "$Number" -ForegroundColor Green
}

# Enumerate VMs
Get-AzVm -ResourceGroupName 'contoso' # -Name 'vm2'

<#
AzureRM and Az use some of the same DLLs, so their modules cannot be loaded into the same PowerShell session.
#>
Get-Alias
Enable-AzureRmAlias -Scope CurrentUser
Disable-AzureRmAlias

# Deploy a template
New-AzResourceGroup -Name 'TestRG1' -Location 'EastUS2'
$params = @{'ResourceGroupName' = 'TestRG1';
    'TemplateFile'              = '.\storageaccount.json';
    'TemplateParameterFile'     = '.\storageaccountparameters.json';
    'Mode'                      = 'Incremental'
}
New-AzResourceGroupDeployment @params

# Refactoring an AzureRm script
code 'E:\summer2019\Gnarly-AzureRm-Script.ps1'

