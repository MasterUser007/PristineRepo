param (
  [switch]$DryRun
)
& {
  $wfDir = ".github/workflows"
  $marker = "# 🔒 Deprecated by ReflexOps"
  $cacheFile = ".github/reflexops/.tombstone-cache.json"
  $badgeFile = ".github/reflexops/.reflexops-badge.md"
  $readmePath = "README.md"
  $tombstoned = @("prime.automation.yml", "ci_cd_fresh.yml", "prime.sdlc.flowmap.yml", "self_healing.yml")
  $currentState = @{}
  $timestamp = if ($env:BADGE_TIMESTAMP) { $env:BADGE_TIMESTAMP } else { (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") }

  if (-not (Test-Path ".github/reflexops")) {
    New-Item -ItemType Directory -Path ".github/reflexops" | Out-Null
  }

  foreach ($file in $tombstoned) {
    $path = Join-Path $wfDir $file
    if (Test-Path $path) {
      $content = Get-Content $path -Raw
      $isTombstoned = $content -match [regex]::Escape($marker)
      $currentState[$file] = $isTombstoned

      if (-not $isTombstoned) {
        Write-Host "🛠️ Tombstoning required: $file"
        if (-not $DryRun) {
@"
$marker
name: Tombstoned: $file
on:
  workflow_dispatch:
jobs:
  tombstone:
    if: always()
    runs-on: ubuntu-latest
    steps:
      - run: echo '🪦 $file has been deprecated by ReflexOps.'
"@ | Set-Content $path -Encoding UTF8
        }
      } else {
        Write-Host "✅ Already tombstoned: $file"
      }
    } else {
      Write-Warning "⚠️ $file missing—skipped."
    }
  }

  if (-not $DryRun) {
    $currentState | ConvertTo-Json -Depth 3 | Set-Content $cacheFile -Encoding UTF8
  }

  $allGood = ($currentState.Values | Where-Object { $_ -eq $false }).Count -eq 0
  $badge = if ($allGood) {
@"
### ✅ All deprecated workflows tombstoned

![Tombstone Verified](https://img.shields.io/badge/ReflexOps--Tombstones-Verified-28a745?style=for-the-badge)

_Last verified: $timestamp UTC_
"@
  } else {
@"
### ❌ ReflexOps Tombstone Audit Incomplete

![Tombstones Missing](https://img.shields.io/badge/ReflexOps--Tombstones-Missing-critical?style=for-the-badge)

_Last checked: $timestamp UTC_
"@
  }

  if (-not $DryRun) {
    $badge | Set-Content $badgeFile -Encoding UTF8
  }

  if (-not $DryRun -and (Test-Path $readmePath)) {
    $readme = Get-Content $readmePath -Raw
    $newReadme = $readme -replace "(?s)<!-- reflexops:start -->.*?<!-- reflexops:end -->", @"
<!-- reflexops:start -->
$badge
<!-- reflexops:end -->
"@
    Set-Content $readmePath $newReadme -Encoding UTF8
  }

  if (-not $DryRun) {
    git add $wfDir/* $cacheFile $badgeFile $readmePath 2>$null
    if (-not (git diff --cached --quiet)) {
      git commit -m "🛡️ ReflexTombstoneGuard: audit + badge update"
      git push
    } else {
      Write-Host "🧼 No changes to commit."
    }
  }

  if (-not $allGood) {
    Write-Error "`n❌ Audit failed: one or more workflows need tombstoning."
    exit 1
  } else {
    Write-Host "`n✅ ReflexOps audit passed. Integrity maintained."
  }
}
