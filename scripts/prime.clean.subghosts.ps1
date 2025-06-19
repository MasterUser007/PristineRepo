Set-Location (git rev-parse --show-toplevel)

\ = @()
\ = ".gitmodules"
\ = ".git/config"

\ = git status --short | Where-Object { \ -match "modified:.*(new commits|content)" } | ForEach-Object {
  (\ -split " ")[-1]
}

foreach (\ in \) {
  if (Test-Path "\/.git") {
    \ += \
  }
}

if (Test-Path \) {
  Remove-Item \ -Force
  Write-Host "🧹 Removed .gitmodules"
}

\ = Get-Content \
foreach (\ in \) {
  \ = "submodule.\"
  if (\ -match \) {
    \ = \ | Where-Object { \ -notmatch \ }
    Write-Host "🧼 Removed config section: \"
  }
}
\ | Set-Content \

foreach (\ in \) {
  Remove-Item -Recurse -Force \ -ErrorAction SilentlyContinue
  Write-Host "🗑️ Purged ghost folder \"
}

git add -A
\20250619-174923 = Get-Date -Format "yyyyMMdd-HHmmss"
git commit -m "🧽 Auto-cleaned submodule ghosts (\20250619-174923)"
git push
