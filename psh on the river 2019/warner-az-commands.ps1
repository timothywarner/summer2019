<#
"Azure PowerShell Evolution: Get Comfortable with the New Microsoft Azure PowerShell Az Commands"

Saturday, August 10, 2019, 9:00-9:45am

timw.info/chatt2019

https://www.powershellchatt.com/schedule/

Tim Warner (@TechTrainerTim)
#>

break

# Sources of confusion
Find-Module -Name Azure, AzureRm, Az | Select-Object -Property Name, Version, PublishedDate | Sort-Object -Property PublishedDate | Format-Table -AutoSize

Find-Module -Name Az -AllVersions | Select-Object -Property Name, Version, PublishedDate | Sort-Object -Property PublishedDate -Descending
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
Find-Module -Name Az -Repository PSGallery

# Inspect Az bootstrapper
.\Az.psm1

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
Compatibility aliases: AzureRM and Az use some of the same DLLs, so their modules cannot be loaded into the same PowerShell session.
#>
Get-Alias
Enable-AzureRmAlias -Scope CurrentUser
Get-Alias -Name *azurerm* | Select-Object -Property Name, Definition | Select-Object -First 5
Disable-AzureRmAlias

# Deeper with aliases (ref: https://bartsimons.me/convert-azurerm-scripts-to-az/)
$mappings = ((Invoke-WebRequest https://raw.githubusercontent.com/Azure/azure-powershell/master/src/Accounts/Accounts/AzureRmAlias/Mappings.json -UseBasicParsing).Content | ConvertFrom-Json)

($mappings | Get-Member -MemberType NoteProperty) | ForEach-Object {
    $mappings.$($_.Name) | ForEach-Object {
        ForEach ($Mapping in ($_ | Get-Member -MemberType NoteProperty)) {
            Write-Output $_.$($Mapping.Name) "=>" $Mapping.Name
        }
    }
} | Out-File -FilePath '.\mappings.txt'

code .\mappings.txt

# Deploy a template

Set-Location -Path

New-AzResourceGroup -Name 'TestRG1' -Location 'EastUS2'
$params = @{'ResourceGroupName' = 'TestRG1';
    'TemplateFile'              = '.\storageaccount.json';
    'TemplateParameterFile'     = '.\storageaccountparameters.json';
    'Mode'                      = 'Incremental'
}
New-AzResourceGroupDeployment @params

Remove-AzResourceGroup -Name 'TestRG1' -Verbose -Force

# Refactoring an AzureRm script
code '.\Gnarly-AzureRm-Script.ps1'

# Cloud Shell / Azure CLI

Get-Command -Noun CloudDrive



# https://shell.azure.com

# Azure CLI Tools VS Code extension