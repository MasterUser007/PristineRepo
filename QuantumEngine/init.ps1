Write-Host '🚀 Launching QuantumEngine...'
\ = '..\..\symbolic-cache\symbolize.ps1'
if (Test-Path \) {
  & \ -EventType 'init' -EngineId 'QuantumEngine' -Details 'Boot complete. Linked to symbolic mesh.'
}
Start-Job { while (\True) {
  & '..\..\symbolic-cache\symbolize.ps1' -EventType 'ping' -EngineId 'QuantumEngine' -Details 'Heartbeat from generator node'
  Start-Sleep -Seconds 300
} } | Out-Null
Write-Host '🧬 QuantumEngine ready.'
