 LM3 Lab: Building Your First Advanced Function

#Summary

Converted my create-resourcegroup.ps1 script into an advanced function called New-TestResourceGroup.

#Task 1: Create Advanced Function
Wrapped the script in a function and added CmdletBinding to enable -Verbose and -Debug support.

#Task 2: Add Parameter Validation
Added an optional Tags parameter (hashtable) with default values. Updated the script to apply 
these tags when creating the resource group. Tested with both default and custom tags.

#Task 3: Accept Pipeline Input
Made ResourceGroupName accept pipeline input, so I can run things like "DevTest" | New-TestResourceGroup.

#Task 4: Create Structured Output
Changed the function to return a PSCustomObject (ResourceGroupName, Location, Status) instead 
of plain text, and updated Status to "Created" once the resource group is made.

#Task 5: Add WhatIf Support
Added SupportsShouldProcess so the function works with -whatif (shows what would happen) and 
-confirm (asks before running).

#Task 6: Repository Cleanup
Renamed folders to be clearer (LM1 to create-resourcegroup, LM2 to lab-files) and made an 
output folder for logs.

#Lessons Learned
Learned how to turn a basic script into a reusable function that behaves more like a real 
PowerShell cmdlet, with validation, pipeline support, structured output, and safer execution.