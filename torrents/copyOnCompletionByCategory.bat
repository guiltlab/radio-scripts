@echo off
setlocal enabledelayedexpansion

:: Arguments passed by qBittorrent
:: %1 is %F = content path. Add torrent name (%2 = %N) to the destination path. %3 is category = %L. Use tilde to remove quotes.
set "torrent_folder=%~1"
set "torrent_name=%~2"
set "torrent_category=%~3"

echo folder: "%torrent_folder%"
echo name: "%torrent_name%"
echo cat: "%torrent_category%"
:: remove quotes before using as path
::set torrent_name=%torrent_name:"=%

:: Define the destination base folder
set "base_path=T:\Music\Library"
echo %base_path%

:: Define subfolders based on category & copy if matching category

if /i "%torrent_category%"=="Music-BIGBOI" (
pause
    set "category_path=Music5"
echo cat set

:: Define the full destination path - NO quotes in variables otherwise they will stay in the path string
echo %base_path%
set destination_folder=%base_path%
echo "%destination_folder%"
echo Copying to "%destination_folder%"
set "destination_folder=%base_path%\%category_path%\%torrent_name%"
echo Copying to "%destination_folder%"
    pause
:: Copy the folder with its contents recursively (destination folder needs quotes, torrent folder already has them passed on)
:: xcopy /e /i /v "%torrent_folder%" "%destination_folder%"

:: Optional: Add logging
echo Torrent folder "%torrent_folder%" copied to "%destination_folder%" >> "C:\scripts\log.txt"

echo Done.
pause

)
pause
endlocal
