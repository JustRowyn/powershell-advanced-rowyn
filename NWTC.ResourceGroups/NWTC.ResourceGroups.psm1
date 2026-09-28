# Find all public and private function files
$publicFunctions  = Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1"  -ErrorAction SilentlyContinue
$privateFunctions = Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" -ErrorAction SilentlyContinue

# Load (dot-source) each private function file
foreach ($file in $privateFunctions) {
    . $file.FullName
}

# Load (dot-source) each public function file
foreach ($file in $publicFunctions) {
    . $file.FullName
}

# Export ONLY the public functions (private functions stay hidden)
Export-ModuleMember -Function $publicFunctions.BaseName