function Start-PaviOpenChat {
    param([string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "`n[$(Get-Date)] Pavi Open Chat Started: Knowledgebase-Only Mode"
}

function Write-PaviOpenChat {
    param([string]$Message, [string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "[$(Get-Date)] $Message"
}

function End-PaviOpenChat {
    param([string]$ChatLog = "pavi_chatbox.log")
    Add-Content -Path $ChatLog -Value "[$(Get-Date)] Pavi Open Chat Ended."
}
