function Write-ModuleLog {
    <#
    .SYNOPSIS
    Writes a timestamped message to a log file.
    .DESCRIPTION
    Private helper function for the NWTC.ResourceGroups module. Creates the log
    folder and log file if they do not exist, then appends a message with a
    timestamp, severity level, and the user who ran the command.
    This function is not exported and is only used by other module functions.
    Logging always runs, even when the calling function uses -WhatIf.
    .PARAMETER Path
    The folder where the log file will be stored.
    .PARAMETER FileName
    The name of the log file (for example, lm5-resourcegroup.log).
    .PARAMETER Message
    The message to write to the log file.
    .PARAMETER Level
    The severity of the message: INFO, WARNING, or ERROR. Defaults to INFO.
    .EXAMPLE
    Write-ModuleLog -Path "C:\Logs" -FileName "lm5-resourcegroup.log" -Message "Resource group created."
    .EXAMPLE
    Write-ModuleLog -Path "C:\Logs" -FileName "lm5-resourcegroup.log" -Message "Creation failed." -Level ERROR
      .NOTES
    Module:   NWTC.ResourceGroups
    Version:  1.0.0
    Author:   Rowyn Rodenbeck
    Scope:    Private (not exported). Used internally by module functions.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path,

        [Parameter(Mandatory=$true)]
        [string]$FileName,

        [Parameter(Mandatory=$true)]
        [string]$Message,

        [ValidateSet("INFO","WARNING","ERROR")]
        [string]$Level = "INFO"
    )

    # Create the log folder if it doesn't exist
    if (-not (Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force -WhatIf:$false | Out-Null
    }

    # Build the full log file path
    $logFile = Join-Path -Path $Path -ChildPath $FileName

    # Format the log entry
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "[$timestamp] [$Level] [$env:USERNAME] $Message"

    # Append to the log file (-WhatIf:$false = always write the log, even during -WhatIf runs)
    Add-Content -Path $logFile -Value $entry -WhatIf:$false
}