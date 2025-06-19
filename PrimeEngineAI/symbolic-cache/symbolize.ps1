param (
  [Parameter(Mandatory = $true)][string]$EventType,
  [Parameter(Mandatory = $true)][string]$EngineId,
  [Parameter(Mandatory = $true)][string]$Details
)

$timestamp = (Get-Date).ToUniversalTime().ToString("u")
$entry = @{
  Timestamp = $timestamp
  Engine    = $EngineId
  Type      = $EventType
  Detail    = $Details
}

# --- [1] Log to synapse.log ---
$logPath = "$PSScriptRoot\synapse.log"
$log = @()
if (Test-Path $logPath) {
  try {
    $parsed = Get-Content $logPath -Raw | ConvertFrom-Json -ErrorAction Stop
    $log = @(if ($parsed -is [System.Collections.IEnumerable]) { $parsed } else { @() })
  } catch {
    Write-Warning "⚠️ synapse.log is malformed. Starting fresh."
  }
}
$log = $log + $entry
$log | ConvertTo-Json -Depth 5 | Set-Content $logPath -Encoding utf8

# --- [2] Append to graph if edge ---
if ($EventType -eq "edge" -and $Details -match "^(\w+)-->(\w+):\s*(.+)$") {
  $graphPath = "$PSScriptRoot\cache.graph.json"
  $edgeEntry = @{
    Timestamp = $timestamp
    From      = $Matches[1]
    To        = $Matches[2]
    Message   = $Matches[3]
  }

  $edges = @()
  if (Test-Path $graphPath) {
    try {
      $existing = Get-Content $graphPath -Raw | ConvertFrom-Json -ErrorAction Stop
      $edges = @(if ($existing -is [System.Collections.IEnumerable]) { $existing } else { @() })
    } catch {
      Write-Warning "⚠️ cache.graph.json is malformed. Starting fresh."
    }
  }

  $edges = $edges + $edgeEntry
  $edges | ConvertTo-Json -Depth 5 | Set-Content $graphPath -Encoding utf8
}

Write-Host "🧠 [$EngineId][$EventType] → $Details" -ForegroundColor Cyan
