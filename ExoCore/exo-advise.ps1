\C:\Users\leebo\Documents\ExoCore = "\C:\Users\leebo\Documents\ExoCore"
\ = Get-Content "\C:\Users\leebo\Documents\ExoCore\Telemetry\event-log.jsonl" | ForEach-Object { \ | ConvertFrom-Json }
\ = Get-Content "\C:\Users\leebo\Documents\ExoCore\MappingTree\nodes.json" | ConvertFrom-Json

\ = \ | Group-Object -Property contextId
foreach (\ in \) {
    \ = \ | Where-Object { \$.nodeId -eq \.Name }
    if (-not \) { continue }
    \ = \.Group | Where-Object { \$.signal -eq "Failure" } | Select-Object -ExpandProperty learnedFrom -Unique
    if (\) {
        \.PSObject.Properties.Remove("suggestions") | Out-Null
        \ | Add-Member -NotePropertyName "suggestions" -NotePropertyValue (\ | ForEach-Object { "Review lesson \ for context recovery." })
    }
}
\ | ConvertTo-Json -Depth 5 | Set-Content "\C:\Users\leebo\Documents\ExoCore\MappingTree\nodes.json"
Write-Host "🔍 exo-advise.ps1 injected .suggestions[] into mapping tree."
