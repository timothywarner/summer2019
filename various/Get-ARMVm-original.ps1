
function Get-ARMVM
{
  $RGs = Get-AzureRMResourceGroup
  foreach($RG in $RGs)
  {
    $VMs = Get-AzureRmVM -ResourceGroupName $RG.ResourceGroupName
    foreach($VM in $VMs)
    {
      $VMDetail = Get-AzureRmVM -ResourceGroupName $RG.ResourceGroupName -Name $VM.Name -Status
      $RGN = $VMDetail.ResourceGroupName
      foreach ($VMStatus in $VMDetail.Statuses)
      {
          $VMStatusDetail = $VMStatus.DisplayStatus
      }
      Write-Output "Resource Group: $RGN", ("VM Name: " + $VM.Name), "Status: $VMStatusDetail" `n
    }
  }
}