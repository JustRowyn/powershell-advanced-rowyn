BeforeAll {
    . "$PSScriptRoot\create-resourcegroup.ps1"
}

Describe "New-TestResourceGroup" {
    It "Should create a resource group using ResourceGroupName" {
        $result = New-TestResourceGroup -ResourceGroupName "TestRG1"
        $result.Status | Should -Be "Created"
        $result.ResourceGroupName | Should -Be "TestRG1"
    }

    It "Should create a resource group using ProjectID with correct naming" {
        $result = New-TestResourceGroup -ProjectID 9001
        $result.Status | Should -Be "Created"
        $result.ResourceGroupName | Should -Be "RG-9001"
    }

    It "Should process multiple pipeline inputs" {
        $results = "9002","9003" | New-TestResourceGroup
        $results.Count | Should -Be 2
    }
}