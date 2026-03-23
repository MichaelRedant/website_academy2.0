$ErrorActionPreference = "SilentlyContinue"

function New-Row {
    param(
        [string]$Tool,
        [string]$Status,
        [string]$Details,
        [bool]$Required
    )

    [PSCustomObject]@{
        Tool = $Tool
        Status = $Status
        Details = $Details
        Required = $Required
    }
}

function Resolve-PhpExecutable {
    $phpFromPath = Get-Command php -ErrorAction SilentlyContinue
    if ($phpFromPath) {
        return [PSCustomObject]@{
            Path = $phpFromPath.Source
            Source = "PATH"
        }
    }

    $wingetPattern = Join-Path $env:LOCALAPPDATA "Microsoft\\WinGet\\Packages\\PHP.PHP.*\\php.exe"
    $wingetCandidate = Get-ChildItem -Path $wingetPattern -File -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1
    if ($wingetCandidate) {
        return [PSCustomObject]@{
            Path = $wingetCandidate.FullName
            Source = "local install"
        }
    }

    return $null
}

function Resolve-ComposerRunner {
    $composerFromPath = Get-Command composer -ErrorAction SilentlyContinue
    if ($composerFromPath) {
        return [PSCustomObject]@{
            Mode = "command"
            Path = $composerFromPath.Source
            Source = "PATH"
        }
    }

    $composerBat = Join-Path $env:LOCALAPPDATA "ComposerLite\\composer.bat"
    if (Test-Path $composerBat) {
        return [PSCustomObject]@{
            Mode = "command"
            Path = $composerBat
            Source = "local install"
        }
    }

    $composerPhar = Join-Path $env:LOCALAPPDATA "ComposerLite\\composer.phar"
    if (Test-Path $composerPhar) {
        return [PSCustomObject]@{
            Mode = "phar"
            Path = $composerPhar
            Source = "local install"
        }
    }

    return $null
}

function Invoke-ComposerVersion {
    param(
        [Parameter(Mandatory = $true)]
        [PSCustomObject]$ComposerRunner,
        [Parameter(Mandatory = $true)]
        [PSCustomObject]$PhpExecutable
    )

    if ($ComposerRunner.Mode -eq "command") {
        return (& $ComposerRunner.Path --version | Select-Object -First 1)
    }

    return (& $PhpExecutable.Path $ComposerRunner.Path --version | Select-Object -First 1)
}

$rows = @()

# Node.js
$nodeVersion = node -v
if ($LASTEXITCODE -eq 0 -and $nodeVersion) {
    $rows += New-Row -Tool "Node.js" -Status "OK" -Details ($nodeVersion | Select-Object -First 1) -Required $true
} else {
    $rows += New-Row -Tool "Node.js" -Status "MISSING" -Details "" -Required $true
}

# npm
$npmVersion = npm -v
if ($LASTEXITCODE -eq 0 -and $npmVersion) {
    $rows += New-Row -Tool "npm" -Status "OK" -Details ($npmVersion | Select-Object -First 1) -Required $true
} else {
    $rows += New-Row -Tool "npm" -Status "MISSING" -Details "" -Required $true
}

# PHP
$phpExecutable = Resolve-PhpExecutable
if ($phpExecutable) {
    $phpVersion = & $phpExecutable.Path -v | Select-Object -First 1
    $details = $phpVersion
    if ($phpExecutable.Source -ne "PATH") {
        $details = "$phpVersion ($($phpExecutable.Source))"
    }
    $rows += New-Row -Tool "PHP" -Status "OK" -Details $details -Required $true
} else {
    $rows += New-Row -Tool "PHP" -Status "MISSING" -Details "" -Required $true
}

# Composer
$composerRunner = Resolve-ComposerRunner
if ($composerRunner -and $phpExecutable) {
    try {
        $composerVersion = Invoke-ComposerVersion -ComposerRunner $composerRunner -PhpExecutable $phpExecutable
        $details = $composerVersion
        if ($composerRunner.Source -ne "PATH") {
            $details = "$composerVersion ($($composerRunner.Source))"
        }
        $rows += New-Row -Tool "Composer" -Status "OK" -Details $details -Required $true
    } catch {
        $rows += New-Row -Tool "Composer" -Status "MISSING" -Details "" -Required $true
    }
} else {
    $rows += New-Row -Tool "Composer" -Status "MISSING" -Details "" -Required $true
}

# Docker (optional)
$dockerVersion = docker --version
if ($LASTEXITCODE -eq 0 -and $dockerVersion) {
    $rows += New-Row -Tool "Docker" -Status "OK" -Details ($dockerVersion | Select-Object -First 1) -Required $false
} else {
    $rows += New-Row -Tool "Docker" -Status "MISSING" -Details "" -Required $false
}

# Required PHP extensions for local Laravel dev/test.
$requiredPhpExtensions = @("curl", "fileinfo", "mbstring", "openssl", "pdo_sqlite", "sqlite3", "zip")
if ($phpExecutable) {
    $loadedModules = @(& $phpExecutable.Path -m | ForEach-Object { $_.ToString().Trim().ToLowerInvariant() })
    $missingExtensions = @($requiredPhpExtensions | Where-Object { $loadedModules -notcontains $_ })
    if ($missingExtensions.Count -eq 0) {
        $rows += New-Row -Tool "PHP ext" -Status "OK" -Details ($requiredPhpExtensions -join ", ") -Required $true
    } else {
        $rows += New-Row -Tool "PHP ext" -Status "MISSING" -Details ("missing: " + ($missingExtensions -join ", ")) -Required $true
    }
} else {
    $rows += New-Row -Tool "PHP ext" -Status "MISSING" -Details "php ontbreekt" -Required $true
}

$rows | Format-Table -AutoSize

$missingRequired = @($rows | Where-Object { $_.Status -eq "MISSING" -and $_.Required -eq $true })
$missingOptional = @($rows | Where-Object { $_.Status -eq "MISSING" -and $_.Required -eq $false })

if ($missingRequired.Count -gt 0) {
    Write-Host ""
    Write-Host "Missing required tools detected:" -ForegroundColor Yellow
    $missingRequired | ForEach-Object { Write-Host "- $($_.Tool) $($_.Details)" -ForegroundColor Yellow }
    if ($missingOptional.Count -gt 0) {
        Write-Host "Missing optional tools:" -ForegroundColor DarkYellow
        $missingOptional | ForEach-Object { Write-Host "- $($_.Tool)" -ForegroundColor DarkYellow }
    }
    exit 1
}

Write-Host ""
Write-Host "All prerequisites are installed." -ForegroundColor Green
if ($missingOptional.Count -gt 0) {
    Write-Host "Optional tools missing:" -ForegroundColor DarkYellow
    $missingOptional | ForEach-Object { Write-Host "- $($_.Tool)" -ForegroundColor DarkYellow }
}
exit 0
