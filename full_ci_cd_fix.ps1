# Navigate to the correct project directory
Set-Location "C:\Users\leebo\OneDrive\Desktop\File_Backups\20250612-162837\src\exosuite-optimized"

# Verify required dependencies (Node.js, npm, GitHub CLI)
Write-Host "🔍 Checking required dependencies..."
$missingDeps = @("npm", "gh", "git") | Where-Object { -not (Get-Command $_ -ErrorAction SilentlyContinue) }
if ($missingDeps.Count -gt 0) {
    Write-Host "❌ Missing dependencies: $($missingDeps -join ', ') - Install required tools before proceeding!"
    Exit
}

# Create the missing script file if it doesn't exist
Write-Host "📜 Creating 'update_ci_cd.ps1' file..."
$scriptPath = "C:\Users\leebo\OneDrive\Desktop\File_Backups\20250612-162837\src\exosuite-optimized\update_ci_cd.ps1"
if (-not (Test-Path $scriptPath)) {
    New-Item -Path $scriptPath -ItemType File
}

# Locate the GitHub Actions workflow YAML file
$workflowFile = ".github/workflows/automated_bug_fix_ci_cd.yml"
if (-not (Test-Path $workflowFile)) {
    Write-Host "❌ Workflow file not found! Please verify the correct filename."
    Exit
}

# Add 'workflow_dispatch' trigger if missing
Write-Host "🔄 Updating GitHub Actions workflow to allow manual trigger..."
$workflowContent = Get-Content $workflowFile
if ($workflowContent -notmatch "workflow_dispatch") {
    $updatedContent = $workflowContent -replace "on:", "on:`n  workflow_dispatch:"
    $updatedContent | Set-Content $workflowFile
}

# Commit and push changes to GitHub
Write-Host "📜 Committing & pushing workflow updates..."
git add $workflowFile
git commit -m "Enable workflow_dispatch for manual triggering"
git push origin main

# Fetch latest failed CI/CD runs
Write-Host "📜 Fetching recent failed CI/CD runs..."
gh run list --repo MasterUser007/PristineRepo --limit 5 | Out-File -Encoding utf8 ci_cd_debug.log

# Check Jest configuration conflicts
Write-Host "🔍 Checking for multiple Jest config files..."
$jestConfigJs = Test-Path jest.config.js
$jestConfigJson = Test-Path jest.config.json

if ($jestConfigJs -and $jestConfigJson) {
    Write-Host "⚠️ Multiple Jest config files detected! Removing 'jest.config.json'..."
    Remove-Item jest.config.json -Force
}

# Verify npm dependencies
Write-Host "📦 Checking installed dependencies..."
npm list --depth=0 | Out-File -Encoding utf8 npm_dependency_check.log

# Install missing Jest dependency
Write-Host "🔄 Installing Jest..."
npm install jest@^30.0.0 --save-dev | Out-File -Encoding utf8 npm_install.log

# Clean npm cache
Write-Host "🧹 Cleaning npm cache to resolve issues..."
npm cache clean --force

# Resolve outdated modules
Write-Host "⚠️ Running npm audit fix..."
npm audit fix --force | Out-File -Encoding utf8 npm_audit_fix.log

# Run the best CI/CD workflow
Write-Host "🚀 Running 'Automated Bug Fix & CI/CD' workflow..."
gh workflow run "Automated Bug Fix & CI/CD" --repo MasterUser007/PristineRepo | Out-File -Encoding utf8 ci_cd_rerun.log

Write-Host "✅ CI/CD workflow updated & triggered successfully!"
