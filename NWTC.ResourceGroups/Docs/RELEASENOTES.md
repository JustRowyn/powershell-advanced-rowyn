#Release Notes - NWTC.ResourceGroups v1.1.0

#New Features
- Added Get-ResourceGroupSummary, a new function that returns a quick summary 
  (ResourceGroupName, Location, Tags) for one or all resource groups in the subscription. 
  This gives administrators an easy way to review existing resource groups without 
  manually running Get-AzResourceGroup and digging through the output.

#Bug Fixes
- None in this release.

#Upgrade Instructions
1. Pull the latest version of the module from the GitHub repository.
2. Re-import the module with the -Force flag to load the updated version:
   Import-Module .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1 -Force
3. Confirm the new version and function are available:
   Get-Module NWTC.ResourceGroups
   Get-Command -Module NWTC.ResourceGroups

#Known Issues
- Get-ResourceGroupSummary currently requires an active, authenticated Azure session 
  (Connect-AzAccount) to retrieve resource group data.
- No pagination or filtering options are currently available when retrieving all 
  resource groups; large subscriptions may return a large result set.