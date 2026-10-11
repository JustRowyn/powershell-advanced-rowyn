LM7 Lab Notes

#Task 1: Examine a DSC Configuration

Configuration name: CompanyBaseline
Node: localhost

Resource 1: File AutomationFolder
- Creates a directory at C:\Automation if it doesn't already exist (Type = Directory, Ensure = Present)

Resource 2: File ConfigFile
- Creates a file at C:\Automation\Config.txt containing the text "NWTC Standard Configuration" 
  (Type = File, Ensure = Present). Depends on AutomationFolder being created first.

Compiled the configuration using:
CompanyBaseline -OutputPath C:\powershell-advanced-rowyn\DSC\CompanyBaselineExample

This generated localhost.mof, a machine-readable file describing both resources and 
their desired properties.

Applied the configuration with Start-DscConfiguration -Path .\CompanyBaselineExample -Wait -Verbose.
Since C:\Automation and Config.txt did not yet exist, DSC created both.

Test-DscConfiguration returned True, confirming the system matched the desired state.

Get-DscConfiguration confirmed both resources were applied correctly:
- AutomationFolder: Type = directory, Ensure = present
- ConfigFile: Type = file, Ensure = present, Size = 30 bytes

Note: Had to switch from PowerShell 7 to Windows PowerShell 5.1 to compile the 
configuration, since classic DSC is not fully compatible with PowerShell 7.

#Task 2: Create Your First DSC Configuration

Created a new configuration named RowynBaseline in DSC\lm7-dsc.ps1, using a WindowsFeature 
resource (different from the File resource used in the Task 1 example).

Configuration RowynBaseline
{
    Node localhost
    {
        WindowsFeature TelnetClient
        {
            Name   = "Telnet-Client"
            Ensure = "Present"
        }
    }
}

This configuration ensures the Telnet Client Windows feature is installed on the target node.

#Task 3: Generate and Review MOF Files

File location: C:\powershell-advanced-rowyn\DSC\RowynBaseline\localhost.mof

File purpose: The MOF (Managed Object Format) file is the compiled, machine-readable 
version of the RowynBaseline configuration. The Local Configuration Manager (LCM) reads 
this file to know exactly what state the system should be in and applies it.

Information observed:
- ResourceID: [WindowsFeature]TelnetClient
- Underlying CIM class: MSFT_RoleResource (this is the actual resource type behind the 
  WindowsFeature keyword used in the configuration script)
- Ensure: Present
- Name: Telnet-Client
- Includes metadata about generation: author (student), generation date/time, and the 
  host that compiled it (PA-rowyn)
- The file traces back to its source script and exact line number 
  (lm7-dsc.ps1::5::9::WindowsFeature), making it easy to debug which line produced 
  which resource

#Task 4: Apply the Configuration

Applied the RowynBaseline configuration using:
Start-DscConfiguration -Path .\RowynBaseline -Wait -Verbose

Results:
- LCM tested the current state of the Telnet-Client feature and found it was not installed.
- LCM proceeded to install it, including prerequisite processing.
- Installation succeeded: "Successfully installed the feature Telnet-Client."
- Total time to complete: approximately 114.5 seconds.

#Task 5: Validate Compliance

Test-DscConfiguration returned True, confirming the system matches the desired state 
defined in RowynBaseline.

Get-DscConfiguration confirmed the applied resource:
- ConfigurationName: RowynBaseline
- ResourceId: [WindowsFeature]TelnetClient
- DisplayName: Telnet Client
- Name: Telnet-Client
- Ensure: Present

This confirms the Telnet Client feature was successfully installed and matches the 
desired configuration.

#Task 6: Expand Your Baseline

Added a second resource to RowynBaseline - a Service resource ensuring the Windows Time 
service (W32Time) is running:

Service WindowsTimeService
{
    Name  = "W32Time"
    State = "Running"
}

Recompiled the configuration with:
RowynBaseline -OutputPath C:\powershell-advanced-rowyn\DSC\RowynBaseline

Redeployed with:
Start-DscConfiguration -Path .\RowynBaseline -Wait -Verbose

Results:
- TelnetClient: already Present from Task 4, so LCM skipped re-applying it (Test passed, Set skipped)
- WindowsTimeService: already Running, so LCM skipped it as well (Test passed, Set skipped)

This demonstrates DSC's idempotency - since both resources already matched the desired 
state, nothing needed to change; DSC only takes action when the actual state differs 
from the desired state.

Test-DscConfiguration returned True.

Get-DscConfiguration confirmed both resources:
- [WindowsFeature]TelnetClient: Ensure = Present
- [Service]WindowsTimeService: State = Running, StartupType = Automatic