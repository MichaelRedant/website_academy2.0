param()

$ErrorActionPreference = "Stop"

$tests = @(
    "RouteProtectionTest",
    "AuthAntiSpamTest",
    "PublicCertificateVerificationTest",
    "AuthLoginFlowTest",
    "AdminCertificateManagementTest"
)

foreach ($testName in $tests) {
    Write-Host "Running security smoke test filter: $testName"
    npm run monolith:artisan -- test --filter=$testName

    if ($LASTEXITCODE -ne 0) {
        Write-Error "Security smoke failed on filter: $testName"
        exit $LASTEXITCODE
    }
}

Write-Host "Security smoke suite passed."
