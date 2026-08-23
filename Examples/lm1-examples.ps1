<#
.SYNOPSIS
    Shows Scripting Best Practices

    .DESCRIPTION
    This is the longer description

.PARAMETER ResourceGroupName

.EXAMPLE
    .\lm1-examples.ps1 "Rg-test"

#>


#Scripting Best Practices

# Indentation: Use consistent indentation (e.g., 4 spaces) to improve readability.
<#
if ($true) {
    Write-Output "This is an example of proper indentation."
}
    #>

#Poor Vs Good Script
#Poor Script
<#$a = Read-Host "Name"

New-AzResourceGroup -Name $a -Location "Central US"
#>

# Improved Script
param (
    [Parameter(Mandatory=$true)]
    [string][ValidateLength(1,10)]$ResourceGroupName
)

Start-Transcript -path "lm1-examples.log" -Append
try {
    New-AzResourceGroup `
        -Name $ResourceGroupName `
        -Location "Central US"
} catch {
    Write-Error "Failed to create resource group: $_"
} finally {
    Write-Host "Script execution completed."
}
Stop-Transcript

# for loop example
for ($i=0; $i -lt $ResourceGroupName.count; $i++) {

}