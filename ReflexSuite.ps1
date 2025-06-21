Add-Type -AssemblyName PresentationFramework
$engineMap = @{
  '🔐 QuantumHash (v1.0.0)' = 'start_QuantumHash.bat'
  '🧠 PrimeEngineAI (v1.0.0)' = 'start_PrimeEngineAI.bat'
  '🧮 FactorEngine (v1.0.0)' = 'start_FactorEngine.bat'

}
$title = 'ReflexSuite Control Panel'
try {
  $selected = $engineMap.Keys | Out-GridView -Title $title -PassThru
} catch {
  $selected = [Microsoft.VisualBasic.Interaction]::InputBox("Type engine:
" + [string]::Join("
", $engineMap.Keys), "ReflexSuite")
}
if (-not $selected -or -not $engineMap.ContainsKey($selected)) {
  [System.Windows.MessageBox]::Show("No valid engine selected.", $title, 'OK', 'Information')
  return
}
$target = Join-Path 'C:\Users\leebo\OneDrive\Desktop\ReflexSuite' $engineMap[$selected]
if (Test-Path $target) {
  Add-Content 'C:\Users\leebo\OneDrive\Desktop\ReflexSuite\ReflexSuite.log' "$(Get-Date -Format u) ✅ Launched $selected"
  Start-Process -FilePath $target
  [System.Windows.MessageBox]::Show("Launching $selected...", $title, 'OK', 'Information')
} else {
  Add-Content 'C:\Users\leebo\OneDrive\Desktop\ReflexSuite\ReflexSuite.log' "$(Get-Date -Format u) ❌ Missing $selected at $target"
  [System.Windows.MessageBox]::Show("❌ Missing launcher: $target", $title, 'OK', 'Error')
}
