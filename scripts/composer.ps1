[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ComposerArgs
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

function Invoke-Composer {
    param(
        [Parameter(Mandatory = $true)]
        [string]$PhpExecutable,
        [Parameter(Mandatory = $true)]
        [string[]]$Args
    )

    $composerFromPath = Get-Command composer -ErrorAction SilentlyContinue
    if ($composerFromPath) {
        & $composerFromPath.Source @Args
        return
    }

    $composerBat = Join-Path $env:LOCALAPPDATA "ComposerLite\\composer.bat"
    if (Test-Path $composerBat) {
        & $composerBat @Args
        return
    }

    $composerPhar = Join-Path $env:LOCALAPPDATA "ComposerLite\\composer.phar"
    if (Test-Path $composerPhar) {
        & $PhpExecutable $composerPhar @Args
        return
    }

    throw "Composer niet gevonden. Draai eerst scripts/check_prereqs.ps1."
}

if (-not $ComposerArgs -or $ComposerArgs.Count -eq 0) {
    $ComposerArgs = @("install")
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$monolithPath = Join-Path $repoRoot "monolith"
$composerJsonPath = Join-Path $monolithPath "composer.json"
$ensureWritableScript = Join-Path $PSScriptRoot "ensure_laravel_writable_dirs.ps1"

if (-not (Test-Path $composerJsonPath)) {
    throw "Kan monolith composer.json niet vinden op $composerJsonPath."
}
if (-not (Test-Path $ensureWritableScript)) {
    throw "Kan helper script niet vinden op $ensureWritableScript."
}

$phpExecutable = Resolve-PhpExecutable

& $ensureWritableScript -MonolithPath $monolithPath

Push-Location $monolithPath
try {
    Invoke-Composer -PhpExecutable $phpExecutable -Args $ComposerArgs
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        throw "Composer command faalde met exitcode $exitCode."
    }
} finally {
    Pop-Location
}
