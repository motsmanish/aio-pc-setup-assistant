Set-ExecutionPolicy Bypass -Scope Process -Force

# Base URL of your GitHub repo
$baseUrl = "https://raw.githubusercontent.com/motsmanish/aio-pc-setup-assistant/main/"

# List of script files in your repo
$files = @(
    "tweaks.ps1",
    "install-software.ps1",
    "remove-bloatware.ps1"
)

# Download and dot-source each script
foreach ($file in $files) {
    $localPath = "$env:TEMP\" + [IO.Path]::GetFileName($file)
    Write-Host "`nFetching $file..." -ForegroundColor Cyan
    Invoke-WebRequest "$baseUrl/$file" -OutFile $localPath
    Write-Host "Running $file..."
    . $localPath
}

Write-Host "`n✅ All modules loaded and executed." -ForegroundColor Green
Read-Host "`nPress Enter to close"
