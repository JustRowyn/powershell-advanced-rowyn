# Find all public function files
$publicFunctions = Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" -ErrorAction SilentlyContinue

# Load (dot-source) each public function file
foreach ($file in $publicFunctions) {
    . $file.FullName
}

# Export only the public functions
Export-ModuleMember -Function $publicFunctions.BaseName