#Task 1
Original command: Get-Process -Name explore
Error: Cannot find a process with the name "explore". Verify the process name and call the cmdlet again.
Cause: Misspelled process name — should be "explorer".
Corrected command: Get-Process -Name explorer

#Task 2: Add Debugging Output

Verbose output example:
VERBOSE: Starting script with ResourceGroupName: New RG
VERBOSE: Attempting to create resource group 'NewRG' in Central US...
VERBOSE: Resource group 'NewRG' created successfully.

Debug output example:
DEBUG: Entering finally block
DEBUG: AzureQoSEvent: Module = Az.Resources:10.1.0; CommandName: New-AzResourceGroup; IsSuccess: True

Differences observed:
Verbose output prints clean, high-level status messages showing progress through the script.
Debug output is much more detailed and includes internal module diagnostics (from the Az module itself), 
not just my own Write-Debug messages. Debug is more useful for deep troubleshooting, while Verbose is 
better for general progress tracking.

#Task 3: Create Your First Pester Test

Test name: New-AzResourceGroup

Expected result: 
The script creates a resource group named "TestRG1" in Central US, and Get-AzResourceGroup 
confirms it exists with the correct name and location.

Actual result:
Both tests passed. Tests Passed: 2, Failed: 0, Skipped: 0, Inconclusive: 0, NotRun: 0

