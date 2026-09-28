#LM5 Lab: Converting Functions into a PowerShell Module

#Task 1: Module Structure
- Created the `NWTC.ResourceGroups` module folder with `Public`, `Private`, and `Docs` subfolders.
- Copied `create-resourcegroup.ps1` into `Public` as `New-TestResourceGroup.ps1`.
- The file name must match the function name so it can be exported by `BaseName` later.
- Git does not track empty folders, so `Private` and `Docs` won't appear on GitHub until they contain files.

#Task 2: Script Module (.psm1)
- The `.psm1` runs when `Import-Module` is called.
- `$PSScriptRoot` = the folder the `.psm1` is in, so no hard-coded paths.
- `Get-ChildItem "$PSScriptRoot\Public\*.ps1"` finds all public function files.
- Dot-sourcing (`. $file.FullName`) loads each file into the module's scope so its functions stay available.
- Tested with: `Import-Module .\NWTC.ResourceGroups.psm1 -Force -Verbose`
- Without `Export-ModuleMember`, a `.psm1` exports every function by default.