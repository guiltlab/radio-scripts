# Check all files in target dirs ($directoriesToCheck) for hardlinks pointing to Reference Dir. If any file does not have a hardlink pointing to RefDir, delete it
# Working as of 2024-07-09
# Known issue: deletion might fail if file path is super long/with diacritics

# Define the directories to check
$directoriesToCheck = @(
    "D:\Radio\new\",
	"D:\Radio\soundtracks\",
    "D:\Radio\genre-based\electro\",
	#"D:\Radio\genre-based\electro\dnb\",
	#"D:\Radio\genre-based\electro\synthwave\",
	#"D:\Radio\genre-based\electro\chiptune\",
    #"D:\Radio\genre-based\electro\electroswing\",
	#"D:\Radio\genre-based\electro\EDM\all\",
	#"D:\Radio\genre-based\electro\trance\",
	#"D:\Radio\genre-based\electro\house\all\",
    #"D:\Radio\genre-based\electro\psybient & tribal\",
    "D:\Radio\genre-based\funk\"
	#"D:\Radio\genre-based\",
	#"D:\Radio\region-based\",
	#"D:\Radio\decades\",
	#"D:\Radio\everything-except-OST\"
)

# Define the reference directory
$referenceDirectory = "\Radio\everything\"

# Function to get hardlink list
function Get-HardlinkList {
    param (
        [string]$filePath
    )
    # Use fsutil to get hardlink information
    $output = cmd /c "fsutil hardlink list `"$filePath`""
    return $output
}

# Store files marked for deletion
$filesToDelete = @()

# Check each file in the specified directories
foreach ($dir in $directoriesToCheck) {
    Write-Host "processing" $dir
    $files = Get-ChildItem -Recurse -File -Path $dir
    foreach ($file in $files) {
        $fileHardlinks = Get-HardlinkList -filePath $file.FullName
        $deleteFile = $true
        foreach ($hardlink in $fileHardlinks) {
            # Check if the hardlink contains the reference directory
            if ($hardlink.Contains($referenceDirectory)) {
                $deleteFile = $false
                break
            }
        }
        if ($deleteFile) {
            $filesToDelete += $file.FullName
        }
    }
}

# List the files that will be deleted
if ($filesToDelete.Count -gt 0) {
    Write-Output "The following "$filesToDelete.Count " files will be deleted:"
    $filesToDelete | ForEach-Object { Write-Output $_ }

    # Prompt for confirmation
    $confirmation = Read-Host "Do you want to proceed with deletion? (Y/N)"
    if ($confirmation -eq 'Y') {
        # Delete the files using System.IO.File.Delete
        foreach ($fileToDelete in $filesToDelete) {
            try {
                if (Test-Path $fileToDelete) {
                    [System.IO.File]::Delete($fileToDelete)
                } else {
                    Write-Warning "File not found: $fileToDelete"
                }
            } catch {
                 Write-Warning "Failed to delete" $fileToDelete
            }
        }
        Write-Output "Files deleted."
    } else {
        Write-Output "Deletion aborted."
    }
} else {
    Write-Output "No files to delete."
}