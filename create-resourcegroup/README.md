#powershell-advanced-rowyn: New-TestResourceGroup

#Overview
`New-TestResourceGroup` is an advanced PowerShell function that creates Azure resource groups in **Central US** with standard tags. It started as a simple script (`create-resourcegroup.ps1`) and was built up over LM1–LM4 into an enterprise-ready function.

> **As of LM5, this function is packaged in the `NWTC.ResourceGroups` module.**
> The maintained version lives in `NWTC.ResourceGroups\Public\New-TestResourceGroup.ps1`.
> This folder keeps the original script and Pester tests for reference.
> See [`NWTC.ResourceGroups\Docs\README.md`](../NWTC.ResourceGroups/Docs/README.md) for full module documentation.

#Features
- Create by name or by project ID (parameter sets)
- Name validation (1–10 characters)
- Pipeline input and multiple values
- Default tags (`Department=IT`, `Environment=Test`) or custom `-Tags`
- `-WhatIf` / `-Confirm` support
- Error handling with an execution summary (processed, created, errors, skipped)
- Logging to `output\lm5-resourcegroup.log` through the module's private `Write-ModuleLog` helper (replaced `Start-Transcript` in LM5)

#Parameters
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ResourceGroupName` | string | Yes (ByName) | Name of the resource group. 1–10 characters. |
| `ProjectID` | string | Yes (ByProjectID) | Generates the name `RG-<ProjectID>`. Accepts pipeline input. |
| `Tags` | hashtable | No | Tags to apply. Default: `@{Department="IT"; Environment="Test"}` |

#Getting Started
```powershell
Connect-AzAccount
Import-Module .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1
```

#Examples
```powershell
# By name
New-TestResourceGroup -ResourceGroupName "RG-LM5"

# By project ID
New-TestResourceGroup -ProjectID 5002

# Multiple values from the pipeline
"5003","5004","5005" | New-TestResourceGroup

# Preview only
New-TestResourceGroup -ProjectID 5006 -WhatIf
```

#Output
Returns one object per resource group:

| ResourceGroupName | Location | Status |
|-------------------|----------|--------|
| RG-5002 | Central US | Created / Skipped / Error |

Then prints an execution summary.

#History
| Module | Changes |
|--------|---------|
| LM1–LM2 | Initial script, validation, error handling, logging, Pester tests |
| LM3 | Converted into an advanced function |
| LM4 | Parameter sets, Begin/Process/End, pipeline support |
| LM5 | Packaged into the `NWTC.ResourceGroups` module; transcript logging replaced with `Write-ModuleLog` |

**Author:** Rowyn Rodenbeck