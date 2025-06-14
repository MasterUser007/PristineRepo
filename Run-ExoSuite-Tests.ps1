# ML-INSTRUMENTED
Import-Module ./pavi_ml.psm1

# Run-ExoSuite-Tests.ps1
# Automate ExoSuite Full End-to-End Testing including OpenAI API tests

# Ensure API key is set
if (-not $env:OPENAI_API_KEY) {
    Write-Error "OPENAI_API_KEY environment variable not set. Aborting tests."
    exit 1
}

# 1. Run ExoSuite Python unit/integration tests
Write-Host "Running ExoSuite Python tests with pytest..." -ForegroundColor Cyan

$pytestResult = & python -m pytest --maxfail=1 --disable-warnings -q

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ ExoSuite pytest tests FAILED."
    exit $LASTEXITCODE
} else {
    Write-Host "✅ ExoSuite pytest tests PASSED." -ForegroundColor Green
}

# 2. Run OpenAI API connectivity & completion test
Write-Host "`nRunning OpenAI API test..." -ForegroundColor Cyan

try {
    # Import the test script contents or call script file
    . .\Test-OpenAI.ps1
} catch {
    Write-Error "❌ OpenAI API test FAILED: $_"
    exit 1
}

Write-Host "`nAll tests completed successfully. ✅" -ForegroundColor Green
exit 0

