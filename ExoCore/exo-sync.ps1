# === EXO SYNC AGENT ===
\ = Get-Content "C:\Users\leebo\Documents\ExoCore\sync_manifest.json" | ConvertFrom-Json
foreach (\ in \.PSObject.Properties.Name) {
  \C:\Users\leebo\Documents\ExoCore\MappingTree\nodes.json = \.\
  if (Test-Path \C:\Users\leebo\Documents\ExoCore\MappingTree\nodes.json) {
    Write-Host "☁️ Syncing \ → S3://exocore-memory/\/"
    aws s3 sync \C:\Users\leebo\Documents\ExoCore\MappingTree\nodes.json s3://exocore-memory/\/ --delete | Out-Null
  }
}
