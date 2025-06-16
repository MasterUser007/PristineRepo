Write-Host '🚀 Deploying CI/CD workflow...'

# Validate Dependencies
 = @('git', 'docker', 'kubectl')
foreach ( in ) {
    if (!(Get-Command  -ErrorAction SilentlyContinue)) {
        Write-Host "❌ Missing dependency: "
        exit 1
    }
}

# Start Deployment
Write-Host '📡 Pushing latest commits...'
git push origin main

Write-Host '🔄 Running CI/CD pipelines...'
./ci_startup_script.sh

Write-Host '✅ CI/CD deployment completed!'
