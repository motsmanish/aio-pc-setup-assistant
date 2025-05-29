Write-Host "Running system tweaks..."

function Show-TweaksMenu {
    Clear-Host
    Write-Host "`n==== PC Setup Tweaks Menu ====" -ForegroundColor Cyan
    Write-Host "1. Enable Hibernate"
    Write-Host "2. Change Downloads Path to D:\Downloads"
    Write-Host "3. Enable Classic Context Menu (Windows 11)"
    Write-Host "4. Download & Run ExplorerPatcher (Never Combine Taskbar)"
    Write-Host "5. Move Taskbar Icons to Left"
    Write-Host "6. Show 'This PC' Icon on Desktop"
    Write-Host "7. Make File Explorer open 'This PC' by default"
    Write-Host "0. Exit"
    return Read-Host "`nSelect an option"
}

function Enable-Hibernate {
    powercfg -hibernate on
    Write-Host "Hibernate enabled."
}

function Change-DownloadsPath {
    if (-not (Test-Path "D:\Downloads")) {
        New-Item -ItemType Directory -Path "D:\Downloads"
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" `
        -Name '{374DE290-123F-4565-9164-39C4925E467B}' `
        -Value 'D:\Downloads'
    Stop-Process -Name explorer -Force
    Start-Process explorer
    Write-Host "Downloads path changed and Explorer restarted."
}

function Enable-ClassicContextMenu {
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
    Stop-Process -Name explorer -Force
    Start-Process explorer
    Write-Host "Classic context menu enabled."
}

function Install-ExplorerPatcher {
    $epUrl = "https://github.com/valinet/ExplorerPatcher/releases/latest/download/ep_setup.exe"
    $epPath = "$env:TEMP\ep_setup.exe"
    Invoke-WebRequest -Uri $epUrl -OutFile $epPath -UseBasicParsing
    Start-Process -FilePath $epPath -Wait
    Write-Host "ExplorerPatcher installed. Right-click Taskbar → Properties to enable 'Never Combine'."
}

function Move-Taskbar-Left {
    New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -Value 0 -PropertyType DWord -Force
    Stop-Process -Name explorer -Force
    Start-Process explorer
    Write-Host "Taskbar icons aligned to the left."
}

function Show-ThisPC-Desktop {
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' `
        -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Value 0
    Stop-Process -Name explorer -Force
    Start-Process explorer
    Write-Host "'This PC' icon is now visible on the desktop."
}

function Set-ExplorerToThisPC {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
        -Name "LaunchTo" -Value 1 -Type DWord
    Stop-Process -Name explorer -Force
    Start-Process explorer
    Write-Host "File Explorer will now open 'This PC' by default."
}

do {
    $choice = Show-TweaksMenu
    switch ($choice) {
        "1" { Enable-Hibernate }
        "2" { Change-DownloadsPath }
        "3" { Enable-ClassicContextMenu }
        "4" { Install-ExplorerPatcher }
        "5" { Move-Taskbar-Left }
        "6" { Show-ThisPC-Desktop }
        "7" { Set-ExplorerToThisPC }
        "0" { Write-Host "`nGoodbye!" -ForegroundColor Green }
        default { Write-Host "Invalid selection. Try again." -ForegroundColor Yellow }
    }
    if ($choice -ne "0") { Pause }
} while ($choice -ne "0")
