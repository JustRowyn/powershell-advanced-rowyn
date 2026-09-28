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

#Task 3: Module Manifest
- A manifest stores module metadata: author, version, description, and which file holds the code.
- Created with:
  `New-ModuleManifest -Path .\NWTC.ResourceGroups.psd1 -Author "Rowyn Rodenbeck" -ModuleVersion 1.0.0 -Description "Test resource group creation" -RootModule NWTC.ResourceGroups.psm1`
- `-RootModule` is needed so importing the .psd1 also loads the .psm1. Without it, the module imports with no commands.
- `Test-ModuleManifest` validates the manifest. ExportedCommands shows blank because `FunctionsToExport = '*'` isn't expanded until the module is actually imported.
- `Import-Module .\NWTC.ResourceGroups.psd1 -Force -Verbose` loads psd1 → psm1 → public functions.

#Task 4: Export Module Members
- Added `Export-ModuleMember -Function $publicFunctions.BaseName` to the end of the .psm1.
- `BaseName` is the file name without `.ps1`, so each Public file's name must match its function name.
- Without Export-ModuleMember, every function in the module is exported, including private helpers.
- Verified with `Get-Command -Module NWTC.ResourceGroups`, which shows only `New-TestResourceGroup`.