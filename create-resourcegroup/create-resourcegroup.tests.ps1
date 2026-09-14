BeforeAll {
    . "$PSScriptRoot\..\LM1\create-resourcegroup.ps1" -ResourceGroupName "TestRG1"
}

Describe "New-AzResourceGroup" {
    It "Should create a resource group with the correct name" {
        $rg = Get-AzResourceGroup -Name "TestRG1"
        $rg.ResourceGroupName | Should -Be "TestRG1"
    }

    It "Should create the resource group in Central US" {
        $rg = Get-AzResourceGroup -Name "TestRG1"
        $rg.Location | Should -Be "centralus"
    }
}