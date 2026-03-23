[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ArtisanArgs
)

$ErrorActionPreference = "Stop"

function Resolve-PhpExecutable {
    $phpFromPath = Get-Command php -ErrorAction SilentlyContinue
    if ($phpFromPath) {
        return $phpFromPath.Source
    }

    $wingetPattern = Join-Path $env:LOCALAPPDATA "Microsoft\\WinGet\\Packages\\PHP.PHP.*\\php.exe"
    $wingetCandidate = Get-ChildItem -Path $wingetPattern -File -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1

    if ($wingetCandidate) {
        return $wingetCandidate.FullName
    }

    throw "PHP executable niet gevonden. Draai eerst scripts/check_prereqs.ps1."
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$monolithPath = Join-Path $repoRoot "monolith"
$artisanPath = Join-Path $monolithPath "artisan"
$ensureWritableScript = Join-Path $PSScriptRoot "ensure_laravel_writable_dirs.ps1"

if (-not (Test-Path $artisanPath)) {
    throw "Kan monolith artisan script niet vinden op $artisanPath."
}
if (-not (Test-Path $ensureWritableScript)) {
    throw "Kan helper script niet vinden op $ensureWritableScript."
}

if (-not $ArtisanArgs -or $ArtisanArgs.Count -eq 0) {
    $ArtisanArgs = @("list")
}

$phpExecutable = Resolve-PhpExecutable

& $ensureWritableScript -MonolithPath $monolithPath

Push-Location $monolithPath
try {
    & $phpExecutable artisan @ArtisanArgs
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        throw "Artisan command faalde met exitcode $exitCode."
    }
} finally {
    Pop-Location
}
