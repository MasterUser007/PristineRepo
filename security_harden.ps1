Write-Host "🔒 Implementing security hardening..."
Set-ExecutionPolicy RemoteSigned -Force
New-Item -Path "C:\SecurityLogs\" -ItemType Directory -Force
Get-EventLog -LogName Security | Out-File -FilePath "C:\SecurityLogs\Security_Audit.log"
Write-Host "✅ Security logs captured!"