Set-ExecutionPolicy Bypass -Scope Process -Force

# Base URL of your GitHub repo
$baseUrl = "https://raw.githubusercontent.com/motsmanish/aio-pc-setup-assistant/main"

# Script list with friendly names and file paths
$scripts = @{
    "Tweaks"             = "tweaks.ps1"
    "Install Software"   = "install-software.ps1"
    "Exit"               = ""
}

# Show menu
function Show-Menu {
    Clear-Host
    Write-Host "`n==== AIO PC Setup Assistant ====" -ForegroundColor Cyan
    $i = 1
    $global:options = @{}
    foreach ($key in $scripts.Keys) {
        Write-Host "$i. $key"
        $global:options[$i.ToString()] = $scripts[$key]
        $i++
    }
    return Read-Host "`nChoose an option"
}

# Main loop
do {
    $choice = Show-Menu
    $selectedScript = $options[$choice]

    if ($selectedScript -and (Test-Path $selectedScript) -eq $false) {
        $localPath = "$env:TEMP\" + [IO.Path]::GetFileName($selectedScript)
        Write-Host "`nDownloading: $selectedScript..." -ForegroundColor Yellow
        Invoke-WebRequest "$baseUrl/$selectedScript" -OutFile $localPath
        Write-Host "Running: $selectedScript`n"
        . $localPath
    } elseif ($selectedScript) {
        . $selectedScript
    }

    if (-not $selectedScript) {
        break
    }

    Pause
} while ($true)

Write-Host "`nThank you for using PC Setup Assistant." -ForegroundColor Green
