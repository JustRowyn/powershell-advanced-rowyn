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

#Task 5: Private Helper Function
- Created `Private\Write-ModuleLog.ps1` with parameters: `-Path` (folder), `-FileName`, `-Message`, `-Level` (INFO/WARNING/ERROR).
- Each entry is written as: `[timestamp] [level] [username] message`. `Add-Content` creates the file if it doesn't exist.
- Replaced `Start-Transcript`/`Stop-Transcript` in `New-TestResourceGroup` with `Write-ModuleLog` calls (start, each resource group, created/skipped/error, summary, finish).
- The .psm1 dot-sources both Public and Private files but only exports Public, so `Get-Command -Module NWTC.ResourceGroups` shows only `New-TestResourceGroup`.
- Issue: the old log path `..\output\...` was relative to the terminal's current folder. Fixed by building the path from `$PSScriptRoot` (`..\..\output` from the Public folder).
- Issue: with `-WhatIf`, the WhatIf setting was inherited by `Add-Content` in the helper, so nothing got logged. Fixed with `-WhatIf:$false` on `Add-Content` and `New-Item`.
- Must re-run `Import-Module ... -Force` after every code change, or the old version stays in memory.
- Log timestamps are in UTC because the Azure VM's clock is UTC.

#Task 6: Testing the Module
| Test | Command | Result |
|------|---------|--------|
| ResourceGroupName | `New-TestResourceGroup -ResourceGroupName "RG-LM5"` | Created |
| ProjectID | `New-TestResourceGroup -ProjectID 5002` | RG-5002 Created |
| Pipeline + multiple values | `"5003","5004","5005" \| New-TestResourceGroup` | 3 processed, 3 created, one summary |
| WhatIf | `New-TestResourceGroup -ProjectID 5006 -WhatIf` | Skipped, logged as WARNING |
| Validation | `-ResourceGroupName "ThisNameIsTooLong"` | Rejected by ValidateLength (not logged, since it fails before Begin runs) |
| Log location | Ran from `C:\` | Log still written to repo `output` folder; `Test-Path C:\output` = False |

- Log file (`output\lm5-resourcegroup.log`) contains start, per-resource-group, result, summary, and finish entries for every run.

#Task 7: Prepare for Distribution
- Created `NWTC.ResourceGroups\Docs\README.md` with module purpose, features, structure, requirements, installation, usage examples, and version history.
- Updated `create-resourcegroup\README.md` (function README) to document parameters, examples, output, logging, and point to the module as the maintained version.
- Updated the repository `readme.md` with repo structure, a module overview and quick start, and course progress.
- Added `.NOTES` (module, version, author) and `.LINK` to the comment-based help in `New-TestResourceGroup` and `.NOTES` to `Write-ModuleLog`.
- Verified with `Get-Help New-TestResourceGroup -Full`: NOTES and RELATED LINKS appear.