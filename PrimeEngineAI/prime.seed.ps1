$tools = @(
  @{ name = "prime.sync.ps1"; desc = "Synchronizes engine registry, emits heartbeat, heals drift" },
  @{ name = "prime.doctor.ps1"; desc = "Scans and reports health of all engines" },
  @{ name = "prime.emit-fix.ps1"; desc = "Adds fix logic into an engine’s KB and updates manifest" },
  @{ name = "prime.new-engine.ps1"; desc = "Scaffolds a new engine with full parity structure" }
)

$kbDir = ".support_kb\\prime_tools"
$index = @()
New-Item -ItemType Directory -Force -Path $kbDir | Out-Null

foreach ($tool in $tools) {
  $path = ".\\$($tool.name)"
  if (-not (Test-Path $path)) {
    Write-Warning "Tool missing: $($tool.name). Please create it before seeding."
    continue
  }

  Copy-Item $path "$kbDir\\$($tool.name)" -Force

  @"
# Tool: $($tool.name)

**Description:** $($tool.desc)

**Usage:**
.\\$($tool.name)

**Location:** $path
"@ | Out-File "$kbDir\\$($tool.name).help.md" -Encoding utf8

  $index += @{
    tool        = $tool.name
    description = $tool.desc
    lastUpdated = (Get-Date -Format s)
    kbPath      = "$kbDir\\$($tool.name)"
  }
}

$index | ConvertTo-Json -Depth 5 | Out-File "$kbDir\\support-index.json" -Encoding utf8
Write-Host "`n✅ PrimeEngine tool suite seeded into .support_kb\\prime_tools/"
