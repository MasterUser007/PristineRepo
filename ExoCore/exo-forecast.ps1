# === EXO FORECAST ===
Write-Host "`n📡 Running forecast analysis..." -ForegroundColor Cyan

$lessons = Get-ChildItem "$PSScriptRoot\..\Lessons\" -Filter "exo_lesson_*.md" |
           Sort-Object LastWriteTime -Descending | Select-Object -First 10

foreach ($lesson in $lessons) {
  $content = Get-Content $lesson.FullName
  if ($content -match "advisory|drift|trigger") {
    Write-Host "🔮 Forecast Insight: $($lesson.Name) contains advisory markers"
  }
}
Write-Host "`n✅ Forecast complete. Begin advisory synthesis." -ForegroundColor Green
