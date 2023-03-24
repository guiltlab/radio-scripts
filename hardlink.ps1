# Define function to get item count and compare with file count
Add-Type -AssemblyName System.Windows.Forms
function Compare-ItemCount($playlist, $folder, $linkto, $log) {
  # Switch to playlist and select all items
  & $foobar /run_main:"View/Switch to playlist/$playlist"
  Start-Sleep -Seconds 0.5
  & $foobar /run_main:"Edit/Select all"
  # Empty clipboard, copy item titles and wait for clipboard to be populated
  Start-Sleep -Seconds 0.5
  Set-Clipboard -Value $null
  & $foobar "/runcmd-playlist=Utilities/Text Tools/Copy: Title"
  Start-Sleep -Seconds 2
  # Create a hardlink from the selected files to the target folder
  & $foobar "/runcmd-playlist=File Operations/Link to/$linkto"
  # Wait for the confirmation dialog to show
  Start-Sleep -Seconds 1.5
  # Press enter to confirm the link creation
  [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
  # Wait for the link to be created and for clipboard to be populated
  Start-Sleep -Seconds 5
  # Count number of items in clipboard
  $num_items = (Get-Clipboard).Length
  # Count total number of files in each folder and compare with num_items
  $num_files = (Get-ChildItem -Path $folder -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3).Count
  if ($num_files -eq $num_items) {
    Write-Host "All good ! $num_items items in  $playlist = $num_files files in $folder"
  } else {
    Write-Output "$folder WARNING $num_items items in $playlist, but $num_files files were found" | Out-File $log -Append
  }
}

# Set variables and switch to foobar2000 active window
$foobar = "C:\Program Files (x86)\foobar2000\foobar2000.exe"
$log = "R:\Radio\reports\count-comparison.txt"
[System.Windows.Forms.SendKeys]::SendWait("%{TAB}")

# Empty log file
Set-Content -Path $log -Value ""

# Call function for each playlist

## Section: new music, best of decades
Compare-ItemCount "2023 - best tracks" "R:\Radio\new\best of 2023 (tracks)" "2023 tracks" $log
Compare-ItemCount "2022 - best tracks" "R:\Radio\new\best of 2022 (tracks)" "2022 tracks" $log
Compare-ItemCount "2021 - best tracks" "R:\Radio\new\best of 2021 (tracks)" "2021 tracks" $log
Compare-ItemCount "1960s" "R:\Radio\decades\best of 1960s" "best of 1960s" $log

## Section: blues, country, bluegrass
Compare-ItemCount "blues" "R:\Radio\genre-based\blues\all" "blues" $log
Compare-ItemCount "desert blues" "R:\Radio\genre-based\blues\desert" "blues (desert)" $log
Compare-ItemCount "country & bluegrass" "R:\Radio\genre-based\country\all" "country & bluegrass" $log

## Section: funky
Compare-ItemCount "funky" "R:\Radio\genre-based\funk\all" "funky" $log
Compare-ItemCount "electro/future funk" "R:\Radio\genre-based\funk\electrofuture" "funk (electro/future)" $log
Compare-ItemCount "afrobeat" "R:\Radio\genre-based\funk\afrobeat" "afrobeat" $log
Compare-ItemCount "disco" "R:\Radio\genre-based\funk\disco" "disco" $log
Compare-ItemCount "cumbia/calypso/salsa" "R:\Radio\genre-based\funk\cumbia etc" "cumbia/salsa/etc" $log
Compare-ItemCount "modern funk" "R:\Radio\genre-based\funk\modern" "modern funk" $log

## Section: regions
Compare-ItemCount "francophonie" "R:\Radio\region-based\francophonie" "FR" $log
Compare-ItemCount "greece" "R:\Radio\region-based\greece" "greek" $log
Compare-ItemCount "italy" "R:\Radio\region-based\italy" "IT" $log
Compare-ItemCount "turkish" "R:\Radio\region-based\turkish" "turkish" $log
Compare-ItemCount "japanese" "R:\Radio\region-based\japanese" "JP" $log
Compare-ItemCount "africa (all)" "R:\Radio\region-based\africa\all" "AFRICA" $log
Compare-ItemCount "africa (west)" "R:\Radio\region-based\africa\west" "AFRICA (west)" $log
Compare-ItemCount "africa (central)" "R:\Radio\region-based\africa\central" "AFRICA central" $log
Compare-ItemCount "africa (ZA)" "R:\Radio\region-based\south africa" "ZA" $log

## Section: soundtracks
Compare-ItemCount "vgm" "R:\Radio\soundtracks\vgm\all" "VGM" $log
Compare-ItemCount "movies" "R:\Radio\soundtracks\kino" "kino" $log
Compare-ItemCount "TV" "R:\Radio\soundtracks\telly" "TV series" $log

## Section: hip hop
Compare-ItemCount "HIP HOP (adjacent)" "R:\Radio\genre-based\hip hop\all" "hip hop ALL" $log
Compare-ItemCount "Old School (<2000) US Hip Hop" "R:\Radio\genre-based\hip hop\old school" "hip hop old school" $log
Compare-ItemCount "only real hip hop (US)" "R:\Radio\genre-based\hip hop\real hip hop" "hip hop (real)" $log
Compare-ItemCount "Gangsta/trap/hardcore" "R:\Radio\genre-based\hip hop\gangsta" "hip hop (gangsta)" $log
Compare-ItemCount "rap FR" "R:\Radio\genre-based\hip hop\fr\rap" "Rap FR" $log
Compare-ItemCount "trip hop/jazzy hip hop/beats" "R:\Radio\genre-based\hip hop\beats" "beats" $log
Compare-ItemCount "Hip Hop/beats FR" "R:\Radio\genre-based\hip hop\fr\all" "FR hip hop/beats" $log

## Section: pop, soul, R&B
Compare-ItemCount "pop music < 8mn" "R:\Radio\genre-based\pop\electro & synth" "synthpop/electropop" $log
Compare-ItemCount "vocal soul / R&B" "R:\Radio\genre-based\soul\vocal" "vocal soul r&b" $log

## Section: jazz
Compare-ItemCount "jazzy things" "R:\Radio\genre-based\jazz\all" "jazz" $log
Compare-ItemCount "classic jazz & greats" "R:\Radio\genre-based\jazz\classic\greats" "jazz (classic & greats)" $log
Compare-ItemCount "latin jazz/bossa nova" "R:\Radio\genre-based\jazz\latin" "latin jazz/bossa" $log
Compare-ItemCount "jazz manouche/gypsy" "R:\Radio\genre-based\jazz\manouche" "jazz manouche" $log
Compare-ItemCount "ethio jazz" "R:\Radio\genre-based\jazz\fusion\ethio" "jazz ethio" $log
Compare-ItemCount "jazz fusion" "R:\Radio\genre-based\jazz\fusion\all" "jazz fusion" $log

## Section: rock
Compare-ItemCount "metal & hard rock" "R:\Radio\genre-based\rock\metal\metal & hard rock" "hard rock/metal" $log
Compare-ItemCount "stoner & space rock" "R:\Radio\genre-based\rock\stoner" "stoner/space rock" $log
Compare-ItemCount "pop rock/indie rock" "R:\Radio\genre-based\rock\pop" "pop rock" $log
Compare-ItemCount "classic/dad rock" "R:\Radio\genre-based\rock\classic" "boomer rock" $log

## Section: folk
Compare-ItemCount "folk" "R:\Radio\genre-based\folk\all" "folk" $log
Compare-ItemCount "folk (western only)" "R:\Radio\genre-based\folk\english" "folk (english)" $log

## Section: reggae, dub
Compare-ItemCount "reggae & dub" "R:\Radio\genre-based\reggae\all" "reggae & dub" $log

## Section: electro
Compare-ItemCount "electronic (wide spectrum)" "R:\Radio\genre-based\electro\all" "electro" $log
Compare-ItemCount "drum & bass" "R:\Radio\genre-based\electro\dnb" "drum & bass" $log
Compare-ItemCount "jungle" "R:\Radio\genre-based\electro\jungle" "jungle" $log
Compare-ItemCount "dubstep" "R:\Radio\genre-based\electro\dubstep" "dubstep" $log
Compare-ItemCount "electro swing" "R:\Radio\genre-based\electro\electroswing" "electroswing" $log
Compare-ItemCount "IDM/techno/hard dance & house/breaks/tech house" "R:\Radio\genre-based\electro\idm" "IDM/techno/hard dance" $log
Compare-ItemCount "house/deep house/afro house" "R:\Radio\genre-based\electro\house\all" "house" $log
Compare-ItemCount "synthwave" "R:\Radio\genre-based\electro\synthwave" "synthwave" $log
Compare-ItemCount "chiptune" "R:\Radio\genre-based\electro\chiptune" "chiptune" $log
Compare-ItemCount "trance/psytrance" "R:\Radio\genre-based\electro\trance" "trance" $log
Compare-ItemCount "future bass, trap & EDM" "R:\Radio\genre-based\electro\future bass" "future bass" $log
Compare-ItemCount "psybient / afro bass / tribal / ambient" "R:\Radio\genre-based\electro\psybient & tribal" "psybient & tribal" $log

# Focus console window
[System.Windows.Forms.SendKeys]::SendWait("%{TAB}")

# Display log
Get-Content $log
Read-Host -Prompt "Press Enter to continue..."
