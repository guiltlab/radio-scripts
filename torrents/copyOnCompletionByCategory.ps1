# Define category-to-folder mappings
$CategoryMappings = @{
    "Music-BIGBOI" = "T:\Music\Library\Music5"
    # Add more categories here as needed
}

# Get command-line arguments
$ContentPath = $args[0]  # %F - Full path to the content folder
$TorrentName = $args[1]  # %N - Torrent name
$Category = $args[2]     # %L - Category
# Write-Host cat becomes $Category 
# Write-Host name becomes $TorrentName
# Write-Host path becomes $ContentPath 

# Ensure category exists in mappings
if ($CategoryMappings.ContainsKey($Category)) {
    $TargetFolder = $CategoryMappings[$Category]
    
    # Create the target directory if it doesn't exist
    if (!(Test-Path -Path $TargetFolder)) {
        New-Item -ItemType Directory -Path $TargetFolder -Force | Out-Null
    }
    
    # Define source and destination paths
    $SourcePath = $ContentPath
    $DestinationPath = Join-Path -Path $TargetFolder -ChildPath (Split-Path -Leaf $ContentPath)
    
    # Perform copy operation
    try {
        Copy-Item -Path $SourcePath -Destination $DestinationPath -Recurse -Force
        Write-Host "Successfully copied '$SourcePath' to '$DestinationPath'"
    } catch {
        Write-Host "Failed to copy '$SourcePath' to '$DestinationPath': $_"
    }
} else {
    Write-Host "Category '$Category' not in mapping. No action taken."
}
