:: this script exectues sox -n stats on every FLAC present in a folder selected in foobar2000, by using the Run Service option
:: this is useful to detect bit padding, if a file is really 24 bit it will show 24/24, if it's padded with zeroes it will show 16/16
:: Run Service Path: "C:\path\soxpadding.bat" "%path%"
:: this does NOT work on files that have unicode characters in their path

@echo off

set "folder_path=%~dp1"

for %%F in ("%folder_path%\*.flac") do (
	echo Processing file: "%%~nxF"
    sox "%%F" -n stats 2>&1 | findstr /C:"Bit-depth" /C:"Overall"
)

pause