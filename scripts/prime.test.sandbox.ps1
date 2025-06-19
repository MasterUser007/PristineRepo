Set-Location (git rev-parse --show-toplevel)
Write-Host "🧪 Running Prime Reflex Sandbox Validation"

if (Test-Path "scripts/prime.archetype.compare.ps1") {
  pwsh scripts/prime.archetype.compare.ps1 -oldRef HEAD~1 -newRef HEAD
  Write-Host "✅ Archetype diff passed"
} else {
  Write-Error "🚨 Missing: prime.archetype.compare.ps1"
}

if (Test-Path "prime.flush.mesh.ps1") {
  pwsh ./prime.flush.mesh.ps1
  Write-Host "✅ Doc regeneration passed"
} else {
  Write-Error "🚨 Missing: prime.flush.mesh.ps1"
}

if (Test-Path "archetype.docs.md") {
  Write-Host "📘 Refreshed archetype.docs.md found"
} else {
  Write-Error "❌ archetype.docs.md missing"
}
