. 'C:\Users\tim\summer2019\newuser.ps1'
Add-Type -AssemblyName System.Windows.Forms
$btn_Click = {
	New-User -UserName $txtUserName.Text -Enabled:$chkEnabled.Checked -Department $comDepartment.SelectedItem 
}
. $MyInvocation.InvocationName.Replace('form.ps1', 'form.designer.ps1')
$Form1.ShowDialog()
