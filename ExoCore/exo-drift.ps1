# === EXO DRIFT CHECK ===
Write-Host "🌐 Checking for drift between local and S3 memory..."

$manifestPaths = @("Lessons/", "MappingTree/", "Telemetry/")
foreach ($folder in $manifestPaths) {
  if (Test-Path "$PSScriptRoot\$folder") {
    Write-Host "`n📁 $folder vs S3:"
    aws s3 ls "s3://exocore-memory/$folder" | Out-String | Write-Host
  } else {
    Write-Warning "🚫 Missing local path: $folder"
  }
}
