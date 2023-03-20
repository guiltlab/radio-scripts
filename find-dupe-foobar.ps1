# Copy info from all selected tracks in foobar and return duplicate entries

$foobar = "C:\Program Files (x86)\foobar2000\foobar2000.exe"
& $foobar "/runcmd-playlist=Utilities/Text Tools/Copy: Title"
& Write-Output "Duplicates (Artist - Title)"
& Get-Clipboard | Group-Object | Where-Object Count -gt 1 | Select-Object -ExpandProperty Group | Sort-Object | Get-Unique
& Set-Clipboard -Value $null
& $foobar "/runcmd-playlist=Utilities/Text Tools/Copy: Artist - Title - Album"
& Write-Output "Duplicates (Artist - Title - Album)"
& Get-Clipboard | Group-Object | Where-Object Count -gt 1 | Select-Object -ExpandProperty Group | Sort-Object | Get-Unique

Read-Host -Prompt "Press Enter to continue..."
