# === EXO SYNC AGENT ===
\ = Get-Content .\sync_manifest.json | ConvertFrom-Json
foreach (\ in \.PSObject.Properties.Name) {
  \ = \.\
  if (Test-Path \) {
    Write-Host "☁️ Syncing \ → S3://exocore-memory/\/"
    aws s3 sync \ s3://exocore-memory/\/ --delete | Out-Null
  }
}
