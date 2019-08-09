1..100 | ForEach-Object {
    Start-Sleep -Milliseconds $_
}

1..100 | ForEach-Object {
    Start-Sleep -Milliseconds $_
}

1..10 | ForEach-Object {
    Start-Sleep -Milliseconds $_
}

Get-Process | Select-Object -Property Name | Out-String

if ($true) {
    1..10 | ForEach-Object {
        1..10 | ForEach-Object {
            1..10 | ForEach-Object {
                Start-Sleep -Milliseconds $_
            }
        }
    }
}