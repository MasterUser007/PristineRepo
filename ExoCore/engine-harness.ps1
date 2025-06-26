# === EXO ENGINE HARNESS ===
Write-Host "
🚦 Launching Exo Engines..." -ForegroundColor Cyan
\ = @("primecore.ps1", "exo-factor.ps1", "exo-qhash.ps1")
foreach (\ in \) {
  \ = Join-Path \ \
  if (Test-Path \) {
    Write-Host "⚙️ Running \..."
    pwsh \
  } else {
    Write-Warning "🚫 Missing: \"
  }
}
