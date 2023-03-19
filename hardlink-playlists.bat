:: Disclaimer: this script is very hardcoded and setup specific !
:: Requirements:
:: - foo_runcmd and foo_run_main
:: - CMD must be the active window when launching the script, and foobar2000 the window right under it !
:: - Don't touch anything until the script is done running
:: - Set up the presets beforehand (with the File Operations full dialog box)
:: - Replace xxx in /run_main:"View/Switch to playlist/xxx" with the playlist name
:: - Replace yyy in /runcmd-playlist="File Operations/Link to/yyy" with the preset name
:: - Replace zzz in set "folder=zzz" with the correct folder name

:: The script switches to a playlist, selects all elements, then runs the Link (hardlink) operation on them following a given preset
:: Then it compares the number of items in the playlist to the number of music files (flac, aac, mp3, ogg, ac3) found in the destination folder
:: On the first iteration, it will ALT-Tab to foobar2000 and then press Enter, this allows to bypass the confirmation
:: dialog by pressing on "Run" automatically. For every other playlist, it will only press Enter (no Alt Tab).
:: There is a 10 sec delay between each playlist, increase it if necessary (for longer operations such as Move/Copy)
:: You can launch this script from foobar itself, by creating a Run Service with the path to the script

@echo off

:: Set variables, and switch to foobar2000 active window

set "foobar=C:\Program Files (x86)\foobar2000\foobar2000.exe"
set "log=R:\Radio\reports\count-comparison.txt"
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%%{TAB}');"

:: Section New music playlists

@echo on
"%foobar%" /run_main:"View/Switch to playlist/2023 & recently added 2022"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
REM Wait a moment for the clipboard to be populated
ping -n 2 127.0.0.1 >nul
rem Count lines in clipboard and assign to variable
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/best new music"
  ping -n 2 127.0.0.1 >nul
  powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
  ping -n 10 127.0.0.1 >nul
rem Count total number of files in each folder and compare with num_items
set "folder=R:\Radio\new\best new music"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" > %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/2023 - best tracks"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/2023 tracks"
  ping -n 2 127.0.0.1 >nul
  powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
  ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\new\best of 2023 (tracks)"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/2022 - best tracks"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/2022 tracks"
  ping -n 2 127.0.0.1 >nul
  powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
  ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\new\best of 2022 (tracks)"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/2021 - best tracks"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/2021 tracks"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\new\best of 2021 (tracks)"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Decades best of

@echo on
"%foobar%" /run_main:"View/Switch to playlist/1960s"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/best of 1960s"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\decades\best of 1960s"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Blues

@echo on
"%foobar%" /run_main:"View/Switch to playlist/blues"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/blues"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\blues\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/desert blues"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/blues (desert)"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\blues\desert"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Country & bluegrass

@echo on
"%foobar%" /run_main:"View/Switch to playlist/country & bluegrass"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/country & bluegrass"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\country\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Funk

@echo on
"%foobar%" /run_main:"View/Switch to playlist/funky"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/funky"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\funk\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/electro/future funk"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/funk (electro/future)"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\funk\electrofuture"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/afrobeat"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/afrobeat"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\funk\afrobeat"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/disco"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/disco"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\funk\disco"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/cumbia/calypso/salsa"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/cumbia/salsa/etc"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\funk\cumbia etc"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/modern funk"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/modern funk"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\funk\modern"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Regional playlists

@echo on
"%foobar%" /run_main:"View/Switch to playlist/francophonie"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/FR"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\francophonie"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/greece"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/greek"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\greece"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/italy"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/IT"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\italy"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/turkish"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/turkish"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\turkish"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/japanese"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/JP"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\japanese"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/africa (all)"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/AFRICA"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\africa\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/africa (west)"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/AFRICA west"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\africa\west"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/africa (central)"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/AFRICA central"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\africa\central"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/africa (ZA)"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/ZA"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\region-based\south africa"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Soundtracks

@echo on
"%foobar%" /run_main:"View/Switch to playlist/vgm"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/VGM"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\soundtracks\vgm\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/movies"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/kino"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\soundtracks\kino"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/TV"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/TV series"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\soundtracks\telly"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Hip Hop

@echo on
"%foobar%" /run_main:"View/Switch to playlist/HIP HOP (adjacent)"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/hip hop ALL"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\hip hop\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/Old School (<2000) US Hip Hop"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/hip hop old school"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\hip hop\old school"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/only real hip hop (US)"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/hip hop (real)"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\hip hop\real hip hop"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/Gangsta/trap/hardcore"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/hip hop (gangsta)"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\hip hop\gangsta"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/rap FR"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/Rap FR"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\hip hop\fr\rap"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/trip hop/jazzy hip hop/beats"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/beats"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\hip hop\beats"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/Hip Hop/beats FR"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/FR hip hop/beats"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\hip hop\fr\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Pop

@echo on
"%foobar%" /run_main:"View/Switch to playlist/pop music < 8mn"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/synthpop/electropop"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\pop\electro & synth"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Soul / R&B

@echo on
"%foobar%" /run_main:"View/Switch to playlist/vocal soul / R&B"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/vocal soul r&b"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\soul\vocal"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Jazz

@echo on
"%foobar%" /run_main:"View/Switch to playlist/jazzy things"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/jazz"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\jazz\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/classic jazz & greats"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/jazz (classic & greats)"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\jazz\classic\greats"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/latin jazz/bossa nova"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/latin jazz/bossa"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\jazz\latin"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/jazz manouche/gypsy"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/jazz manouche"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\jazz\manouche"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/ethio jazz"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/jazz ethio"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\jazz\fusion\ethio"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/jazz fusion"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/jazz fusion"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\jazz\fusion\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Rock

@echo on
"%foobar%" /run_main:"View/Switch to playlist/metal & hard rock"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/hard rock/metal"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\rock\metal\metal & hard rock"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/stoner & space rock"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/stoner/space rock"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\rock\stoner"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/pop rock/indie rock"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/pop rock"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\rock\pop"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/classic/dad rock"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/boomer rock"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\rock\classic"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Folk

@echo on
"%foobar%" /run_main:"View/Switch to playlist/folk"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/folk"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\folk\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/folk (western only)"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/folk (english)"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\folk\english"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Reggae & Dub

@echo on
"%foobar%" /run_main:"View/Switch to playlist/reggae & dub"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/reggae & dub"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\reggae\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

:: Section Electro

@echo on
"%foobar%" /run_main:"View/Switch to playlist/electronic (wide spectrum)"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/electro"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/drum & bass"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/drum & bass"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\dnb"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/jungle"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/jungle"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\jungle"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/dubstep"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/dubstep"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\dubstep"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/electro swing"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/electroswing"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\electroswing"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/IDM/techno/hard dance & house/breaks/tech house"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/IDM/techno/hard dance"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\idm"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/house/deep house/afro house"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/house"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\house\all"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/synthwave"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/synthwave"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\synthwave"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/chiptune"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/chiptune"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\chiptune"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/trance/psytrance"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/trance"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\trance"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/future bass, trap & EDM"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/future bass"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\future bass"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

@echo on
"%foobar%" /run_main:"View/Switch to playlist/psybient / afro bass / tribal / ambient"
@echo off
"%foobar%" /run_main:"Edit/Select all"
powershell.exe -Command "Set-Clipboard -Value $null"
"%foobar%" /runcmd-playlist="Utilities/Text Tools/Copy: Title"
ping -n 2 127.0.0.1 >nul
for /f %%a in ('powershell.exe -Command "(Get-Clipboard).Length"') do set "num_items=%%a"
"%foobar%" /runcmd-playlist="File Operations/Link to/psybient & tribal"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul
set "folder=R:\Radio\genre-based\electro\psybient & tribal"
for /f %%a in ('powershell.exe -Command "Get-ChildItem -Path '%folder%' -Recurse -File -Include *.flac,*.m4a,*.mp3,*.ogg,*.ac3 | Measure-Object | Select-Object -ExpandProperty Count"') do set "num_files=%%a"
if %num_files% equ %num_items% (
  echo "All good ! %num_items% items in the playlist = %num_files% files in folder"
) else (
  echo "%folder% WARNIING %num_items% items in the playlist, but %num_files% files were found" >> %log%
)

type %log%
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%%{TAB}');"
echo "All playlists hardlinked to folders"
pause
