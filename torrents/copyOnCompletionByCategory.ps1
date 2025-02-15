# This script calls fastcopy to copy files according to presets based on qbit category
# Command to put in qbit's external program run field:
# powershell.exe -noexit -ExecutionPolicy Bypass -File "C:\scripts\copyOnCompletionByCategory.ps1" "%F" "%N" "%L"

# Define category-to-folder mappings
$CategoryMappings = @{
    "Music-BIGBOI" = "T:\Music\Library\Music5"
    # Add more categories here as needed
# this mapping is usless with fastcopy, modify when necessary to add more category decisions
}

# Get command-line arguments
$ContentPath = $args[0]  # %F - Full path to the content folder
$TorrentName = $args[1]  # %N - Torrent name
$Category = $args[2]     # %L - Category

Write-Host "Received arguments:"
Write-Host "ContentPath: $ContentPath"
Write-Host "Testing path: '$ContentPath'"
Test-Path -LiteralPath $ContentPath
Write-Host "Category: $Category"

# Ensure category exists in mappings
if ($CategoryMappings.ContainsKey($Category)) {
    $TargetFolder = $CategoryMappings[$Category]

    # Define source and destination paths
    $SourcePath = $ContentPath
    $DestinationPath = Join-Path -Path $TargetFolder -ChildPath (Split-Path -Leaf $ContentPath)

    Write-Host "SourcePath: $SourcePath"
    Write-Host "DestinationPath: $DestinationPath"

    # Ensure source exists before copying
    #if (!(Test-Path -Path $SourcePath)) {
    #    Write-Host "Source path does not exist: $SourcePath"
    #    exit 1
    #}

    # Create destination directory if it doesn't exist
    if (!(Test-Path -Path $DestinationPath)) {
        Write-Host "Creating destination directory: $DestinationPath"
        New-Item -ItemType Directory -Path $DestinationPath -Force | Out-Null
    }

    # Perform copy operation
    try {
#        Copy-Item -Path "$SourcePath\*" -Destination $DestinationPath -Recurse -Force
& "C:\Users\xxxxxxx\FastCopy\fcp.exe" "/job=Backup_Music5_to_T"
        Write-Host "Successfully copied '$SourcePath' to '$DestinationPath'"
    } catch {
        Write-Host "Failed to copy '$SourcePath' to '$DestinationPath': $_"
    }
} else {
    Write-Host "Category '$Category' not in mapping. No action taken."
}
