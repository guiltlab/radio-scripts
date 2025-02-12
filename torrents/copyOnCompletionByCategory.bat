@echo off
setlocal enabledelayedexpansion

:: Arguments passed by qBittorrent
:: %1 is %F = content path. Add torrent name (%2 = %N) to the destination path. %3 is category = %L
set torrent_folder=%1
set torrent_name=%2
set torrent_category=%3

echo folder: %torrent_folder%
echo name: %torrent_name%
echo cat: %torrent_category%
:: remove quotes before using as path
::set torrent_name=%torrent_name:"=%


:: Define the destination base folder
set "base_path=T:\Music\Library"

:: Define subfolders based on category
echo %torrent_category%

if /i %torrent_category%=="Music-BIGBOI" (
    pause
    set "category_path=Music5"
    echo "Music5!"
)
pause

:: Define the full destination path
set "destination_folder=%base_path%\%category_path%\%torrent_name%"
echo dest: %destination_folder%
pause
:: Create destination directory if it doesn't exist
if not exist "%destination_folder%" (
    mkdir "%destination_folder%"
	echo "folder created"
)

:: Copy the folder with its contents recursively
xcopy /e /i /v %torrent_folder% %destination_folder%

:: Optional: Add logging
echo Torrent folder %torrent_folder% copied to %destination_folder% >> "C:\scripts\log.txt"

echo Done.
pause
endlocal
