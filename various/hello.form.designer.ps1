$Form1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$btn = $null
function InitializeComponent
{
$btn = (New-Object -TypeName System.Windows.Forms.Button)
$form1.SuspendLayout()
#
# btn
#
$btn.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]220,[System.Int32]10))
$btn.Name = [System.String]'btn'
$btn.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$btn.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$btn.TabIndex = 1
$btn.Text = 'Submit'
$btn.UseVisualStyleBackColor = $true
$btn.add_Click($btn_Click)
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]380,[System.Int32]50))
$Form1.Controls.Add($btn)
$Form1.Text = [System.String]'Form1'
$Form1.ResumeLayout($true)
Add-Member -InputObject $Form1 -Name btn -Value $btn -MemberType NoteProperty
}
. InitializeComponent
