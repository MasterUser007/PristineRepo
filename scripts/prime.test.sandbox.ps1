Set-Location (git rev-parse --show-toplevel)
Write-Host "🧪 Validating Reflex Patch in Sandbox"

if (Test-Path "scripts/prime.archetype.compare.ps1") {
  pwsh scripts/prime.archetype.compare.ps1 -oldRef HEAD~1 -newRef HEAD
  Write-Host "✅ Diff script passed"
} else {
  Write-Error "🚨 Missing prime.archetype.compare.ps1"
}

if (Test-Path "prime.flush.mesh.ps1") {
  pwsh ./prime.flush.mesh.ps1
  Write-Host "✅ Doc regen passed"
} else {
  Write-Error "🚨 Missing prime.flush.mesh.ps1"
}

if (Test-Path "archetype.docs.md") {
  Write-Host "📘 archetype.docs.md present"
} else {
  Write-Error "❌ Missing archetype.docs.md"
}
