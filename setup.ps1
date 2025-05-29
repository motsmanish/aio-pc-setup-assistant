function Show-MainMenu {
    Clear-Host
    Write-Host "`n==== PC Setup Assistant ====" -ForegroundColor Cyan
    Write-Host "1. Run Tweaks"
    Write-Host "2. Install Software"
    Write-Host "3. Remove Bloatware"
    Write-Host "4. Exit"
    return Read-Host "`nChoose an option"
}

do {
    $choice = Show-MainMenu
    switch ($choice) {
        "1" { . "$PSScriptRoot\tweaks.ps1" }
        "2" { . "$PSScriptRoot\install-software.ps1" }
        "3" { . "$PSScriptRoot\remove-bloatware.ps1" }
        "4" { break }
        default { Write-Host "Invalid choice" }
    }
    if ($choice -ne "4") { Pause }
} while ($true)