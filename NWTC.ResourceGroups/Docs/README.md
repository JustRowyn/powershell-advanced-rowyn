#NWTC.ResourceGroups

#Purpose
`NWTC.ResourceGroups` is a PowerShell module that standardizes how test Azure resource groups are created and reported on. It packages the `New-TestResourceGroup` and `Get-ResourceGroupSummary` functions so they can be imported, maintained, versioned, and distributed consistently. It is the foundation for future commands for resource group reporting, auditing, and lifecycle management.

#Features
- **`New-TestResourceGroup`**: creates Azure resource groups in Central US
  - Create by name (`-ResourceGroupName`, 1–10 characters) or by project ID (`-ProjectID` → `RG-<ProjectID>`)
  - Accepts pipeline input and multiple values
  - Applies default tags (`Department=IT`, `Environment=Test`) or custom tags with `-Tags`
  - Supports `-WhatIf` and `-Confirm`
  - Error handling with an execution summary (processed, created, errors, skipped)
- **`Get-ResourceGroupSummary`**: returns a quick summary (ResourceGroupName, Location, Tags) 
  for one or all resource groups in the current subscription
  - Accepts an optional `-ResourceGroupName` (pipeline-enabled); omit it to summarize every 
    resource group in the subscription
- **Built-in logging**: a private `Write-ModuleLog` helper writes timestamped entries (INFO / WARNING / ERROR) to `output\lm5-resourcegroup.log`
- **Public/Private structure**: only public functions are exported; internal helpers stay hidden

#Module Structure
NWTC.ResourceGroups
├── Docs
│ ├── README.md
│ ├── CHANGELOG.md
│ └── RELEASENOTES.md
├── Private
│ └── Write-ModuleLog.ps1
├── Public
│ ├── New-TestResourceGroup.ps1
│ └── Get-ResourceGroupSummary.ps1
├── Releases
│ └── NWTC.ResourceGroups1.1.0.zip
├── NWTC.ResourceGroups.psd1 # Module manifest (metadata, version)
└── NWTC.ResourceGroups.psm1 # Loads Private + Public, exports Public only

#Requirements
- PowerShell 7+ (or Windows PowerShell 5.1)
- `Az.Resources` module (`Install-Module Az -Scope CurrentUser`)
- An Azure account with permission to create resource groups

#Installation
**Option 1: Import directly from the repository**
```powershell
git clone https://github.com/JustRowyn/powershell-advanced-rowyn.git
cd powershell-advanced-rowyn\NWTC.ResourceGroups
Import-Module .\NWTC.ResourceGroups.psd1
```

**Option 2: Install to your module path (auto-loads in new sessions)**
```powershell
Copy-Item -Path .\NWTC.ResourceGroups -Destination "$HOME\Documents\PowerShell\Modules\" -Recurse
Import-Module NWTC.ResourceGroups
```

**Verify the install**
```powershell
Get-Command -Module NWTC.ResourceGroups
```

## Usage Examples
Sign in to Azure first:
```powershell
Connect-AzAccount
```

Create a resource group by name:
```powershell
New-TestResourceGroup -ResourceGroupName "RG-LM5"
```

Create a resource group from a project ID:
```powershell
New-TestResourceGroup -ProjectID 5002
```

Create multiple resource groups from the pipeline:
```powershell
"5003","5004","5005" | New-TestResourceGroup
```

Preview without creating anything:
```powershell
New-TestResourceGroup -ProjectID 5006 -WhatIf
```

Use custom tags:
```powershell
New-TestResourceGroup -ProjectID 5007 -Tags @{Department="Finance"; Environment="Dev"}
```

View a summary of a specific resource group:
```powershell
Get-ResourceGroupSummary -ResourceGroupName "RG-1001"
```

View a summary of every resource group in the subscription:
```powershell
Get-ResourceGroupSummary
```

View full help:
```powershell
Get-Help New-TestResourceGroup -Full
Get-Help Get-ResourceGroupSummary -Full
```

#Version Information
| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-09-28 | Initial release. Converted `New-TestResourceGroup` into a module, added manifest, Public/Private structure, and `Write-ModuleLog` logging. |
| 1.1.0 | 2026-10-04 | Added `Get-ResourceGroupSummary` function for reporting on existing resource groups. Added CHANGELOG.md and RELEASENOTES.md. Minor version bump — new backward-compatible functionality, no breaking changes. |

**Author:** Rowyn Rodenbeck