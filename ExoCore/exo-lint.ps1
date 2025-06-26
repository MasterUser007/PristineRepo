# === EXO LINT ===
Write-Host "🔍 Running Exo Linter..."

$files = Get-ChildItem -Path "$PSScriptRoot" -Filter "*.ps1" -Recurse
foreach ($file in $files) {
  try {
    [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$null, [ref]$null) | Out-Null
    Write-Host "✅ $($file.Name) valid."
  } catch {
    Write-Warning "❌ Syntax error in $($file.FullName)"
  }
}

# Scan for known placeholder markers
$stubCheck = Select-String -Path "$PSScriptRoot\**\*.ps1" -Pattern "\\|\bTODO\b|\bstub\b"
if ($stubCheck) {
  Write-Warning "`n⚠️ Placeholder markers detected:"
  $stubCheck | ForEach-Object { Write-Host $_.Path ":" $_.Line.Trim() }
}
