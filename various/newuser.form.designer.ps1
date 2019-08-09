$Form1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$btn = $null
[System.Windows.Forms.Label]$lblUserName = $null
[System.Windows.Forms.TextBox]$txtUserName = $null
[System.Windows.Forms.CheckBox]$chkEnabled = $null
[System.Windows.Forms.Label]$lblDepartment = $null
[System.Windows.Forms.ComboBox]$comDepartment = $null
function InitializeComponent
{
$btn = (New-Object -TypeName System.Windows.Forms.Button)
$lblUserName = (New-Object -TypeName System.Windows.Forms.Label)
$txtUserName = (New-Object -TypeName System.Windows.Forms.TextBox)
$chkEnabled = (New-Object -TypeName System.Windows.Forms.CheckBox)
$lblDepartment = (New-Object -TypeName System.Windows.Forms.Label)
$comDepartment = (New-Object -TypeName System.Windows.Forms.ComboBox)
$form1.SuspendLayout()
#
# lblUserName
#
$lblUserName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]10))
$lblUserName.Name = [System.String]'lblUserName'
$lblUserName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblUserName.TabIndex = 1
$lblUserName.Text = 'UserName'
$lblUserName.UseCompatibleTextRendering = $true
#
# txtUserName
#
$txtUserName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]10))
$txtUserName.Name = [System.String]'txtUserName'
$txtUserName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txtUserName.TabIndex = 2
#
# chkEnabled
#
$chkEnabled.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]40))
$chkEnabled.Name = [System.String]'chkEnabled'
$chkEnabled.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$chkEnabled.TabIndex = 3
$chkEnabled.Text = 'Enabled'
$chkEnabled.UseCompatibleTextRendering = $true
$chkEnabled.UseVisualStyleBackColor = $true
#
# lblDepartment
#
$lblDepartment.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]70))
$lblDepartment.Name = [System.String]'lblDepartment'
$lblDepartment.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblDepartment.TabIndex = 4
$lblDepartment.Text = 'Department'
$lblDepartment.UseCompatibleTextRendering = $true
#
# comDepartment
#
$comDepartment.ImeMode = [System.Windows.Forms.ImeMode]::NoControl
$comDepartment.Items.AddRange([System.Object[]]@([System.String]'Administrator',[System.String]'IT',[System.String]'HR'))
$comDepartment.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]70))
$comDepartment.Name = [System.String]'comDepartment'
$comDepartment.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$comDepartment.TabIndex = 5
#
# btn
#
$btn.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]220,[System.Int32]100))
$btn.Name = [System.String]'btn'
$btn.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$btn.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$btn.TabIndex = 6
$btn.Text = 'Submit'
$btn.UseVisualStyleBackColor = $true
$btn.add_Click($btn_Click)
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]380,[System.Int32]170))
$Form1.Controls.Add($lblUserName)
$Form1.Controls.Add($txtUserName)
$Form1.Controls.Add($chkEnabled)
$Form1.Controls.Add($lblDepartment)
$Form1.Controls.Add($comDepartment)
$Form1.Controls.Add($btn)
$Form1.Text = [System.String]'Form1'
$Form1.ResumeLayout($true)
Add-Member -InputObject $Form1 -Name btn -Value $btn -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblUserName -Value $lblUserName -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txtUserName -Value $txtUserName -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name chkEnabled -Value $chkEnabled -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblDepartment -Value $lblDepartment -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name comDepartment -Value $comDepartment -MemberType NoteProperty
}
. InitializeComponent
