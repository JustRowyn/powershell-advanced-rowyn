#powershell-advanced-rowyn

Coursework repository for **PowerShell Advanced**. It follows one project, automating Azure resource group creation, from a simple script to a distributable, versioned PowerShell module.

#Repository Structure
| Folder | Contents |
|--------|----------|
| [`NWTC.ResourceGroups/`](NWTC.ResourceGroups/Docs/README.md) | **Current**: the `NWTC.ResourceGroups` PowerShell module (LM5-LM6) |
| [`create-resourcegroup/`](create-resourcegroup/README.md) | Original script, advanced function, and Pester tests (LM1-LM4) |
| `Examples/` | Example files from earlier labs |
| `lab-files/` | Lab notes for each learning module (`lm1-lab.md` - `lm6-lab.md`) |
| `output/` | Log files from each lab |

#NWTC.ResourceGroups Module
A company-supported module that packages Azure resource group automation for reuse, versioning, and distribution. It continues to expand with reporting, auditing, and lifecycle management commands.

- **Version:** 1.1.0
- **Public:** `New-TestResourceGroup`, `Get-ResourceGroupSummary`
- **Private:** `Write-ModuleLog` (internal logging helper)

Full documentation: [NWTC.ResourceGroups/Docs/README.md](NWTC.ResourceGroups/Docs/README.md)
Version history: [NWTC.ResourceGroups/Docs/CHANGELOG.md](NWTC.ResourceGroups/Docs/CHANGELOG.md)
Release notes: [NWTC.ResourceGroups/Docs/RELEASENOTES.md](NWTC.ResourceGroups/Docs/RELEASENOTES.md)

#Quick Start
```powershell
Connect-AzAccount
Import-Module .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1
Get-Command -Module NWTC.ResourceGroups
```

#New-TestResourceGroup

An advanced PowerShell function for creating Azure resource groups, built and enhanced across LM3 and LM4, and packaged into a module in LM5. See [create-resourcegroup/README.md](create-resourcegroup/README.md) for full details.

Key features:
- Two ways to create a resource group: by name, or by project ID (auto-generates name as `RG-<ProjectID>`)
- Accepts single or multiple pipeline inputs for bulk creation
- Supports `-WhatIf` and `-Confirm` for safe execution
- Returns structured output and an execution summary (processed, created, skipped, errors)
- Logs every run to `output\lm5-resourcegroup.log` with timestamps and severity levels

Example:
```powershell
Get-Content .\ResourceGroups.txt | New-TestResourceGroup
```

#Get-ResourceGroupSummary

Added in LM6 (v1.1.0). Returns a quick summary (ResourceGroupName, Location, Tags) for one or all resource groups in the current subscription.

Example:
```powershell
Get-ResourceGroupSummary -ResourceGroupName "RG-1001"
Get-ResourceGroupSummary
```

#Releases
Packaged, distributable versions of the module are available as zip files in [`NWTC.ResourceGroups/Releases/`](NWTC.ResourceGroups/Releases/).

- `NWTC.ResourceGroups1.1.0.zip` - current release

#Course Progress
| Module | Focus |
|--------|-------|
| LM1-LM2 | Script basics, validation, error handling, logging, Pester tests |
| LM3 | Advanced function |
| LM4 | Parameter sets, pipeline support, Begin/Process/End |
| LM5 | PowerShell module: structure, manifest, exports, private helpers |
| LM6 | Module lifecycle management: new feature, semantic versioning, changelog, release notes, packaging/distribution |

**Author:** Rowyn Rodenbeck