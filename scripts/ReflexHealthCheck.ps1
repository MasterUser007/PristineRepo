& {
  $reflexLog = ".reflexrun.log.json"
  if (-not (Test-Path $reflexLog)) {
    Write-Host "⚠️ No telemetry log found. ReflexRun may not have executed."
    exit 1
  }

  $data = Get-Content $reflexLog | ConvertFrom-Json
  $now = Get-Date
  $age = ($now - [datetime]$data.Timestamp).TotalMinutes

  if ($age -gt 60) {
    Write-Warning "⏱️ Last ReflexRun was over an hour ago: $($data.Timestamp)"
  } else {
    Write-Host "✅ ReflexRun recent at $($data.Timestamp)"
  }

  if (-not $data.Profile) {
    Write-Warning "⚠️ Profile not logged in Reflex telemetry"
  } else {
    Write-Host "🎯 Last profile: $($data.Profile)"
  }

  Write-Host "📌 Git SHA: $($data.CommitSHA)"
  Write-Host "📎 Branch:  $($data.Branch)"
  Write-Host "🤖 Runner:  $($data.Runner)"
}
