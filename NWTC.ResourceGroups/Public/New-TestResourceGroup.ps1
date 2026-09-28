function New-TestResourceGroup {
    <#
    .SYNOPSIS
    Creates a new Azure Resource Group
    .DESCRIPTION
    This function creates an Azure resource group using a mandatory, validated
    resource group name or a project ID. It includes comment-based help, 
    parameter validation, error handling, and logging. Supports processing 
    multiple pipeline inputs and reports summary statistics.
    .PARAMETER ResourceGroupName
    The name of the resource group to create. Must be between 1 and 10 characters.
    .PARAMETER ProjectID
    A project ID used to automatically generate a resource group name (RG-<ProjectID>).
    Accepts pipeline input, including multiple values.
    .PARAMETER Tags
    A hashtable of tags to apply to the resource group.
    .EXAMPLE
    New-TestResourceGroup -ResourceGroupName "Rg-test"
    .EXAMPLE
    New-TestResourceGroup -ProjectID 1001
    .EXAMPLE
    "1001","1002","1003" | New-TestResourceGroup
#>
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true, ParameterSetName="ByName")]
        [string][ValidateLength(1,10)]$ResourceGroupName,

        [Parameter(Mandatory=$true, ParameterSetName="ByProjectID", ValueFromPipeline=$true)]
        [string]$ProjectID,

        [hashtable]$Tags = @{Department="IT"; Environment="Test"}
    )

    Begin {
        Write-Verbose "Starting New-TestResourceGroup function..."
        Start-Transcript -path "..\output\lm4-resourcegroup.log" -Append | Out-Null

        $totalProcessed = 0
        $totalCreated   = 0
        $totalSkipped   = 0
        $totalErrors    = 0
    }

    Process {
        $totalProcessed++

        if ($PSCmdlet.ParameterSetName -eq "ByProjectID") {
            $currentName = "RG-$ProjectID"
        } else {
            $currentName = $ResourceGroupName
        }

        Write-Verbose "Processing resource group: $currentName"
        Write-Verbose "Validation successful for resource group name: $currentName"

        $result = [PSCustomObject]@{
            ResourceGroupName = $currentName
            Location          = "Central US"
            Status            = "Not Created"
        }

        try {
            Write-Verbose "Attempting to create resource group '$currentName' in Central US..."

            if ($PSCmdlet.ShouldProcess($currentName, "Create Resource Group")) {
                New-AzResourceGroup `
                    -Name $currentName `
                    -Location "Central US" `
                    -Tags $Tags `
                    -ErrorAction Stop | Out-Null

                $result.Status = "Created"
                $totalCreated++
                Write-Verbose "Resource group '$currentName' created successfully."
            } else {
                $result.Status = "Skipped"
                $totalSkipped++
            }
        } catch {
            Write-Error "Failed to create resource group: $_"
            $result.Status = "Error"
            $totalErrors++
        }

        $result
    }

    End {
        Write-Debug "Entering End block"
        Write-Host "Script execution completed."
        Write-Host ""
        Write-Host "===== Execution Summary ====="
        Write-Host "Total records processed : $totalProcessed"
        Write-Host "Created successfully     : $totalCreated"
        Write-Host "Errors                   : $totalErrors"
        Write-Host "Skipped                  : $totalSkipped"
        Stop-Transcript | Out-Null
    }
}