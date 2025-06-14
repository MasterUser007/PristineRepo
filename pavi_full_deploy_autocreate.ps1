# ML-INSTRUMENTED

# pavi_full_deploy_autocreate.ps1
Write-Host "[Pavi] Deploy: Auto-create all core scripts if missing..." -ForegroundColor Cyan

$templates = @{
    "pavi_indexer.ps1" = "# Insert full indexer code here";
    "pavi_selfcheck_indexed.ps1" = "# Insert full selfcheck code here";
    "pavi_autofix_indexed.ps1" = "# Insert full autofix code here";
}
foreach ($f in $templates.Keys) {
    if (!(Test-Path $f)) {
        Set-Content $f $templates[$f]
        Write-Host "[Pavi] $f created from template." -ForegroundColor Yellow
    }
}
if (Test-Path './pavi_indexer.ps1') { powershell -ExecutionPolicy Bypass -File .\pavi_indexer.ps1 }
if (Test-Path './pavi_autofix_indexed.ps1') { powershell -ExecutionPolicy Bypass -File .\pavi_autofix_indexed.ps1 }
if (Test-Path './pavi_selfcheck_indexed.ps1') { powershell -ExecutionPolicy Bypass -File .\pavi_selfcheck_indexed.ps1 }

