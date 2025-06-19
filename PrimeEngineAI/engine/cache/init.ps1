Write-Host '🔧 [cache] Bootstrapping engine parity...'
if (-not (Test-Path '.support_kb')) {
  New-Item -ItemType Directory -Path '.support_kb' -Force | Out-Null
  Write-Host '📦 Created root .support_kb'
}
Write-Host '✅ [cache] Initialization complete.'
