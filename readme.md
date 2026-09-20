## New-TestResourceGroup

An advanced PowerShell function for creating Azure resource groups, built and enhanced 
across LM3 and LM4. See create-resourcegroup/README.md for full details.

Key features:
- Two ways to create a resource group: by name, or by project ID (auto-generates name 
  as RG-<ProjectID>)
- Accepts single or multiple pipeline inputs for bulk creation
- Supports -whatif and -confirm for safe execution
- Returns structured output and an execution summary (processed, created, skipped, errors)

Example:
Get-Content .\ResourceGroups.txt | New-TestResourceGroup