& {
  $wfPath = ".github/workflows"
  if (-not (Test-Path $wfPath)) {
    Write-Host "❌ No workflows directory found."
    return
  }

  Get-ChildItem -Path $wfPath -Filter "*.yml" | ForEach-Object {
    $content = Get-Content $_.FullName
    $name = ($content -match '^name:\s*(.+)' | Out-Null; $Matches[1])
    $schedule = if ($content -match 'schedule:') { "📆 Scheduled" } else { "⚡ Triggered" }
    $path = $_.FullName
    Write-Host "`n• $name [$schedule]"
    Write-Host "  ↳ Path: $path"
  }
}
