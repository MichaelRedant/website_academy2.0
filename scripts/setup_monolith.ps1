[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$monolithPath = Join-Path $repoRoot "monolith"
$artisanScript = Join-Path $PSScriptRoot "artisan.ps1"
$composerScript = Join-Path $PSScriptRoot "composer.ps1"
$ensureWritableScript = Join-Path $PSScriptRoot "ensure_laravel_writable_dirs.ps1"

if (-not (Test-Path $monolithPath)) {
    throw "Monolith map niet gevonden op $monolithPath."
}

if (-not (Test-Path $artisanScript)) {
    throw "Kan artisan wrapper niet vinden op $artisanScript."
}

if (-not (Test-Path $composerScript)) {
    throw "Kan composer wrapper niet vinden op $composerScript."
}

if (-not (Test-Path $ensureWritableScript)) {
    throw "Kan writable-dir helper niet vinden op $ensureWritableScript."
}

& $ensureWritableScript -MonolithPath $monolithPath

$envPath = Join-Path $monolithPath ".env"
$envExamplePath = Join-Path $monolithPath ".env.example"
if (-not (Test-Path $envPath)) {
    if (-not (Test-Path $envExamplePath)) {
        throw ".env ontbreekt en .env.example niet gevonden."
    }
    Copy-Item -Path $envExamplePath -Destination $envPath -Force
}

Write-Host "Installing PHP dependencies (composer)..." -ForegroundColor Cyan
& $composerScript install --no-interaction

Write-Host "Installing frontend dependencies (npm)..." -ForegroundColor Cyan
& npm --prefix $monolithPath install
if ($LASTEXITCODE -ne 0) {
    throw "npm install in monolith faalde met exitcode $LASTEXITCODE."
}

$sqlitePath = Join-Path $monolithPath "database\\database.sqlite"
if (-not (Test-Path $sqlitePath)) {
    New-Item -ItemType File -Path $sqlitePath -Force | Out-Null
    Write-Host "Created SQLite database file: $sqlitePath" -ForegroundColor Cyan
}

$envContent = Get-Content -Raw -Path $envPath
$appKeyMatch = [regex]::Match($envContent, "(?m)^APP_KEY=(.*)$")
$appKeyValue = ""
if ($appKeyMatch.Success) {
    $appKeyValue = $appKeyMatch.Groups[1].Value.Trim()
}

if ([string]::IsNullOrWhiteSpace($appKeyValue)) {
    Write-Host "Generating APP_KEY..." -ForegroundColor Cyan
    & $artisanScript key:generate --ansi
}

Write-Host "Running database migrations..." -ForegroundColor Cyan
& $artisanScript migrate --force --no-interaction

Write-Host "Seeding minimale dataset..." -ForegroundColor Cyan
& $artisanScript db:seed --force --no-interaction

Write-Host "Monolith setup completed." -ForegroundColor Green
