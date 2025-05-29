Write-Host "Running Raphi's Debloat Script..." -ForegroundColor Cyan
Set-ExecutionPolicy Bypass -Scope Process -Force
& ([scriptblock]::Create((irm "https://debloat.raphi.re/")))
