# bootstrap.ps1 – Clone & Setup
param(
  [string]\ = 'https://github.com/MasterUser007/PristineRepo.git',
  [string]\ = 'PristineRepo'
)

git clone --recursive \ \
Set-Location \
if (Test-Path 'package.json') { npm ci }
git submodule update --init --recursive
.\scripts\pristine.ps1
Write-Host '✅ Bootstrapped and ready.'
