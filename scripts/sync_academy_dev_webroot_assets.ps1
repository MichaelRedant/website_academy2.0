param(
    [Parameter(Mandatory = $true)]
    [string]$Username,

    [Parameter(Mandatory = $true)]
    [string]$Password,

    [string]$ServerHost = 'academy-dev.octopus.be',
    [int]$Port = 22,
    [string]$RemoteWebRoot = '/academy-dev.octopus.be/www'
)

$ErrorActionPreference = 'Stop'

Import-Module Posh-SSH

$repoRoot = Split-Path -Parent $PSScriptRoot
$localPublic = Join-Path $repoRoot 'monolith/public'

if (-not (Test-Path -LiteralPath $localPublic)) {
    throw "Lokale public map niet gevonden: $localPublic"
}

$requiredPaths = @(
    'build',
    'manifest.webmanifest',
    'offline.html',
    'sw.js',
    'pwa'
)

foreach ($required in $requiredPaths) {
    $fullPath = Join-Path $localPublic ($required -replace '/', '\')
    if (-not (Test-Path -LiteralPath $fullPath)) {
        throw "Vereist public pad ontbreekt: $fullPath"
    }
}

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

function Upload-RelativeFile {
    param(
        [int]$SessionId,
        [string]$LocalFile,
        [string]$RelativePath,
        [string]$RemoteRoot
    )

    $relativeUnix = $RelativePath -replace '\\', '/'
    $remoteParent = [System.IO.Path]::GetDirectoryName($relativeUnix)

    if ([string]::IsNullOrWhiteSpace($remoteParent)) {
        $remoteDir = $RemoteRoot
    } else {
        $remoteDir = "$RemoteRoot/$($remoteParent -replace '\\', '/')"
    }

    Ensure-RemoteDir -SessionId $SessionId -DirPath $remoteDir
    Set-SFTPItem -SessionId $SessionId -Path $LocalFile -Destination $remoteDir -Force | Out-Null
    Write-Host "Uploaded $relativeUnix"
}

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($Username, $securePassword)
$session = New-SFTPSession -ComputerName $ServerHost -Port $Port -Credential $credential -AcceptKey

try {
    $itemsToUpload = @()

    foreach ($path in $requiredPaths) {
        $full = Join-Path $localPublic ($path -replace '/', '\')
        $item = Get-Item -LiteralPath $full

        if ($item.PSIsContainer) {
            $files = Get-ChildItem -LiteralPath $full -Recurse -File
            foreach ($file in $files) {
                $relative = $file.FullName.Substring($localPublic.Length + 1)
                $itemsToUpload += [PSCustomObject]@{
                    Local = $file.FullName
                    Relative = $relative
                }
            }
        } else {
            $itemsToUpload += [PSCustomObject]@{
                Local = $item.FullName
                Relative = $path
            }
        }
    }

    $uploadCount = 0
    foreach ($upload in $itemsToUpload) {
        Upload-RelativeFile -SessionId $session.SessionId -LocalFile $upload.Local -RelativePath $upload.Relative -RemoteRoot $RemoteWebRoot
        $uploadCount++
    }

    Write-Host "Webroot asset sync afgerond. Aantal geuploade bestanden: $uploadCount"
}
finally {
    if ($session) {
        Remove-SFTPSession -SessionId $session.SessionId | Out-Null
    }
}
