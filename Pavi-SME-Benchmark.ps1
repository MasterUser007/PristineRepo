# =====
#    Pavi-SME-Benchmark.ps1
#    SME Audit, Auto-Fix, and Performance Score
#    Place in your project root. Run with pwsh.
# =====

function Start-PaviOpenChat {
    param([string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "`n[$(Get-Date)] Pavi Open Chat Started: SME Benchmark"
}
function Write-PaviOpenChat {
    param([string]$Message, [string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "[$(Get-Date)] $Message"
}
function End-PaviOpenChat {
    param([string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "[$(Get-Date)] Pavi Open Chat Ended."
}

function Pavi-ProactiveFixes {
    Write-PaviOpenChat -Message "Auto-fix routine started."
    $fixCount = 0
    # Fix missing __init__.py in python modules
    $pyFolders = Get-ChildItem -Recurse -Directory | Where-Object { Test-Path "$($_.FullName)\*.py" }
    foreach ($folder in $pyFolders) {
        $initPath = "$($folder.FullName)\__init__.py"
        if (-not (Test-Path $initPath)) {
            Set-Content -Path $initPath -Value "# Auto-created by Pavi SME Benchmark"
            Write-PaviOpenChat -Message "Created missing __init__.py in $($folder.FullName)"
            $fixCount++
        }
    }
    # Fix empty README.md
    if ((-not (Test-Path ".\README.md")) -or ((Get-Content ".\README.md" -Raw -ErrorAction SilentlyContinue).Trim() -eq "")) {
        Set-Content -Path ".\README.md" -Value "# Project Documentation`n_Auto-created by Pavi SME Benchmark_"
        Write-PaviOpenChat -Message "Created or filled in README.md"
        $fixCount++
    }
    Write-PaviOpenChat -Message "Auto-fix routine complete. Fixes applied: $fixCount"
    return $fixCount
}

function Test-PaviSMEReadiness {
    Start-PaviOpenChat
    Write-PaviOpenChat -Message "=== Pavi SME Readiness Test: BEGIN ==="

    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $checks = @()
    $issues = @()
    $benchmarks = @{}

    # 1. Essential File Presence
    $essentials = @("README.md", "pyproject.toml", "requirements.txt", "pavi_chatbox.log", "Pavi-AutoOps.ps1")
    foreach ($file in $essentials) {
        if (Test-Path ".\$file") {
            Write-PaviOpenChat -Message "Essential file present: $file"
            $checks += $file
        } else {
            Write-PaviOpenChat -Message "MISSING essential file: $file"
            $issues += "Missing $file"
        }
    }

    # 2. Python Package Hygiene (init files)
    $pyFolders = Get-ChildItem -Recurse -Directory | Where-Object { Test-Path "$($_.FullName)\*.py" }
    $pyInitIssues = 0
    foreach ($folder in $pyFolders) {
        if (-not (Test-Path "$($folder.FullName)\__init__.py")) {
            Write-PaviOpenChat -Message "Python module folder missing __init__.py: $($folder.FullName)"
            $issues += "Missing __init__.py in $($folder.FullName)"
            $pyInitIssues++
        }
    }

    # 3. Empty & Stale File Scan
    $files = Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue
    $emptyFiles = $files | Where-Object { $_.Length -eq 0 }
    $stale = $files | Where-Object { ((Get-Date) - $_.LastWriteTime).Days -gt 90 }
    foreach ($f in $emptyFiles) {
        Write-PaviOpenChat -Message "Empty file: $($f.FullName)"
        $issues += "Empty file: $($f.FullName)"
    }
    foreach ($f in $stale) {
        Write-PaviOpenChat -Message "Stale file: $($f.FullName)"
        $issues += "Stale file: $($f.FullName)"
    }

    # 4. Auto-Fix Attempt (if issues found)
    $autoFixAttempted = $false
    $autoFixCount = 0
    if ($issues.Count -gt 0) {
        Write-PaviOpenChat -Message "Issues detected, attempting auto-fixes (where possible)..."
        $autoFixCount = Pavi-ProactiveFixes
        $autoFixAttempted = $true
    }

    # 5. Benchmark
    $stopwatch.Stop()
    $benchmarks["EssentialFilesPresent"] = $checks.Count
    $benchmarks["IssuesDetected"] = $issues.Count
    $benchmarks["AutoFixAttempted"] = $autoFixAttempted
    $benchmarks["AutoFixesApplied"] = $autoFixCount
    $benchmarks["PythonModuleCount"] = $pyFolders.Count
    $benchmarks["PythonInitMissing"] = $pyInitIssues
    $benchmarks["EmptyFilesFound"] = $emptyFiles.Count
    $benchmarks["StaleFilesFound"] = $stale.Count
    $benchmarks["Timestamp"] = (Get-Date)
    $benchmarks["RunTimeSeconds"] = [Math]::Round($stopwatch.Elapsed.TotalSeconds, 2)

    # 6. Verdict & Summary
    $battleReady = ($benchmarks["EssentialFilesPresent"] -eq $essentials.Count) -and ($benchmarks["PythonInitMissing"] -eq 0) -and ($benchmarks["IssuesDetected"] -eq 0)
    $verdict = if ($battleReady) {"✅ Pavi is BATTLE READY as SME."} else {"❌ Pavi needs remediation before SME status."}
    $summary = @"
[SME Readiness Benchmark Complete]
Essential files present: $($benchmarks["EssentialFilesPresent"])/$($essentials.Count)
Python module folders: $($benchmarks["PythonModuleCount"])
Missing __init__.py: $($benchmarks["PythonInitMissing"])
Empty files found: $($benchmarks["EmptyFilesFound"])
Stale files found: $($benchmarks["StaleFilesFound"])
Auto-fix attempted: $($benchmarks["AutoFixAttempted"])
Auto-fixes applied: $($benchmarks["AutoFixesApplied"])
Issues detected: $($benchmarks["IssuesDetected"])
Run time: $($benchmarks["RunTimeSeconds"]) seconds
Timestamp: $($benchmarks["Timestamp"])

$verdict
"@

    Write-PaviOpenChat -Message $summary
    Write-PaviOpenChat -Message "=== Pavi SME Readiness Test: END ==="
    End-PaviOpenChat

    # Output summary to user
    if ($battleReady) {
        Write-Host $summary -ForegroundColor Green
    } else {
        Write-Host $summary -ForegroundColor Yellow
        Write-Host "See issues above and pavi_chatbox.log for full details." -ForegroundColor Yellow
    }
}

# === RUN THE SME BENCHMARK ===
Test-PaviSMEReadiness
