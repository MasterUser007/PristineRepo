# === EXO UNIFY ===
Write-Host "🔗 Unifying engine symbols into cognition payload..."

$symbolFiles = Get-ChildItem "$PSScriptRoot\Telemetry\symbols" -Filter "*.json"
$merged = @()
foreach ($f in $symbolFiles) {
  $j = Get-Content $f.FullName | ConvertFrom-Json
  $merged += $j
}
$merged | ConvertTo-Json -Depth 3 | Set-Content "$PSScriptRoot\Telemetry\unified_cognition.json"
Write-Host "✅ Unified cognition saved."
