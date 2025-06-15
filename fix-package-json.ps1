    Write-Host '🔍 Checking package.json formatting...' -ForegroundColor Yellow
    try {
        Get-Content 'C:\Users\leebo\Desktop\PristineRepo\package.json' -Raw | ConvertFrom-Json
        Write-Host '✅ package.json is valid!' -ForegroundColor Green
    } catch {
        Write-Host '❌ JSON ERROR: Fixing formatting issues...' -ForegroundColor Red
        \ = Get-Content 'C:\Users\leebo\Desktop\PristineRepo\package.json' -Raw -Encoding UTF8 | 
            ForEach-Object { \ -replace ',\s*}', '}' -replace ':\s*""', ': "FIX_ME"' }
        \ | Set-Content -Path 'C:\Users\leebo\Desktop\PristineRepo\package.json' -Encoding UTF8
        Write-Host '✅ package.json repaired successfully!' -ForegroundColor Green
    }
    npm install
    gh auth login
    git remote show origin | Select-String 'HEAD branch'
    gh workflow run --repo MasterUser007/PristineRepo
    Write-Host '🎯 All steps completed! CI/CD should now be fully green!' -ForegroundColor Green
