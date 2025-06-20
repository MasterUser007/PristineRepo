param (
  [switch]$DryRun,
  [switch]$SkipCleanup
)
& {
  $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
  $sandboxBranch = "sandbox/reflex-$timestamp"
  $repo = "MasterUser007/PristineRepo"
  $env:BADGE_TIMESTAMP = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

  git stash push -m "Pre-sandbox stash" 2>$null | Out-Null
  git switch -c $sandboxBranch | Out-Null

  $guardScript = Get-ChildItem -Path . -Recurse -Filter "ReflexTombstoneGuard.ps1" -File |
    Where-Object { $_.FullName -notmatch "\\.git\\" } |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

  if (-not $guardScript) {
    Write-Error "❌ ReflexTombstoneGuard.ps1 not found. Abort."
    git switch main | Out-Null
    git branch -D $sandboxBranch | Out-Null
    git stash pop 2>$null | Out-Null
    return
  }

  & $guardScript.FullName -DryRun:$DryRun

  git add .github/* README.md scripts/*.ps1 2>$null
  if (-not (git diff --cached --quiet)) {
    git commit -m "🧪 ReflexSandboxRunner: simulate full ReflexOps audit"
    git push --set-upstream origin $sandboxBranch | Out-Null
    Write-Host "`n🚀 Sandbox branch '$sandboxBranch' pushed for CI."
  } else {
    Write-Host "`n🧼 No changes to commit in sandbox."
  }

  if (-not $SkipCleanup) {
    git switch main | Out-Null
    git branch -D $sandboxBranch 2>$null | Out-Null
    git stash pop 2>$null | Out-Null
    Write-Host "`n🧹 Sandbox branch '$sandboxBranch' removed. Repo restored."
  } else {
    Write-Host "`n🧾 Sandbox branch '$sandboxBranch' preserved."
  }

  Write-Host "`n🛡️ ReflexSandboxRunner: simulation complete."
}
