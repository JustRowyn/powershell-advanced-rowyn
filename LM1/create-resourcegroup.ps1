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

Write-Verbose "Starting script with ResourceGroupName: $ResourceGroupName"
Write-Debug "Parameter received - ResourceGroupName: $ResourceGroupName"

Start-Transcript -path "lm1-resourcegroup.log" -Append
try {
    Write-Verbose "Attempting to create resource group '$ResourceGroupName' in Central US..."
    Write-Debug "About to call New-AzResourceGroup"

    New-AzResourceGroup `
        -Name $ResourceGroupName `
        -Location "Central US" `
        -ErrorAction Stop

    Write-Verbose "Resource group '$ResourceGroupName' created successfully."
} catch {
    Write-Error "Failed to create resource group: $_"
} finally {
    Write-Debug "Entering finally block"
    Write-Host "Script execution completed."
}
Stop-Transcript