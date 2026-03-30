param(
    [Parameter(Mandatory = $true)]
    [string[]]$Files,

    [Parameter(Mandatory = $true)]
    [string]$Username,

    [Parameter(Mandatory = $true)]
    [string]$Password,

    [string]$ServerHost = 'academy-dev.octopus.be',
    [int]$Port = 22,
    [string]$RemoteBase = '/academy-dev.octopus.be/www/academy_app',
    [switch]$SkipManifestSanity
)

$ErrorActionPreference = 'Stop'

Import-Module Posh-SSH

$repoRoot = Split-Path -Parent $PSScriptRoot
$monolithRoot = Join-Path $repoRoot 'monolith'

$dangerousPattern = '^bootstrap/cache/.+\.php$'
$manifestDenyProviders = @(
    'Laravel\\Pail\\PailServiceProvider',
    'Laravel\\Sail\\SailServiceProvider',
    'NunoMaduro\\Collision\\Adapters\\Laravel\\CollisionServiceProvider'
)
$manifestDenyPackages = @(
    'laravel/pail',
    'laravel/sail',
    'nunomaduro/collision'
)

function Ensure-RemoteDir {
    param(
        [int]$SessionId,
        [string]$DirPath
    )

    if ([string]::IsNullOrWhiteSpace($DirPath) -or $DirPath -eq '/') {
        return
    }

    $parts = $DirPath.Trim('/').Split('/')
    $current = ''

    foreach ($part in $parts) {
        $current = "$current/$part"
        if (-not (Test-SFTPPath -SessionId $SessionId -Path $current)) {
            New-SFTPItem -SessionId $SessionId -Path $current -ItemType Directory | Out-Null
        }
    }
}

function Normalize-RelativePath {
    param([string]$Path)

    $normalized = ($Path -replace '\\', '/').Trim()
    return $normalized.TrimStart('./')
}

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($Username, $securePassword)
$session = New-SFTPSession -ComputerName $ServerHost -Port $Port -Credential $credential -AcceptKey

try {
    Write-Host "Deploy target: $ServerHost`:$Port"
    Write-Host "Remote base: $RemoteBase"

    foreach ($file in $Files) {
        $relative = Normalize-RelativePath -Path $file

        if ($relative -match $dangerousPattern) {
            throw "Gevaarlijke upload geblokkeerd: $relative. Upload nooit bootstrap/cache/*.php vanaf lokaal."
        }

        $localPath = Join-Path $monolithRoot ($relative -replace '/', '\')
        if (-not (Test-Path -LiteralPath $localPath)) {
            throw "Lokaal bestand niet gevonden: $localPath"
        }

        $remoteDir = "$RemoteBase/" + ($relative -replace '/[^/]+$', '')
        Ensure-RemoteDir -SessionId $session.SessionId -DirPath $remoteDir

        Write-Host "Uploading $relative"
        Set-SFTPItem -SessionId $session.SessionId -Path $localPath -Destination $remoteDir -Force | Out-Null
    }

    if (-not $SkipManifestSanity) {
        $cacheDir = "$RemoteBase/bootstrap/cache"
        $servicesPath = "$cacheDir/services.php"
        $packagesPath = "$cacheDir/packages.php"

        if ((Test-SFTPPath -SessionId $session.SessionId -Path $servicesPath) -and (Test-SFTPPath -SessionId $session.SessionId -Path $packagesPath)) {
            Write-Host 'Manifest sanity check (services/packages)...'

            $tmpDir = Join-Path $env:TEMP ("academy_manifest_fix_" + [guid]::NewGuid().ToString('N'))
            New-Item -ItemType Directory -Path $tmpDir | Out-Null

            try {
                Get-SFTPItem -SessionId $session.SessionId -Path $servicesPath -Destination $tmpDir -Force | Out-Null
                Get-SFTPItem -SessionId $session.SessionId -Path $packagesPath -Destination $tmpDir -Force | Out-Null

                $localServices = Join-Path $tmpDir 'services.php'
                $localPackages = Join-Path $tmpDir 'packages.php'

                $patchFile = Join-Path $tmpDir 'manifest_patch.php'
                @'
<?php
$servicesPath = $argv[1];
$packagesPath = $argv[2];

$denyProviders = [
    'Laravel\\\\Pail\\\\PailServiceProvider',
    'Laravel\\\\Sail\\\\SailServiceProvider',
    'NunoMaduro\\\\Collision\\\\Adapters\\\\Laravel\\\\CollisionServiceProvider',
];
$denyPackages = [
    'laravel/pail',
    'laravel/sail',
    'nunomaduro/collision',
];

$services = require $servicesPath;
$packages = require $packagesPath;

if (!is_array($services) || !is_array($packages)) {
    throw new RuntimeException('Manifest files zijn ongeldig.');
}

foreach (['providers', 'eager'] as $section) {
    if (isset($services[$section]) && is_array($services[$section])) {
        $services[$section] = array_values(array_filter(
            $services[$section],
            static fn ($provider) => !in_array((string) $provider, $denyProviders, true)
        ));
    }
}

if (isset($services['deferred']) && is_array($services['deferred'])) {
    $services['deferred'] = array_filter(
        $services['deferred'],
        static fn ($provider) => !in_array((string) $provider, $denyProviders, true)
    );
}

if (isset($services['when']) && is_array($services['when'])) {
    foreach (array_keys($services['when']) as $provider) {
        if (in_array((string) $provider, $denyProviders, true)) {
            unset($services['when'][$provider]);
        }
    }
}

foreach ($denyPackages as $package) {
    unset($packages[$package]);
}

file_put_contents($servicesPath, '<?php return '.var_export($services, true).';'.PHP_EOL);
file_put_contents($packagesPath, '<?php return '.var_export($packages, true).';'.PHP_EOL);
'@ | Set-Content -Encoding UTF8 $patchFile

                php $patchFile $localServices $localPackages

                Set-SFTPItem -SessionId $session.SessionId -Path $localServices -Destination $cacheDir -Force | Out-Null
                Set-SFTPItem -SessionId $session.SessionId -Path $localPackages -Destination $cacheDir -Force | Out-Null
            }
            finally {
                if (Test-Path -LiteralPath $tmpDir) {
                    Remove-Item -LiteralPath $tmpDir -Recurse -Force
                }
            }
        }
    }

    Write-Host 'Deploy afgerond zonder verboden cache-uploads.'
}
finally {
    if ($session) {
        Remove-SFTPSession -SessionId $session.SessionId | Out-Null
    }
}
