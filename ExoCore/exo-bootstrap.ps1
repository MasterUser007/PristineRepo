# === EXO BOOTSTRAP CHECK ===
\ = aws s3api head-object --bucket exocore-memory --key Lessons/init_seed_marker.md 2>&1
if (\ -match "Not Found") {
  Write-Host "🚀 Cold start detected—hydrating memory..."
  pwsh "C:\Users\leebo\Documents\ExoCore\exo-sync.ps1"
  '## Cold start memory provisioned' | Set-Content init_seed_marker.md
  aws s3 cp init_seed_marker.md s3://exocore-memory/Lessons/
  Remove-Item init_seed_marker.md
} else {
  Write-Host "✅ Memory already initialized"
}
