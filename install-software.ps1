Write-Host "Launching software installer..."


Add-Type -AssemblyName System.Windows.Forms

# Define apps: Name, Method (winget or url), WingetId (if applicable), URL (if applicable)
$apps = @(
    @{Name="Google Chrome"; Method="winget"; WingetId="Google.Chrome"; Url=""},
    @{Name="RustDesk"; Method="winget"; WingetId="RustDesk.RustDesk"; Url=""},
    @{Name="Chrome Dev"; Method="winget"; WingetId="Google.Chrome.Dev"; Url=""},
    @{Name="Foxit Reader"; Method="winget"; WingetId="Foxit.FoxitReader"; Url=""},
    @{Name="WinRAR"; Method="winget"; WingetId="RARLab.WinRAR"; Url=""},
    @{Name="WhatsApp"; Method="winget"; WingetId="9NKSQGP7F2NH"; Url=""},
    @{Name="Move Mouse"; Method="winget"; WingetId="9NQ4QL59XLBF"; Url=""},
    @{Name="Google Drive"; Method="winget"; WingetId="Google.GoogleDrive"; Url=""},
    @{Name="VLC Media Player"; Method="winget"; WingetId="VideoLAN.VLC"; Url=""},
    @{Name="Microsoft Office"; Method="winget"; WingetId="Microsoft.Office"; Url=""},
    @{Name="Everything"; Method="winget"; WingetId="voidtools.Everything"; Url=""},
    @{Name="Slack"; Method="winget"; WingetId="SlackTechnologies.Slack"; Url=""},
    @{Name="Sublime Text"; Method="winget"; WingetId="SublimeHQ.SublimeText.4"; Url=""},
    @{Name="TortoiseGit"; Method="winget"; WingetId="TortoiseGit.TortoiseGit"; Url=""},
    @{Name="WinSCP"; Method="winget"; WingetId="WinSCP.WinSCP"; Url=""},
    @{Name="Composer"; Method="winget"; WingetId="Composer.Composer"; Url=""},
    @{Name="PuTTY"; Method="winget"; WingetId="PuTTY.PuTTY"; Url=""},
    @{Name="Git"; Method="winget"; WingetId="Git.Git"; Url=""},
    @{Name="PHP"; Method="url"; WingetId=""; Url="https://windows.php.net/downloads/releases/php-8.2.19-Win32-vs16-x64.zip"},
    @{Name="Python"; Method="url"; WingetId=""; Url="https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe"},
)

# GUI to select apps
$form = New-Object System.Windows.Forms.Form
$form.Text = "Select Software to Install"
$form.Size = New-Object System.Drawing.Size(400, 540)
$form.StartPosition = "CenterScreen"

$checkedListBox = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox.Size = New-Object System.Drawing.Size(360, 400)
$checkedListBox.Location = New-Object System.Drawing.Point(10, 10)
$checkedListBox.CheckOnClick = $true

$apps | ForEach-Object { $checkedListBox.Items.Add($_.Name) }
$form.Controls.Add($checkedListBox)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "Install Selected"
$okButton.Location = New-Object System.Drawing.Point(150, 430)
$okButton.Add_Click({
    $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.Close()
})
$form.Controls.Add($okButton)
$form.ShowDialog() | Out-Null

# Process selected
$selected = @()
for ($i = 0; $i -lt $checkedListBox.Items.Count; $i++) {
    if ($checkedListBox.GetItemChecked($i)) {
        $selected += $apps[$i]
    }
}

if ($selected.Count -eq 0) {
    Write-Host "`n[!] No software selected. Exiting..."
    Read-Host "Press Enter to close"
    exit
}

$installed = @()
$failed = @()
$count = 0
$total = $selected.Count

foreach ($app in $selected) {
    $count++
    Write-Host "`n[$count of $total] Installing: $($app.Name)..."

    if ($app.Method -eq "winget") {
        $isInstalled = winget list --id $($app.WingetId) | Select-String $app.WingetId
        if ($isInstalled) {
            Write-Host "[SKIP] Already installed: $($app.Name)"
            $installed += "$($app.Name) (already installed)"
            continue
        }

        winget install --id=$($app.WingetId) --silent --force --accept-package-agreements --accept-source-agreements
        $exitCode = $LASTEXITCODE
    }
    elseif ($app.Method -eq "url") {
        $filename = [System.IO.Path]::GetFileName($app.Url)
        $tempPath = "$env:TEMP\$filename"

        # Download file
        Invoke-WebRequest -Uri $app.Url -OutFile $tempPath -UseBasicParsing

        if ($app.Name -eq "Python") {
            Start-Process -FilePath $tempPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
            $exitCode = $LASTEXITCODE
        } elseif ($app.Name -eq "PHP") {
            $phpPath = "C:\php"
            Expand-Archive -Path $tempPath -DestinationPath $phpPath -Force
            $envPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
            if ($envPath -notlike "*$phpPath*") {
                [Environment]::SetEnvironmentVariable("Path", "$envPath;$phpPath", "Machine")
            }
            if (-not (Test-Path "$phpPath\php.ini")) {
                Copy-Item "$phpPath\php.ini-development" "$phpPath\php.ini"
            }
            $exitCode = 0
        } else {
            Start-Process -FilePath $tempPath -Wait
            $exitCode = $LASTEXITCODE
        }
    }

    if ($exitCode -eq 0) {
        Write-Host "[OK] Installed: $($app.Name)"
        $installed += $app.Name
    } else {
        Write-Host "[ERROR] Failed to install: $($app.Name)"
        $failed += $app.Name
    }
}

# Summary
Write-Host "`n====================="
Write-Host " Installation Summary:"
Write-Host "====================="

Write-Host "`n Installed:"
$installed | ForEach-Object { Write-Host " - $_" }

if ($failed.Count -gt 0) {
    Write-Host "`n Failed:"
    $failed | ForEach-Object { Write-Host " - $_" }
}

Write-Host "`n All done!"
Read-Host "Press Enter to exit"
