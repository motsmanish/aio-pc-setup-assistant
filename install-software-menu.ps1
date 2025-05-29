Add-Type -AssemblyName System.Windows.Forms

# Full app list with method handling
$apps = @(
    @{Name="Google Chrome"; Method="winget"; WingetId="Google.Chrome"; Url=""}
    @{Name="RustDesk"; Method="winget"; WingetId="RustDesk.RustDesk"; Url=""}
    @{Name="Chrome Dev"; Method="winget"; WingetId="Google.Chrome.Dev"; Url=""}
    @{Name="Foxit Reader"; Method="winget"; WingetId="Foxit.FoxitReader"; Url=""}
    @{Name="WinRAR"; Method="winget"; WingetId="RARLab.WinRAR"; Url=""}
    @{Name="WhatsApp"; Method="winget"; WingetId="9NKSQGP7F2NH"; Url=""}
    @{Name="Move Mouse"; Method="winget"; WingetId="9NQ4QL59XLBF"; Url=""}
    @{Name="Google Drive"; Method="winget"; WingetId="Google.GoogleDrive"; Url=""}
    @{Name="VLC Media Player"; Method="winget"; WingetId="VideoLAN.VLC"; Url=""}
    @{Name="Microsoft Office"; Method="winget"; WingetId="Microsoft.Office"; Url=""}
    @{Name="Everything"; Method="winget"; WingetId="voidtools.Everything"; Url=""}
    @{Name="Slack"; Method="winget"; WingetId="SlackTechnologies.Slack"; Url=""}
    @{Name="Sublime Text"; Method="winget"; WingetId="SublimeHQ.SublimeText.4"; Url=""}
    @{Name="TortoiseGit"; Method="winget"; WingetId="TortoiseGit.TortoiseGit"; Url=""}
    @{Name="WinSCP"; Method="winget"; WingetId="WinSCP.WinSCP"; Url=""}
    @{Name="Composer"; Method="winget"; WingetId="Composer.Composer"; Url=""}
    @{Name="PuTTY"; Method="winget"; WingetId="PuTTY.PuTTY"; Url=""}
    @{Name="Git"; Method="winget"; WingetId="Git.Git"; Url=""}
    @{Name="PHP"; Method="url"; WingetId=""; Url="https://windows.php.net/downloads/releases/php-8.2.19-Win32-vs16-x64.zip"}
    @{Name="Python"; Method="url"; WingetId=""; Url="https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe"}
)

# GUI setup
$form = New-Object Windows.Forms.Form
$form.Text = "Parallel App Installer"
$form.Size = New-Object Drawing.Size(400, 540)
$form.StartPosition = "CenterScreen"

$listBox = New-Object Windows.Forms.CheckedListBox
$listBox.Size = New-Object Drawing.Size(360, 400)
$listBox.Location = New-Object Drawing.Point(10, 10)
$apps | ForEach-Object { $listBox.Items.Add($_.Name) }
$form.Controls.Add($listBox)

$button = New-Object Windows.Forms.Button
$button.Text = "Install Selected"
$button.Size = New-Object Drawing.Size(140, 30)
$button.Location = New-Object Drawing.Point(125, 430)
$form.Controls.Add($button)

$button.Add_Click({
    $selected = @()
    for ($i = 0; $i -lt $listBox.Items.Count; $i++) {
        if ($listBox.GetItemChecked($i)) {
            $selected += $apps[$i]
        }
    }

    if ($selected.Count -eq 0) {
        [Windows.Forms.MessageBox]::Show("Please select at least one app.")
        return
    }

    foreach ($app in $selected) {
        if ($app.Method -eq "winget") {
            $cmd = "winget install --id=$($app.WingetId) --silent --force --accept-package-agreements --accept-source-agreements"
        }
        elseif ($app.Method -eq "url") {
            $cmd = "Invoke-WebRequest -Uri '$($app.Url)' -OutFile `"$env:TEMP\$([System.IO.Path]::GetFileName($app.Url))`" ; Start-Process `"$env:TEMP\$([System.IO.Path]::GetFileName($app.Url))`""
        }
        Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", $cmd
    }

    $form.Close()
})

[void]$form.ShowDialog()
