<#
┌──────────────────────────────────────────────────────────────────────┐
│ POWERSHELL PRO TOOLS REVIEW: RTP PowerShell User Group               │
├──────────────────────────────────────────────────────────────────────┤
│   DATE        : June 5, 2019                                         │
│   AUTHOR      : Tim Warner (@TechTrainerTim)                         │
│   DESCRIPTION : http://timw.info/psp                                 │
│   DEMO FILE   : http://timw.info/summer2019                          │
└──────────────────────────────────────────────────────────────────────┘
#>

# Product info
https://poshtools.com/
https://docs.poshtools.com/

# Install in console
Find-Module -Name 'PowerShellProTools' | Install-Module -Verbose

# Enumerate commands
Update-Help -Force -ErrorAction SilentlyContinue

Import-Module -Name 'PowerShellProTools'

Get-Command -Module 'PowerShellProTools'

Get-Help -Name Send-PoshProToolsTrialLicense -Examples

<# Install in Visual Studio
    * Extensions > Manage Extensions
    * PowerShell project templates
    * PowerShell command explorer
    * PowerShell integrated terminal
#>

<# Install in Visual Studio Code
    * Module explorer
    * Command palette drop-down
#>

# Profile script performance
code .\service.ps1
# palette > PowerShell: Profile Script
https://docs.poshtools.com/powershell-pro-tools-documentation/visual-studio-code/profiler

# Package a script, potentially with the PS Core runtime
# palette > PowerShell: Package as executable
code .\hello.ps1
Merge-Script -Config @{
    Root       = 'C:\Users\tim\summer2019\hello.ps1'
    OutputPath = 'C:\Users\tim\summer2019\out'
    Package    = @{
        Enabled           = $true
        HideConsoleWindow = $false
        # DotNetVersion = 'v4.6.2'
        # ApplicationIconPath = 'C:\users\tim\desktop\icon.ico'
    }
}

# ConvertTo-PowerShell & ConvertTo-CSharp
# palette > CSharp: Convert to PowerShell / PowerShell: Convert to CSharp
code .\hello.cs
code .\hello.ps1

# Generate GUI from a function
# open function file first
# palette > PowerShell: Generate Windows Form
code .\newuser.ps1

# Windows form designer
# palette > PowerShell: Show Windows Form Designer
code .\newform.ps1
















