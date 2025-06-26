# === EXO ENGINE HARNESS: Manifest-Based ===
Write-Host "
🧠 Loading DataLabManifest..."
\ = Get-Content "C:\Users\leebo\Documents\ExoCore\DataLabManifest.json" | ConvertFrom-Json
foreach (\ in \.engines) {
  \ = Join-Path \ \
  if (Test-Path \) {
    Write-Host "⚙️ Running Engine: \"
    pwsh \
  } else {
    Write-Warning "🚫 Engine not found: \"
  }
}
Write-Host "
✅ Data Lab Engine Run Complete"
