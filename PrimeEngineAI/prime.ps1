param (
  [Parameter(Position = 0)]
  [string]$Command,

  [Parameter(ValueFromRemainingArguments = $true)]
  [object[]]$Args
)

$tools = @{
  sync         = ".\prime.sync.ps1"
  doctor       = ".\prime.doctor.ps1"
  'new-engine' = ".\prime.new-engine.ps1"
  'emit-fix'   = ".\prime.emit-fix.ps1"
  seed         = ".\prime.seed.ps1"
}

if (-not $Command -or $Command -in @("help", "-h", "--help")) {
@"
🧠 PrimeEngine CLI

Usage:
  .\prime.ps1 <command> [args]

Commands:
  sync         Sync registry, engines, and emit heartbeat
  doctor       Run engine health scan
  new-engine   Scaffold engine (use -EngineId)
  emit-fix     Save fix logic to KB (use -Engine, -FixId, -Script)
  seed         Reinstall and index all prime tools

Examples:
  .\prime.ps1 sync
  .\prime.ps1 new-engine -EngineId vision
  .\prime.ps1 emit-fix -Engine ai -FixId reboot-core -Script { ... }

"@ | Write-Host
  exit 0
}

if ($tools.ContainsKey($Command)) {
  & $tools[$Command] @Args
} else {
  Write-Warning "❌ Unknown command: $Command"
  Write-Host "Use '.\prime.ps1 help' to see available commands."
}
