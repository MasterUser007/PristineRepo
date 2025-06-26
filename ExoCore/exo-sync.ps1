# === EXO SYNC AGENT (Loop Patched) ===
\ = Get-Content .\sync_manifest.json | ConvertFrom-Json
foreach (\ in \.PSObject.Properties.Name) {
  \ = \.\
  if (Test-Path \) {
    Write-Host "☁️ Syncing \ → s3://exocore-memory/\/"
    aws s3 sync \ "s3://exocore-memory/\/" --delete | Out-Null
  } else {
    Write-Warning "🚫 Path not found: \"
  }
}
