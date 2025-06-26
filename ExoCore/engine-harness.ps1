# === EXO ENGINE HARNESS (manifest-aware) ===
Write-Host "
🚦 Launching Engine Harness..."
\ = Join-Path \ "DataLabManifest.json"
if (-Not (Test-Path \)) {
  Write-Error "❌ DataLabManifest.json missing. Cannot proceed."
  exit 1
}
\ = Get-Content \ | ConvertFrom-Json
foreach (\ in \.engines) {
  \ = Join-Path \ \
  if (Test-Path \) {
    Write-Host "⚙️ Running Engine: \"
    pwsh -File \
  } else {
    Write-Warning "🚫 Engine not found: \"
  }
}
