#LM4 Lab Notes

#Task 1: Evaluate Your Existing Function

#Strengths

1.Returns structured output (PSCustomObject) instead of plain text.
2.Supports -whatif and -confirm for safe execution.
3.Validates input with Mandatory and ValidateLength.

#Areas for Improvement
1.Only supports one way to name a resource group (no project ID option).
2.Can't process multiple resource groups at once (no Begin/Process/End).
3.Doesn't summarize results (no counts of successes, skips, or errors).

#Task 2: Add Parameter Sets

Added two parameter sets: ByName (uses ResourceGroupName) and ByProjectID (uses ProjectID).

When ProjectID is used, the function automatically generates a name in the format RG-<ProjectID>.
Example: -ProjectID 1001 creates a resource group named RG-1001.

When ResourceGroupName is used, it behaves the same as before, creating a resource group
with the exact name given.

Both parameter sets were tested successfully:
- New-TestResourceGroup -ProjectID 1001 created RG-1001
- New-TestResourceGroup -ResourceGroupName "Dev1" created/updated Dev1

#Task 3: Implement Begin, Process, and End Blocks

Restructured the function into Begin, Process, and End blocks to support processing 
multiple pipeline inputs at once. Also moved ValueFromPipeline from ResourceGroupName 
to ProjectID, since project IDs are the values expected to come through the pipeline 
in bulk.

Begin: starts the transcript and displays a startup message.
Process: runs once per pipeline item, builds the resource group name (by name or by 
project ID), attempts creation, and returns a result object for that item.
End: displays a completion message and stops the transcript.

Tested with "1001","1002","1003" | New-TestResourceGroup, which successfully created 
three resource groups (RG-1001, RG-1002, RG-1003) in a single command.

Lesson learned: had to rework the $result object to be created and returned inside 
Process instead of Begin, since each pipeline item needs its own separate result.

#Task 4: Improve User Feedback

Added Write-Verbose messages throughout the function covering:
- Function start
- Validation success
- Resource group creation attempt
- Successful completion

Tested with New-TestResourceGroup -ProjectID 2001 -verbose, which displayed all four 
verbose messages in order, confirming the function's progress at each step.

Lesson learned: needed to re-dot-source the script after making changes, otherwise 
the old version of the function stays loaded in memory even though the file was saved.

#Task 5: Process Multiple Resource Groups

Created ResourceGroups.txt containing 5 project IDs (3001-3005), one per line.

Ran: Get-Content .\ResourceGroups.txt | New-TestResourceGroup

Results:
- Objects processed: 5
- Successfully created: 5
- Warnings generated: None

All five resource groups (RG-3001 through RG-3005) were created successfully with 
Status: Created for each one.

#Task 6: Add Execution Statistics

Added four counters (TotalProcessed, TotalCreated, TotalSkipped, TotalErrors) initialized 
in the Begin block, incremented in the Process block based on each item's outcome, and 
displayed as a summary in the End block.

Tested with "4001","4002","4003" | New-TestResourceGroup, which correctly displayed:

===== Execution Summary =====
Total records processed : 3
Created successfully    : 3
Errors                  : 0
Skipped                 : 0