# ML-INSTRUMENTED
Import-Module ./pavi_ml.psm1

if (-not $env:OPENAI_API_KEY) {
    Write-Error "OPENAI_API_KEY is not set. Please set your API key as an environment variable."
    exit 1
}

$headers = @{
    "Authorization" = "Bearer $env:OPENAI_API_KEY"
    "Content-Type"  = "application/json"
}

# Test model list
try {
    $models = Invoke-RestMethod -Uri "https://api.openai.com/v1/models" -Headers $headers -Method Get
    Write-Host "Available models:" -ForegroundColor Green
    $models.data | ForEach-Object { Write-Host " - $($_.id)" }
} catch {
    Write-Error "❌ Model list failed: $_"
    exit 1
}

# Test basic completion
$body = @{
    model = "gpt-4o"
    messages = @(
        @{
            role = "user"
            content = "What is 5 + 3?"
        }
    )
} | ConvertTo-Json

try {
    $completion = Invoke-RestMethod -Uri "https://api.openai.com/v1/chat/completions" -Headers $headers -Body $body -Method Post
    Write-Host "`nChat completion response:" -ForegroundColor Cyan
    $completion.choices | ForEach-Object { Write-Host $_.message.content }
} catch {
    Write-Error "❌ Completion test failed: $_"
    exit 1
}

Write-Host "`nOpenAI API testing complete. ✅" -ForegroundColor Green

