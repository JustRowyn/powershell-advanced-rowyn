#Changelog

All notable changes to the NWTC.ResourceGroups module will be documented in this file.

#[1.1.0] - 2026-10-04

#Added
- New public function Get-ResourceGroupSummary, which returns ResourceGroupName, 
  Location, and Tags for one or all resource groups in the subscription.

#Changed
- No changes to existing functionality.

#Fixed
- No bug fixes in this release.

#[1.0.0] - 2026-09-28

#Added
- Initial release of the module.
- Public function New-TestResourceGroup, which creates an Azure resource group by 
  name or project ID, supports pipeline input for bulk creation, tagging, WhatIf/Confirm 
  safety, structured output, and execution summary reporting.