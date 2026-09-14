#Poor script

$a = Read-Host "Name"
New-AzResourceGroup -Name $a -Location "Central US"



#Issues
<# 
1. There is no comment based help - No one besides the owner of the script would really know how to use it
2. it is read-host instead of a parameter - using read host it couldn't be ran unattended
3. there is no input for handling errors - Raw errors can be confusing, so making simple ones can help others that will use the script
#>

#Purpose of script - Creates a new Azure Resource group.
#Parameter - ResourceGroupName - required, must be 1-10 Characters
#Example - .\create-resourcegroup.ps1

#Validation method: ValidateLength(1,10)
#Valid input = rg-test6
#Invalid input = rg-test12345678910(gets rejected with error)
#result - Validation would correctly block the invalid input before the script tried making the resource group

#Error Generated: Invalid Azure location(not a real place)
#error message received: 400 Bad request, said location was not valid
#How Catch handled it: caught the failure and displayed a custom message: Failed to create resource group
#what occured in Final: Printed script execution completed. and stopped the transcript because it errored.

#Transcript File location:  C:\powershell-advanced-rowyn\LM1\lm1-resourcegroup.log
#Transcript started, output file is lm1-resourcegroup.log
#Renamed the variable from $a to $ResourceGroupName so its clear on what it is
#Added Consistent indentation to make it clean