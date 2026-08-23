<#
.SYNOPSIS
    Creates a new Azure Resource Group

    .DESCRIPTION
    This script creates an Azure resource group using a mandatory, validated
    resource group name. It includes comment-based help, parameter validation,
    error handling, and logging.

.PARAMETER ResourceGroupName
    The name of the resource group to create. Must be between 1 and 10 characters.
.EXAMPLE
    .\create-resourcegroup.ps1 -ResourceGroupName "Rg-test"

#>


param (
    [Parameter(Mandatory=$true)]
    [string][ValidateLength(1,10)]$ResourceGroupName
)

Start-Transcript -path "lm1-resourcegroup.log" -Append
try {
    New-AzResourceGroup `
        -Name $ResourceGroupName `
        -Location "Central US"
        -ErrorAction Stop
} catch {
    Write-Error "Failed to create resource group: $_"
} finally {
    Write-Host "Script execution completed."
}
Stop-Transcript