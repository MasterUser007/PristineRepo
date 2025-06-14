Write-Host '=== Git Clean Push Automation ==='

Write-Host 'Please ensure all editors, terminals, and antivirus are closed or disabled for the repo folder.'
Write-Host 'Press Enter to continue or Ctrl+C to cancel.'
Read-Host

$dirsToRemove = @(
    '.git\objects\04',
    '.git\objects\08',
    '.git\objects\0c',
    '.git\objects\21',
    '.git\objects\46'
)

foreach ($dir in $dirsToRemove) {
    if (Test-Path $dir) {
        try {
            Remove-Item -Path $dir -Recurse -Force -ErrorAction Stop
            Write-Host "Removed $dir"
        }
        catch {
            Write-Warning "Failed to remove $dir - it may be locked by another process."
        }
    }
    else {
        Write-Host "$dir does not exist."
    }
}

Write-Host 'Running git garbage collection...'
try {
    git gc --prune=now
    Write-Host 'Git garbage collection completed.'
}
catch {
    Write-Warning 'Git garbage collection failed. Please reboot and try again.'
    exit 1
}

git add .
Write-Host 'All changes staged.'

$msg = Read-Host 'Enter commit message'
if (-not $msg) {
    $msg = 'Clean commit after repository cleanup'
}

git commit -m $msg
Write-Host 'Committed changes.'

Write-Host 'Pushing to remote repository...'
git push origin main
Write-Host 'Push complete.'

Write-Host '=== Git Clean Push Automation Finished ==='
