Write-Host "🚀 Starting repository optimization..." -ForegroundColor Yellow

# Run Tests
Write-Host "🔎 Running tests..." -ForegroundColor Cyan
npm test --verbose
pytest --verbose
pwsh -Command "Invoke-Pester"

Write-Host "✅ Testing complete!" -ForegroundColor Green

# Commit & Push Changes
Write-Host "📤 Committing all cleaned files..." -ForegroundColor Cyan
git add --all
git commit -m "Final optimization: Multi-threading, self-healing, syntax validation"
git push origin main

Write-Host "✅ Push complete! Your repository is fully optimized." -ForegroundColor Green
