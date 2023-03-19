# Define function to get item count and compare with file count
function Compare-ItemCount($playlist, $folder, $linkto, $log) {
  # Switch to playlist and select all items
  & $foobar /run_main:"View/Switch to playlist/$playlist"
  & $foobar /run_main:"Edit/Select all"
  # Copy item titles to clipboard
  powershell.exe -Command "Set-Clipboard -Value $null"
  & $foobar "/runcmd-playlist=Utilities/Text Tools/Copy: Title"
  # Wait for clipboard to be populated
  Start-Sleep -Seconds 2
  # Count number of items in clipboard
  $num_items = [System.Windows.Forms.Clipboard]::GetText().Split("`n").Count
  # Create a symbolic link from the selected files to the target folder
  & $foobar "/runcmd-playlist=File Operations/Link to/$linkto"
  # Wait for the link to be created
  Start-Sleep -Seconds 2
  # Press enter to confirm the link creation
  [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
  # Wait for the link to be created
  Start-Sleep -Seconds 10
  # Count total number of files in each folder and compare with num_items
  $num_files = (Get-ChildItem -Path $folder -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3).Count
  if ($num_files -eq $num_items) {
    Write-Host "All good ! $num_items items in the playlist = $num_files files in folder"
  } else {
    Write-Output "$folder WARNING $num_items items in the playlist, but $num_files files were found" | Out-File $log -Append
  }
}

# Set variables and switch to foobar2000 active window
$foobar = "C:\Program Files (x86)\foobar2000\foobar2000.exe"
$log = "R:\Radio\reports\count-comparison.txt"
[System.Windows.Forms.SendKeys]::SendWait("%{TAB}")

# Call function for each playlist
Compare-ItemCount "2023 & recently added 2022" "R:\Radio\new\best new music" "best new music" $log
Compare-ItemCount "2023 - best tracks" "R:\Radio\new\best of 2023 (tracks)" "2023 tracks" $log
Compare-ItemCount "1960s" "R:\Radio\decades\best of 1960s" "best of 1960s" $log
