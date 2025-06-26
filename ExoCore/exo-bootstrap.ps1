# === EXO BOOTSTRAP CHECK ===
\ = aws s3api head-object --bucket exocore-memory --key Lessons/init_seed_marker.md 2>&1
if (\ -match "Not Found") {
  Write-Host "🚀 Cold start detected—hydrating memory..."
  pwsh .\exo-sync.ps1
  'Memory seeded on cold start' | Set-Content init_seed_marker.md
  aws s3 cp init_seed_marker.md s3://exocore-memory/Lessons/
  Remove-Item init_seed_marker.md
} else {
  Write-Host "✅ Memory already initialized"
}
