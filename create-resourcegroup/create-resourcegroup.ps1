function New-TestResourceGroup {
    <#
    .SYNOPSIS
    Creates a new Azure Resource Group
    .DESCRIPTION
    This script creates an Azure resource group using a mandatory, validated
    resource group name. It includes comment-based help, parameter validation,
    error handling, and logging.
    .PARAMETER ResourceGroupName
    The name of the resource group to create. Must be between 1 and 10 characters.
    .PARAMETER Tags
    A hashtable of tags to apply to the resource group.
    .EXAMPLE
    .\create-resourcegroup.ps1 -ResourceGroupName "Rg-test"
#>
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string][ValidateLength(1,10)]$ResourceGroupName,

        [hashtable]$Tags = @{Department="IT"; Environment="Test"}
    )

    Write-Verbose "Starting script with ResourceGroupName: $ResourceGroupName"
    Write-Debug "Parameter received - ResourceGroupName: $ResourceGroupName"

    $result = [PSCustomObject]@{
        ResourceGroupName = $ResourceGroupName
        Location          = "Central US"
        Status            = "Not Created"
    }
    Start-Transcript -path "..\output\lm1-resourcegroup.log" -Append
    try {
        Write-Verbose "Attempting to create resource group '$ResourceGroupName' in Central US..."
        Write-Debug "About to call New-AzResourceGroup"

        if ($PSCmdlet.ShouldProcess($ResourceGroupName, "Create Resource Group")) {
        New-AzResourceGroup `
            -Name $ResourceGroupName `
            -Location "Central US" `
            -Tags $Tags `
            -ErrorAction Stop

        $result.Status = "Created"
        Write-Verbose "Resource group '$ResourceGroupName' created successfully."
        }
    } catch {
        Write-Error "Failed to create resource group: $_"
    } finally {
        Write-Debug "Entering finally block"
        Write-Host "Script execution completed."
    }
    Stop-Transcript

    $result
}