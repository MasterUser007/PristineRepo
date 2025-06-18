. .\.env.loader.ps1

$modules = @("QuantumHash", "PrimeEngineAI (1)", "FactorEngine", "ExoSuite")

foreach ($mod in $modules) {
    Write-Host "📦 Installing: $mod"
    try {
        pip install -e "$mod"
    } catch {
        Write-Host "⚠️ Skipping install for ExoSuite — install failed"
    }
}

Write-Host "
🧪 Launching root test runner..."
& .\root-test.ps1
