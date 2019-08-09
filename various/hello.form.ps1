. 'C:\Users\tim\summer2019\hello.ps1'
Add-Type -AssemblyName System.Windows.Forms
$btn_Click = {
	Get-Uptime 
}
. $MyInvocation.InvocationName.Replace('form.ps1', 'form.designer.ps1')
$Form1.ShowDialog()
