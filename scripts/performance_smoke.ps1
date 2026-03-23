param()

$ErrorActionPreference = "Stop"
$serverProcess = $null

try {
    $serverProcess = Start-Process -FilePath npm -ArgumentList "run", "monolith:serve" -PassThru
    Start-Sleep -Seconds 6

    node scripts/qa_performance_smoke.mjs

    if ($LASTEXITCODE -ne 0) {
        Write-Error "Performance smoke failed."
        exit $LASTEXITCODE
    }

    Write-Host "Performance smoke suite passed."
}
finally {
    if ($null -ne $serverProcess -and -not $serverProcess.HasExited) {
        Stop-Process -Id $serverProcess.Id -Force
    }
}
