# ML-INSTRUMENTED
Import-Module ./pavi_ml.psm1

function Get-Greeting {
    <#
    .SYNOPSIS
    Returns a personalized greeting message.

    .DESCRIPTION
    The Get-Greeting function takes a name as input and returns a greeting message formatted as "Hello, <Name>!".

    .PARAMETER Name
    The name of the person to greet.

    .EXAMPLE
    PS C:\> Get-Greeting -Name "Alice"
    Hello, Alice!

    This example demonstrates how to use the Get-Greeting function to greet someone named Alice.

    .INPUTS
    None. You cannot pipe objects to this function.

    .OUTPUTS
    System.String. The function returns a greeting string.
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name
    )
    Write-Output "Hello, $Name!"
}

