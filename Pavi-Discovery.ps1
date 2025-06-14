# 
#    Pavi-Discovery.ps1
#    Full Ecosystem Scanner & Next Steps Generator
#    Place in your project root. Run with pwsh.
# 

function Start-PaviOpenChat {
    param([string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "`n[$(Get-Date)] Pavi Open Chat Started: Ecosystem Discovery Mode"
}
function Write-PaviOpenChat {
    param([string]$Message, [string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "[$(Get-Date)] $Message"
}
function End-PaviOpenChat {
    param([string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "[$(Get-Date)] Pavi Open Chat Ended."
}

# Start the discovery session
Start-PaviOpenChat
Write-PaviOpenChat -Message "Beginning full-system discovery of all project artifacts, folders, and code."

# Optimized extension-based inventory
$extensions = @(".py",".ps1",".md",".json",".yml",".toml",".csv",".sh",".exe")
$files = Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue

foreach ($file in $files) {
    if ($extensions -contains $file.Extension.ToLower()) {
        Write-PaviOpenChat -Message "Found $($file.Extension) file: $($file.FullName)"
    }
}

# Log major directories
$folders = Get-ChildItem -Directory -Force
foreach ($folder in $folders) {
    Write-PaviOpenChat -Message "Detected major directory: $($folder.Name)"
}

# Find empty and stale files
$now = Get-Date
$emptyFiles = $files | Where-Object { $_.Length -eq 0 }
$stale = $files | Where-Object { ($now - $_.LastWriteTime).Days -gt 90 }
foreach ($file in $emptyFiles) {
    Write-PaviOpenChat -Message "Empty file detected: $($file.FullName)"
}
foreach ($file in $stale) {
    Write-PaviOpenChat -Message "Stale or old file: $($file.FullName) last updated $($file.LastWriteTime)"
}

# Python module health: check for __init__.py
$pyFolders = Get-ChildItem -Recurse -Directory | Where-Object { Test-Path "$($_.FullName)\*.py" }
foreach ($folder in $pyFolders) {
    if (-not (Test-Path "$($folder.FullName)\__init__.py")) {
        Write-PaviOpenChat -Message "Python module folder missing __init__.py: $($folder.FullName)"
    }
}

# Generate actionable next steps
$nextSteps = @()
if ($pyFolders | Where-Object { -not (Test-Path "$($_.FullName)\__init__.py") }) {
    $nextSteps += "Add missing __init__.py files to all Python package directories."
}
if ($emptyFiles.Count -gt 0) {
    $nextSteps += "Review and clean up empty or placeholder files."
}
if ($stale.Count -gt 0) {
    $nextSteps += "Archive or review files not modified in over 90 days."
}
if (-not (Test-Path ".\README.md")) { $nextSteps += "Add a top-level README.md for project documentation." }
if (-not (Test-Path ".\pyproject.toml")) { $nextSteps += "Add or validate pyproject.toml for Python packaging." }
if (-not (Test-Path ".\tests")) { $nextSteps += "Create or populate tests directory with proper test cases." }
if (-not (Test-Path ".\requirements.txt")) { $nextSteps += "Ensure requirements.txt exists and matches your dependencies." }
$nextSteps += "Review pavi_chatbox.log and pavi_chat_log.txt after every major session."
$nextSteps += "Ensure Pavi-AutoOps.ps1 is scheduled to run daily for ongoing DevOps maintenance."

Write-PaviOpenChat -Message "== Pavi's Deep Dive Next Steps =="
$i = 1
foreach ($step in $nextSteps) {
    Write-PaviOpenChat -Message ("{0}. {1}" -f $i, $step)
    $i++
}
Write-Host "== Pavi's Deep Dive: Next Steps =="
$nextSteps | ForEach-Object { Write-Host $_ }

End-PaviOpenChat
