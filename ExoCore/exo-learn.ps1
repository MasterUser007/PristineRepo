# === EXO LEARN ENGINE ===
$exoRoot = "$env:USERPROFILE\Documents\ExoCore"
$lessonDir = "$exoRoot\Lessons"
$telemetryPath = "$exoRoot\Telemetry\event-log.jsonl"
$mappingTreePath = "$exoRoot\MappingTree\nodes.json"

$paths = @($lessonDir, (Split-Path $telemetryPath), (Split-Path $mappingTreePath))
foreach ($p in $paths) { if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p -Force | Out-Null } }
if (-not (Test-Path $mappingTreePath)) { "[]" | Out-File -FilePath $mappingTreePath -Encoding UTF8 }

$mappingTree = Get-Content $mappingTreePath | ConvertFrom-Json
$lessonFiles = @(Get-ChildItem -Path $lessonDir -Filter "exo_lesson_*.md" -ErrorAction SilentlyContinue)

foreach ($file in $lessonFiles) {
    $lines = Get-Content $file.FullName
    $lessonId = ($lines | Where-Object { $_ -match "\*\*Lesson ID\*\*" }) -replace '.*\*\*Lesson ID\*\*: ', ''
    $result   = ($lines | Where-Object { $_ -match "\*\*Result\*\*" }) -replace '.*\*\*Result\*\*: ', ''
    $pipeline = ($lines | Where-Object { $_ -like "- Pipeline Name:*" }) -replace '- Pipeline Name: ', ''
    $contextId = "pipeline:$pipeline"

    $node = $mappingTree | Where-Object { $_.nodeId -eq $contextId }
    if ($node) {
        if (-not $node.PSObject.Properties.Match('lessons')) { $node | Add-Member -NotePropertyName "lessons" -NotePropertyValue @() }
        if ($node.lessons -notcontains $lessonId) { $node.lessons += $lessonId }
        $node.lastLearned = (Get-Date).ToString("s")
    }

    $telemetryEntry = @{
        timestamp   = (Get-Date).ToString("s")
        contextId   = $contextId
        learnedFrom = $lessonId
        signal      = if ($result -like "*Success*") { "Positive" } else { "Failure" }
        tags        = @("!LEARNED", "auto:inferred")
        insight     = "Exo learned from $lessonId → result: $result"
    }
    $telemetryEntry | ConvertTo-Json -Depth 5 | Add-Content -Path $telemetryPath
}
$mappingTree | ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 -Path $mappingTreePath
Write-Host "`n🧠 Exo learn completed."
Write-Host "📘 Lessons scanned: $($lessonFiles.Count)"
Write-Host "🧭 MappingTree updated: $mappingTreePath"
Write-Host "📡 Telemetry frames logged: $telemetryPath"
