# ML-INSTRUMENTED
Import-Module ./pavi_ml.psm1

Describe "Get-Greeting" {
    It "returns correct greeting" {
        Get-Greeting -Name 'World' | Should -BeExactly "Hello, World!"
    }
}

Describe "Get-Farewell" {
    It "returns correct farewell" {
        Get-Farewell -Name 'World' | Should -BeExactly "Goodbye, World!"
    }
}

