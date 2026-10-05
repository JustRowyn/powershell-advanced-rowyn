function Get-ResourceGroupSummary {
    <#
    .SYNOPSIS
    Returns a summary of one or more Azure Resource Groups.
    .DESCRIPTION
    This function retrieves key details about Azure resource groups, including 
    the resource group name, location, and tags. Accepts a specific resource 
    group name or returns a summary for all resource groups in the subscription.
    .PARAMETER ResourceGroupName
    The name of a specific resource group to summarize. If omitted, all resource 
    groups in the current subscription are summarized.
    .EXAMPLE
    Get-ResourceGroupSummary -ResourceGroupName "RG-1001"
    .EXAMPLE
    Get-ResourceGroupSummary
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false, ValueFromPipeline=$true)]
        [string]$ResourceGroupName
    )

    Process {
        Write-Verbose "Retrieving resource group summary..."

        if ($ResourceGroupName) {
            $groups = Get-AzResourceGroup -Name $ResourceGroupName
        } else {
            $groups = Get-AzResourceGroup
        }

        foreach ($group in $groups) {
            [PSCustomObject]@{
                ResourceGroupName = $group.ResourceGroupName
                Location          = $group.Location
                Tags              = $group.Tags
            }
        }
    }
}