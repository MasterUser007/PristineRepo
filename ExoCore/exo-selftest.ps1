# === EXO SELFTEST ===
Write-Host "
🧪 Running Exo SelfTest..." -ForegroundColor Cyan
try {
  \ = Join-Path \ "..\MappingTree\core.symbol.json" | Resolve-Path -ErrorAction Stop
} catch {
  Write-Warning "🕘 MappingTree not found — skipping test"
  exit 0
}
if (-not (Test-Path \)) {
  Write-Error "❌ MappingTree reference invalid"
  exit 1
}
if ((Get-Content \).Length -lt 10) {
  Write-Error "❌ MappingTree exists but seems empty"
  exit 1
}
Write-Host "✅ MappingTree validated"
\ = Get-ChildItem "\\..\Lessons" -Filter "exo_lesson_*.md" -ErrorAction SilentlyContinue
if (-not \) {
  Write-Warning "⚠️ No cognition lessons found"
} else {
  \ = \ | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  Write-Host "📘 Latest lesson: \"
}
Write-Host "🧠 SelfTest complete."
