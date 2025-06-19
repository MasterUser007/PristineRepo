param (
  [Parameter(Mandatory = $true)]
  [string]$EngineId
)

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$engineDir = "engine\$EngineId"
if (Test-Path $engineDir) {
  Write-Host "✔️  Engine '$EngineId' already exists. Skipping." -ForegroundColor Yellow
  return
}

New-Item -ItemType Directory -Path "$engineDir\docs", "$engineDir\.support_kb" -Force | Out-Null
"Write-Host `"🚀 Launching engine $EngineId...`"" | Out-File "$engineDir\init.ps1"
"{}" | Out-File "$engineDir\engine.config.json"
"# Engine: $EngineId`nCreated: $(Get-Date -Format u)" | Out-File "$engineDir\docs\README.md"
"{}" | Out-File "$engineDir\.support_kb\support-index.json"

Write-Host "`n🎉 Engine '$EngineId' scaffolded successfully." -ForegroundColor Green
