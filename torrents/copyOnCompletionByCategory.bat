@echo off
:: setlocal enabledelayedexpansion allows for the use of dynamic variables within loops or conditionals.
setlocal enabledelayedexpansion

:: Arguments passed by qBittorrent
:: %1 is %F = content path. Add torrent name (%2 = %N) to the destination path. %3 is category = %L
set "torrent_folder=%1"
set "torrent_name=%2"
set "torrent_category=%3"

:: Define the destination base folder
set "base_path=T:\Music\Library"

:: Define subfolders based on category
:: /i forces string comparisons to ignore case. You can use /i on the string1==string2 form of if. These comparisons are generic, in that if both string1 and string2 are comprised of numeric digits only, the strings are converted to numbers and a numeric comparison is performed.
if /i "%torrent_category%"=="Music-BIGBOI" (
    set "category_path=Music5"
) else if /i "%torrent_category%"=="DBNine-Exclusives" (
    set "category_path=DB9 Exclusives"
) else if /i "%torrent_category%"=="Games" (
    ::set "category_path=Games"
) else (
    exit
    ::set "category_path=Others"
)

:: Define the full destination path
set "destination_folder=%base_path%\%category_path%\%torrent_name%"

:: Create destination directory if it doesn't exist
if not exist "%destination_folder%" (
    mkdir "%destination_folder%"
)

:: Copy the folder with its contents recursively
:: /e: Copy all subdirectories, including empty ones.
:: /i: If the destination doesn't exist and is copying more than one file, it assumes the destination is a directory.
:: /v verify that copied files are identical to source

xcopy /e /i /v "%torrent_folder%" "%destination_folder%"

:: Optional: Add logging
::echo Torrent folder %torrent_folder% copied to %destination_folder% >> "C:\Path\To\log.txt"

echo Done.
endlocal
