#New-TestResourceGroup

An advanced PowerShell function that creates an Azure resource group with validation, 
tagging, pipeline support, and structured output.

#What it does
- Creates a new Azure resource group in Central US
- Validates the resource group name (1-10 characters)
- Applies tags to the resource group (custom or default)
- Accepts input from the pipeline
- Supports -whatif and -confirm for safe execution
- Returns a structured object showing the result

#Parameters
- ResourceGroupName (mandatory, string, 1-10 characters, accepts pipeline input) 
  - The name of the resource group to create.
- Tags (optional, hashtable, defaults to @{Department="IT"; Environment="Test"}) 
  - Tags to apply to the resource group.

#Example usage
New-TestResourceGroup -ResourceGroupName "Test1"

New-TestResourceGroup -ResourceGroupName "DevTest" -Tags @{Department="Dev";Environment="Development"}

"DevTest2" | New-TestResourceGroup

"DevTest3" | New-TestResourceGroup -whatif