# .env.loader.ps1 — enables cross-module local imports
\QuantumHash PrimeEngineAI (1) FactorEngine ExoSuite = @("QuantumHash", "PrimeEngineAI (1)", "FactorEngine", "ExoSuite")
\C:\Users\leebo\Desktop\PristineRepo = Split-Path \System.Management.Automation.InvocationInfo.MyCommand.Path

foreach (\ in \QuantumHash PrimeEngineAI (1) FactorEngine ExoSuite) {
    \C:\Users\leebo\Desktop\PristineRepo\ExoSuite = Join-Path \C:\Users\leebo\Desktop\PristineRepo \
    \ = Join-Path \C:\Users\leebo\Desktop\PristineRepo\ExoSuite "src"
    if (Test-Path \) {
        \ += ";"
    }
}
Write-Host "✅ PYTHONPATH bootstrapped: "
