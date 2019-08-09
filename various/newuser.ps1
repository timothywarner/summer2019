function New-User {
    param([String]$UserName,
        [Switch]$Enabled,
        [ValidateSet("Administrator", "IT", "HR")]$Department)

    Write-Output "$UserName $Enabled $Department"
}