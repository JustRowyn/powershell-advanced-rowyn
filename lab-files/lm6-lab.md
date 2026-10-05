#LM6 Lab Notes

#Task 1: Review Current Module Version

Current Version: 1.0.0
Author: Rowyn Rodenbeck
Description: Test resource group creation
Exported Commands: New-TestResourceGroup (FunctionsToExport is set to '*', exporting 
everything in the Public folder)

#Task 2: Add a New Feature

Created a new public function, Get-ResourceGroupSummary, which returns ResourceGroupName, 
Location, and Tags for one or all resource groups.

Verified it's part of the module using Get-Command -Module NWTC.ResourceGroups, which 
listed both New-TestResourceGroup and Get-ResourceGroupSummary.

Tested with Get-ResourceGroupSummary -ResourceGroupName "RG-1001", which correctly returned:
ResourceGroupName: RG-1001
Location: centralus
Tags: Department=IT, Environment=Test

#Task 3: Update Module Version

Updated ModuleVersion in NWTC.ResourceGroups.psd1 from 1.0.0 to 1.1.0.

This qualifies as a minor version update because a new feature (Get-ResourceGroupSummary) 
was added without changing or breaking any existing functionality. Per semantic versioning 
rules, new backward-compatible functionality belongs in the MINOR version number, while 
PATCH is reserved for bug fixes and MAJOR is reserved for breaking changes.

#Task 4: Create a Changelog

Created CHANGELOG.md in NWTC.ResourceGroups/Docs, documenting version 1.0.0 (initial 
release with New-TestResourceGroup) and version 1.1.0 (added Get-ResourceGroupSummary).

#Task 5: Create Release Notes

Created RELEASENOTES.md in NWTC.ResourceGroups/Docs, covering new features (Get-ResourceGroupSummary), 
bug fixes (none), upgrade instructions, and known issues for v1.1.0.

#Task 6: Test the Upgrade

Re-imported the module with Import-Module .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1 -Force.

Get-Module NWTC.ResourceGroups confirmed:
- Version: 1.1.0
- ExportedCommands: Get-ResourceGroupSummary, New-TestResourceGroup

Get-Command -Module NWTC.ResourceGroups confirmed both functions are available at version 1.1.0.

Ran Get-ResourceGroupSummary (no parameter), which successfully returned all resource 
groups in the subscription with their ResourceGroupName, Location, and Tags.

Ran Get-ResourceGroupSummary -ResourceGroupName "RG-1001", which correctly returned only 
that single resource group's details.

Upgrade verified successfully — no errors encountered.

#Task 7: Publish and Distribute

Updated the module README, repo README, and comment-based help to reflect v1.1.0 and 
the new Get-ResourceGroupSummary function. Created a Releases folder inside 
NWTC.ResourceGroups and packaged the module using:

Compress-Archive -Path .\NWTC.ResourceGroups -DestinationPath .\NWTC.ResourceGroups\Releases\NWTC.ResourceGroups1.1.0.zip

The zip was created successfully with no errors.