$modules = @("QuantumHash", "PrimeEngineAI (1)", "FactorEngine", "ExoSuite")
$results = @{}

foreach ($mod in $modules) {
    $path = Join-Path $PSScriptRoot $mod
    $env:PYTHONPATH += ";$($path)\src"
    Write-Host "`n🧪 Testing $mod..."
    $output = pytest "$path\tests" --tb=short --disable-warnings 2>&1
    $results[$mod] = $output
    $output
}

"`n====================== TEST SUMMARY ======================" | Out-Host
foreach ($mod in $modules) {
    if ($results.ContainsKey($mod)) {
        $out = $results[$mod]
        $summary = ($out | Select-String -Pattern "==+.*==" | Select-Object -Last 1).Line
        if (-not $summary) { $summary = "❔ No results" }
    } else {
        $summary = "❌ Not run"
    }
    Write-Host "${mod}:`t$summary"
}
