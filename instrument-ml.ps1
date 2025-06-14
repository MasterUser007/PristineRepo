# ML-INSTRUMENTED
# instruments all .ps1 scripts with the ML marker if not present

Get-ChildItem -Path . -Filter *.ps1 -Recurse | ForEach-Object {
    $path = $_.FullName
    $content = Get-Content $path -Raw
    if (-not ($content -match "# ML-INSTRUMENTED")) {
        Set-Content $path -Value ("# ML-INSTRUMENTED`r`n$content")
        Write-Host "Instrumented: $path" -ForegroundColor Green
    }
}
