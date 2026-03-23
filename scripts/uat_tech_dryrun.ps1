param()

$ErrorActionPreference = "Stop"

$filter = "(AuthRegistrationFlowTest|AuthLoginFlowTest|AccountLessonProgressFlowTest|AccountCertificateFlowTest|PublicCertificateVerificationTest|AdminCertificateManagementTest)"

Write-Host "Running technical UAT dry-run test bundle..."
Write-Host "Filter: $filter"

npm run monolith:artisan -- test --filter=$filter

if ($LASTEXITCODE -ne 0) {
    Write-Error "Technical UAT dry-run failed."
    exit $LASTEXITCODE
}

Write-Host "Technical UAT dry-run passed."
