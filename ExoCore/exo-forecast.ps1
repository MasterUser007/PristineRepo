# === EXO FORECAST ===
Write-Host "📡 Running forecast analysis..."
New-Item -Path "\\..\Lessons" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
\ = Get-ChildItem "\\..\Lessons" -Filter "exo_lesson_*.md" | Sort-Object LastWriteTime -Descending | Select-Object -First 5
foreach (\ in \) {
  \version: 0.2  phases:   install:     runtime-versions:       python: 3.8     commands:       - echo "🔧 Installing PowerShell Core"       - curl -sSL https://aka.ms/install-powershell.sh | bash       - pwsh -Command "$PSVersionTable.PSVersion"    build:     commands:       - echo "🧠 Running Exo cognition cycle..."       - pwsh ExoCore/exo-learn.ps1       - pwsh ExoCore/exo-advise.ps1
      - pwsh ExoCore/exo-selftest.ps1  artifacts:   files:     - ExoCore/MappingTree/*     - ExoCore/Telemetry/*     - ExoCore/Lessons/*     - ExoCore/README.md = Get-Content \.FullName
  if (\version: 0.2  phases:   install:     runtime-versions:       python: 3.8     commands:       - echo "🔧 Installing PowerShell Core"       - curl -sSL https://aka.ms/install-powershell.sh | bash       - pwsh -Command "$PSVersionTable.PSVersion"    build:     commands:       - echo "🧠 Running Exo cognition cycle..."       - pwsh ExoCore/exo-learn.ps1       - pwsh ExoCore/exo-advise.ps1
      - pwsh ExoCore/exo-selftest.ps1  artifacts:   files:     - ExoCore/MappingTree/*     - ExoCore/Telemetry/*     - ExoCore/Lessons/*     - ExoCore/README.md -match "advisory|trigger|drift") {
    Write-Host "🔮 Forecast insight: \"
  }
}
Write-Host "✅ Forecast complete."
