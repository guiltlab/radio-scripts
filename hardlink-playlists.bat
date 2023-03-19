:: Disclaimer: this script is very hardcoded and setup specific !
:: Requirements:
:: - foo_runcmd and foo_run_main
:: - CMD must be the active window when launching the script, and foobar2000 the window right under it !
:: - Don't touch anything until the script is done running
:: - Set up the presets beforehand (with the File Operations full dialog box)
:: - Replace xxx in /run_main:"View/Switch to playlist/xxx" with the playlist name
:: - Replace yyy in /runcmd-playlist="File Operations/Link to/yyy" with the preset name

:: The script switches to a playlist, selects all elements, then runs the Link (hardlink) operation on them following a given preset
:: On the first iteration, it will ALT-Tab to foobar2000 and then press Enter, this allows to bypass the confirmation
:: dialog by pressing on "Run" automatically. For every other playlist, it will only press Enter (no Alt Tab).
:: There is a 20 sec delay between each playlist, increase it if necessary (for longer operations such as Move/Copy)

@echo off

:: Set variables, and switch to foobar2000 active window

set "foobar=C:\Program Files (x86)\foobar2000\foobar2000.exe"
set "log=R:\Radio\reports\count-comparison.txt"
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%%{TAB}');"

:: Section New music playlists

@echo on
"%foobar%" /run_main:"View/Switch to playlist/2023 & recently added 2022"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
ping -n 1 127.0.0.1 >nul
  "%foobar%" /runcmd-playlist="File Operations/Link to/best new music"
  ping -n 2 127.0.0.1 >nul
  powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
  ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/2023 - best tracks"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/2023 tracks"
  ping -n 2 127.0.0.1 >nul
  powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
  ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/2022 - best tracks"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/2022 tracks"
  ping -n 2 127.0.0.1 >nul
  powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
  ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/2021 - best tracks"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/2021 tracks"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

:: Section Decades best of

@echo on
"%foobar%" /run_main:"View/Switch to playlist/1960s"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/best of 1960s"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

:: Section Blues

@echo on
"%foobar%" /run_main:"View/Switch to playlist/blues"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/blues"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/desert blues"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/blues (desert)"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

:: Section Country & bluegrass

@echo on
"%foobar%" /run_main:"View/Switch to playlist/country & bluegrass"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/country & bluegrass"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

:: Section Funk

@echo on
"%foobar%" /run_main:"View/Switch to playlist/funky"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/funky"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/electro/future funk"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/funk (electro/future)"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/afrobeat"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/afrobeat"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/disco"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/disco"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/cumbia/calypso/salsa"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/cumbia/salsa/etc"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/modern funk"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/modern funk"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

:: Section Regional playlists

@echo on
"%foobar%" /run_main:"View/Switch to playlist/francophonie"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/FR"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/greece"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/greek"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/italy"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/IT"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/turkish"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/turkish"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/japanese"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/JP"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/africa (all)"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/AFRICA"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/africa (west)"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/AFRICA west"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/africa (central)"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/AFRICA central"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

@echo on
"%foobar%" /run_main:"View/Switch to playlist/africa (ZA)"
@echo off
ping -n 1 127.0.0.1 >nul
"%foobar%" /run_main:"Edit/Select all"
 ping -n 1 127.0.0.1 >nul
"%foobar%" /runcmd-playlist="File Operations/Link to/ZA"
ping -n 2 127.0.0.1 >nul
powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}');"
ping -n 10 127.0.0.1 >nul

type %log%

powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%%{TAB}');"

pause
