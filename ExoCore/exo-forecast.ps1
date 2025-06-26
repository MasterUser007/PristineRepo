# === EXO FORECAST ===
Write-Host "📡 Running forecast analysis..."
New-Item -Path "\\..\Lessons" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
\ = Get-ChildItem "\\..\Lessons" -Filter "exo_lesson_*.md" | Sort-Object LastWriteTime -Descending | Select-Object -First 5
foreach (\ in \) {
  \ = Get-Content \.FullName
  if (\ -match "advisory|trigger|drift") {
    Write-Host "🔮 Forecast insight: \"
  }
}
Write-Host "✅ Forecast complete."
