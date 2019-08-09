# Monitor Azure Automation Data

# Use KQL Playground: https://portal.loganalytics.io/demo#/discover/query/main

# Find the ResourceId for the Automation Account
Get-AzResource -ResourceType "Microsoft.Automation/automationAccounts"

# Find the ResourceId for the Log Analytics workspace
Get-AzResource -ResourceType "Microsoft.OperationalInsights/workspaces"

$workspaceId = "/subscriptions/2fbf906e-1101-4bc0-b64f-adc44e462fff/resourceGroups/techorama/providers/Microsoft.OperationalInsights/workspaces/techorama-workspace704"

$automationAccountId = "/subscriptions/2fbf906e-1101-4bc0-b64f-adc44e462fff/resourceGr
oups/techorama/providers/Microsoft.Automation/automationAccoun
ts/techorama"

Set-AzDiagnosticSetting -ResourceId '/subscriptions/2fbf906e-1101-4bc0-b64f-adc44e462fff/resourceGroups/techorama/providers/Microsoft.Automation/automationAccounts/techorama' -WorkspaceId '7ac85cd5-57a6-4094-82d1-6e767f66c4a2' -Enabled $true

Get-AzDiagnosticSetting -ResourceId $automationAccountId

# KQL query
AzureDiagnostics | where ResourceProvider == "MICROSOFT.AUTOMATION"

# Look for alerts
AzureDiagnostics | where ResourceProvider == "MICROSOFT.AUTOMATION" and Category == "JobLogs" and (ResultType == "Failed" or ResultType == "Suspended") | summarize AggregatedValue = count() by RunbookName_s

# Find runbook jobs completed with errors
AzureDiagnostics | where ResourceProvider == "MICROSOFT.AUTOMATION" and Category == "JobStreams" and StreamType_s == "Error" | summarize AggregatedValue = count() by JobId_g

# View historical job status
AzureDiagnostics | where ResourceProvider == "MICROSOFT.AUTOMATION" and Category == "JobLogs" and ResultType != "started" | summarize AggregatedValue = count() by ResultType, bin(TimeGenerated, 1h)









