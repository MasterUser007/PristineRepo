# ======
#   Pavi-Dashboard.ps1
#   All-Inclusive Terminal Dashboard (Dark Mode)
# ======

function Show-PaviDashboard {
    Clear-Host
    $headerFg = "Cyan"
    $statFg   = "Gray"
    $warnFg   = "Yellow"
    $errorFg  = "Red"
    $goodFg   = "Green"
    $accentFg = "DarkCyan"

    # Header
    Write-Host ("="*70) -ForegroundColor DarkGray
    Write-Host "          EXOSUITE: PAVI PROJECT STATUS DASHBOARD" -ForegroundColor $headerFg
    Write-Host ("="*70) -ForegroundColor DarkGray

    # Test Suite Status
    Write-Host "`n[TEST & QA]" -ForegroundColor $accentFg
    $testLines = Get-Content "pavi_chatbox.log" -ErrorAction SilentlyContinue | Select-String -Pattern "test|pytest|coverage|PowerShell test" | Select-Object -Last 5
    if ($testLines) { foreach ($l in $testLines) { Write-Host "  $($l.Line)" -ForegroundColor $statFg } }
    else { Write-Host "  No recent test activity found." -ForegroundColor $warnFg }

    # Automation Status
    Write-Host "`n[AUTOMATION & REMEDIATION]" -ForegroundColor $accentFg
    $autoLines = Get-Content "pavi_chatbox.log" -ErrorAction SilentlyContinue | Select-String -Pattern "remediation|remediated|fixed|created|auto" | Select-Object -Last 5
    if ($autoLines) { foreach ($l in $autoLines) { Write-Host "  $($l.Line)" -ForegroundColor $statFg } }
    else { Write-Host "  No recent automation or remediation logged." -ForegroundColor $warnFg }

    # System Health
    Write-Host "`n[ENVIRONMENT HEALTH]" -ForegroundColor $accentFg
    $freeSpace = [math]::Round((Get-PSDrive -Name C).Free/1GB,2)
    $usedMemory = [math]::Round((Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize/1MB - (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory/1MB,2)
    Write-Host ("  Disk Free: $freeSpace GB") -ForegroundColor $statFg
    Write-Host ("  Used Memory: $usedMemory MB") -ForegroundColor $statFg

    # Dependency Health
    Write-Host "`n[DEPENDENCY & CONFIG HEALTH]" -ForegroundColor $accentFg
    $reqs = Get-Content "requirements.txt" -ErrorAction SilentlyContinue
    if ($reqs) { Write-Host ("  requirements.txt: $($reqs.Count) entries") -ForegroundColor $statFg }
    else { Write-Host "  requirements.txt missing or empty!" -ForegroundColor $warnFg }

    # Recent Learning/Actions
    Write-Host "`n[LEARNING & ACTIONS]" -ForegroundColor $accentFg
    $learnings = Get-Content "pavi_learning_log.md" -ErrorAction SilentlyContinue | Select-String -Pattern "\*\*" | Select-Object -Last 3
    if ($learnings) { foreach ($l in $learnings) { Write-Host "  $($l.Line)" -ForegroundColor $statFg } }
    else { Write-Host "  No recent learning log entries." -ForegroundColor $warnFg }

    # Active Tasks/Jobs
    Write-Host "`n[ACTIVE TASKS]" -ForegroundColor $accentFg
    $activeTasks = Get-Content "pavi_chatbox.log" -ErrorAction SilentlyContinue | Select-String -Pattern "starting|initiated|in progress" | Select-Object -Last 5
    if ($activeTasks) { foreach ($l in $activeTasks) { Write-Host "  $($l.Line)" -ForegroundColor $statFg } }
    else { Write-Host "  All jobs complete. Standing by." -ForegroundColor $goodFg }

    Write-Host ("="*70) -ForegroundColor DarkGray
    Write-Host "Last updated: $(Get-Date)" -ForegroundColor DarkGray
}

Show-PaviDashboard
