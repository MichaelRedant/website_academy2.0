[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$MonolithPath
)

$ErrorActionPreference = "Stop"

function Ensure-Directory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

function Clear-ReadOnlyRecursively {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return
    }

    $items = @()
    $items += Get-Item -LiteralPath $Path -Force
    $items += Get-ChildItem -LiteralPath $Path -Force -Recurse -ErrorAction SilentlyContinue

    foreach ($item in $items) {
        try {
            $attrs = $item.Attributes
            if ($attrs -band [System.IO.FileAttributes]::ReadOnly) {
                $item.Attributes = $attrs -band (-bnot [System.IO.FileAttributes]::ReadOnly)
            }
        } catch {
            # Best effort: if OneDrive locks an item temporarily, continue.
        }
    }
}

$requiredDirs = @(
    (Join-Path $MonolithPath "bootstrap\\cache"),
    (Join-Path $MonolithPath "storage"),
    (Join-Path $MonolithPath "storage\\app"),
    (Join-Path $MonolithPath "storage\\framework"),
    (Join-Path $MonolithPath "storage\\framework\\cache"),
    (Join-Path $MonolithPath "storage\\framework\\sessions"),
    (Join-Path $MonolithPath "storage\\framework\\testing"),
    (Join-Path $MonolithPath "storage\\framework\\views"),
    (Join-Path $MonolithPath "storage\\logs")
)

foreach ($dir in $requiredDirs) {
    Ensure-Directory -Path $dir
}

foreach ($dir in $requiredDirs) {
    Clear-ReadOnlyRecursively -Path $dir
}

# Keep bootstrap/cache cleanly tracked and writable.
$bootstrapCacheGitignore = Join-Path $MonolithPath "bootstrap\\cache\\.gitignore"
if (-not (Test-Path -LiteralPath $bootstrapCacheGitignore)) {
    Set-Content -Path $bootstrapCacheGitignore -Value "*`n!.gitignore`n" -NoNewline
}
